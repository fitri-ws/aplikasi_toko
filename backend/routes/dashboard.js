const express = require('express');
const db = require('../config/database');
const { authMiddleware, adminMiddleware } = require('../middleware/auth');
const router = express.Router();

// Get dashboard statistics (admin only)
router.get('/stats', authMiddleware, adminMiddleware, async (req, res) => {
    try {
        // Total users
        const [userCount] = await db.query('SELECT COUNT(*) as count FROM users WHERE role = "user"');

        // Total orders
        const [orderCount] = await db.query('SELECT COUNT(*) as count FROM orders');

        // Total revenue
        const [revenue] = await db.query('SELECT SUM(total_amount) as total FROM orders WHERE status != "cancelled"');

        // Total products
        const [productCount] = await db.query('SELECT COUNT(*) as count FROM smartphones');

        // Recent orders
        const [recentOrders] = await db.query(`
      SELECT o.*, u.username, u.full_name
      FROM orders o
      JOIN users u ON o.user_id = u.id
      ORDER BY o.created_at DESC
      LIMIT 10
    `);

        // Top selling products
        const [topProducts] = await db.query(`
      SELECT s.*, SUM(oi.quantity) as total_sold
      FROM smartphones s
      JOIN order_items oi ON s.id = oi.smartphone_id
      GROUP BY s.id
      ORDER BY total_sold DESC
      LIMIT 5
    `);

        // Sales by brand
        const [salesByBrand] = await db.query(`
      SELECT s.brand, COUNT(oi.id) as sales_count, SUM(oi.quantity) as total_quantity
      FROM smartphones s
      JOIN order_items oi ON s.id = oi.smartphone_id
      GROUP BY s.brand
      ORDER BY sales_count DESC
    `);

        // Orders by status
        const [ordersByStatus] = await db.query(`
      SELECT status, COUNT(*) as count
      FROM orders
      GROUP BY status
    `);

        res.json({
            totalUsers: userCount[0].count,
            totalOrders: orderCount[0].count,
            totalRevenue: revenue[0].total || 0,
            totalProducts: productCount[0].count,
            recentOrders,
            topProducts,
            salesByBrand,
            ordersByStatus
        });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Server error' });
    }
});

module.exports = router;
