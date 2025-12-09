const express = require('express');
const db = require('../config/database');
const { authMiddleware, adminMiddleware } = require('../middleware/auth');
const router = express.Router();

// Get user's orders
router.get('/', authMiddleware, async (req, res) => {
    try {
        const [orders] = await db.query(`
      SELECT o.*, 
             COUNT(oi.id) as item_count
      FROM orders o
      LEFT JOIN order_items oi ON o.id = oi.order_id
      WHERE o.user_id = ?
      GROUP BY o.id
      ORDER BY o.created_at DESC
    `, [req.user.id]);

        res.json(orders);
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Server error' });
    }
});

// Get all orders (admin only)
router.get('/all', authMiddleware, adminMiddleware, async (req, res) => {
    try {
        const [orders] = await db.query(`
      SELECT o.*, u.username, u.full_name,
             COUNT(oi.id) as item_count
      FROM orders o
      JOIN users u ON o.user_id = u.id
      LEFT JOIN order_items oi ON o.id = oi.order_id
      GROUP BY o.id
      ORDER BY o.created_at DESC
    `);

        res.json(orders);
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Server error' });
    }
});

// Get order details
router.get('/:id', authMiddleware, async (req, res) => {
    try {
        const [orders] = await db.query(
            'SELECT * FROM orders WHERE id = ? AND user_id = ?',
            [req.params.id, req.user.id]
        );

        if (orders.length === 0) {
            return res.status(404).json({ message: 'Order not found' });
        }

        const [items] = await db.query(`
      SELECT oi.*, s.name, s.brand, s.image_url
      FROM order_items oi
      JOIN smartphones s ON oi.smartphone_id = s.id
      WHERE oi.order_id = ?
    `, [req.params.id]);

        res.json({ ...orders[0], items });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Server error' });
    }
});

// Create order from cart
router.post('/', authMiddleware, async (req, res) => {
    const connection = await db.getConnection();

    try {
        await connection.beginTransaction();

        const { shipping_address } = req.body;

        // Get cart items
        const [cartItems] = await connection.query(`
      SELECT c.*, s.price, s.stock
      FROM cart c
      JOIN smartphones s ON c.smartphone_id = s.id
      WHERE c.user_id = ?
    `, [req.user.id]);

        if (cartItems.length === 0) {
            await connection.rollback();
            return res.status(400).json({ message: 'Cart is empty' });
        }

        // Check stock
        for (const item of cartItems) {
            if (item.stock < item.quantity) {
                await connection.rollback();
                return res.status(400).json({
                    message: `Insufficient stock for ${item.name}`
                });
            }
        }

        // Calculate total
        const total = cartItems.reduce((sum, item) => sum + (item.price * item.quantity), 0);

        // Create order
        const [orderResult] = await connection.query(
            'INSERT INTO orders (user_id, total_amount, shipping_address) VALUES (?, ?, ?)',
            [req.user.id, total, shipping_address]
        );

        const orderId = orderResult.insertId;

        // Create order items and update stock
        for (const item of cartItems) {
            await connection.query(
                'INSERT INTO order_items (order_id, smartphone_id, quantity, price) VALUES (?, ?, ?, ?)',
                [orderId, item.smartphone_id, item.quantity, item.price]
            );

            await connection.query(
                'UPDATE smartphones SET stock = stock - ? WHERE id = ?',
                [item.quantity, item.smartphone_id]
            );
        }

        // Clear cart
        await connection.query('DELETE FROM cart WHERE user_id = ?', [req.user.id]);

        await connection.commit();

        res.status(201).json({
            message: 'Order created successfully',
            orderId
        });
    } catch (error) {
        await connection.rollback();
        console.error(error);
        res.status(500).json({ message: 'Server error' });
    } finally {
        connection.release();
    }
});

// Update order status (admin only)
router.put('/:id/status', authMiddleware, adminMiddleware, async (req, res) => {
    try {
        const { status } = req.body;

        await db.query(
            'UPDATE orders SET status = ? WHERE id = ?',
            [status, req.params.id]
        );

        res.json({ message: 'Order status updated' });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Server error' });
    }
});

module.exports = router;
