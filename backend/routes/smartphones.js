const express = require('express');
const db = require('../config/database');
const { authMiddleware, adminMiddleware } = require('../middleware/auth');
const router = express.Router();

// Get all smartphones (public)
router.get('/', async (req, res) => {
    try {
        const [smartphones] = await db.query(`
      SELECT s.*, 
             COALESCE(AVG(r.rating), 0) as avg_rating,
             COUNT(r.id) as review_count
      FROM smartphones s
      LEFT JOIN reviews r ON s.id = r.smartphone_id
      GROUP BY s.id
      ORDER BY s.created_at DESC
    `);
        res.json(smartphones);
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Server error' });
    }
});

// Get smartphone by ID
router.get('/:id', async (req, res) => {
    try {
        const [smartphones] = await db.query(`
      SELECT s.*, 
             COALESCE(AVG(r.rating), 0) as avg_rating,
             COUNT(r.id) as review_count
      FROM smartphones s
      LEFT JOIN reviews r ON s.id = r.smartphone_id
      WHERE s.id = ?
      GROUP BY s.id
    `, [req.params.id]);

        if (smartphones.length === 0) {
            return res.status(404).json({ message: 'Smartphone not found' });
        }

        // Get reviews
        const [reviews] = await db.query(`
      SELECT r.*, u.username, u.full_name
      FROM reviews r
      JOIN users u ON r.user_id = u.id
      WHERE r.smartphone_id = ?
      ORDER BY r.created_at DESC
    `, [req.params.id]);

        res.json({ ...smartphones[0], reviews });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Server error' });
    }
});

// Get recommendations based on criteria
router.get('/recommendations/best', async (req, res) => {
    try {
        const { criteria = 'overall' } = req.query;

        let orderBy = 'performance DESC, camera DESC, battery DESC';

        switch (criteria) {
            case 'battery':
                orderBy = 'battery DESC, performance DESC';
                break;
            case 'camera':
                orderBy = 'camera DESC, performance DESC';
                break;
            case 'performance':
                orderBy = 'performance DESC, ram DESC';
                break;
            case 'budget':
                orderBy = 'price ASC, performance DESC';
                break;
            case 'premium':
                orderBy = 'price DESC, performance DESC';
                break;
        }

        const [smartphones] = await db.query(`
      SELECT s.*, 
             COALESCE(AVG(r.rating), 0) as avg_rating,
             COUNT(r.id) as review_count
      FROM smartphones s
      LEFT JOIN reviews r ON s.id = r.smartphone_id
      GROUP BY s.id
      ORDER BY ${orderBy}
      LIMIT 6
    `);

        res.json(smartphones);
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Server error' });
    }
});

// Add smartphone (admin only)
router.post('/', authMiddleware, adminMiddleware, async (req, res) => {
    try {
        const { name, brand, price, processor, ram, memory, screen, performance, camera, connectivity, battery, link, image_url, stock } = req.body;

        const [result] = await db.query(
            `INSERT INTO smartphones (name, brand, price, processor, ram, memory, screen, performance, camera, connectivity, battery, link, image_url, stock)
       VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
            [name, brand, price, processor, ram, memory, screen, performance, camera, connectivity, battery, link, image_url, stock]
        );

        res.status(201).json({ message: 'Smartphone added successfully', id: result.insertId });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Server error' });
    }
});

// Update smartphone (admin only)
router.put('/:id', authMiddleware, adminMiddleware, async (req, res) => {
    try {
        const { name, brand, price, processor, ram, memory, screen, performance, camera, connectivity, battery, link, image_url, stock } = req.body;

        await db.query(
            `UPDATE smartphones SET name=?, brand=?, price=?, processor=?, ram=?, memory=?, screen=?, performance=?, camera=?, connectivity=?, battery=?, link=?, image_url=?, stock=?
       WHERE id=?`,
            [name, brand, price, processor, ram, memory, screen, performance, camera, connectivity, battery, link, image_url, stock, req.params.id]
        );

        res.json({ message: 'Smartphone updated successfully' });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Server error' });
    }
});

// Delete smartphone (admin only)
router.delete('/:id', authMiddleware, adminMiddleware, async (req, res) => {
    try {
        await db.query('DELETE FROM smartphones WHERE id = ?', [req.params.id]);
        res.json({ message: 'Smartphone deleted successfully' });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Server error' });
    }
});

module.exports = router;
