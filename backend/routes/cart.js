const express = require('express');
const db = require('../config/database');
const { authMiddleware } = require('../middleware/auth');
const router = express.Router();

// Get user's cart
router.get('/', authMiddleware, async (req, res) => {
    try {
        const [items] = await db.query(`
      SELECT c.*, s.name, s.brand, s.price, s.image_url, s.stock
      FROM cart c
      JOIN smartphones s ON c.smartphone_id = s.id
      WHERE c.user_id = ?
    `, [req.user.id]);

        res.json(items);
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Server error' });
    }
});

// Add to cart
router.post('/', authMiddleware, async (req, res) => {
    try {
        const { smartphone_id, quantity } = req.body;

        // Check if item already in cart
        const [existing] = await db.query(
            'SELECT * FROM cart WHERE user_id = ? AND smartphone_id = ?',
            [req.user.id, smartphone_id]
        );

        if (existing.length > 0) {
            // Update quantity
            await db.query(
                'UPDATE cart SET quantity = quantity + ? WHERE user_id = ? AND smartphone_id = ?',
                [quantity, req.user.id, smartphone_id]
            );
        } else {
            // Insert new item
            await db.query(
                'INSERT INTO cart (user_id, smartphone_id, quantity) VALUES (?, ?, ?)',
                [req.user.id, smartphone_id, quantity]
            );
        }

        res.json({ message: 'Item added to cart' });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Server error' });
    }
});

// Update cart item quantity
router.put('/:id', authMiddleware, async (req, res) => {
    try {
        const { quantity } = req.body;

        await db.query(
            'UPDATE cart SET quantity = ? WHERE id = ? AND user_id = ?',
            [quantity, req.params.id, req.user.id]
        );

        res.json({ message: 'Cart updated' });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Server error' });
    }
});

// Remove from cart
router.delete('/:id', authMiddleware, async (req, res) => {
    try {
        await db.query(
            'DELETE FROM cart WHERE id = ? AND user_id = ?',
            [req.params.id, req.user.id]
        );

        res.json({ message: 'Item removed from cart' });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Server error' });
    }
});

module.exports = router;
