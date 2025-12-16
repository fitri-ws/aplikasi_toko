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

// Get recommended smartphones (sorted by overall score)
router.get('/recommended', async (req, res) => {
    try {
        const [smartphones] = await db.query(`
      SELECT s.*, 
             COALESCE(AVG(r.rating), 0) as avg_rating,
             COUNT(r.id) as review_count,
             (COALESCE(s.performance_score, 0) + COALESCE(s.camera_score, 0) + 
              COALESCE(s.connectivity_score, 0) + COALESCE(s.battery_score, 0)) / 4 as overall_score
      FROM smartphones s
      LEFT JOIN reviews r ON s.id = r.smartphone_id
      WHERE s.stock > 0
      GROUP BY s.id
      ORDER BY overall_score DESC, s.price ASC
      LIMIT 10
    `);
        res.json(smartphones);
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Server error' });
    }
});

// Get all unique brands
router.get('/brands', async (req, res) => {
    try {
        const [brands] = await db.query(`
      SELECT DISTINCT brand 
      FROM smartphones 
      ORDER BY brand ASC
    `);
        res.json(brands);
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Server error' });
    }
});

// Search smartphones
router.get('/search', async (req, res) => {
    try {
        const { q } = req.query;

        if (!q) {
            return res.status(400).json({ message: 'Search query is required' });
        }

        const [smartphones] = await db.query(`
      SELECT s.*, 
             COALESCE(AVG(r.rating), 0) as avg_rating,
             COUNT(r.id) as review_count
      FROM smartphones s
      LEFT JOIN reviews r ON s.id = r.smartphone_id
      WHERE s.name LIKE ? OR s.brand LIKE ? OR s.processor LIKE ?
      GROUP BY s.id
      ORDER BY s.created_at DESC
    `, [`%${q}%`, `%${q}%`, `%${q}%`]);

        res.json(smartphones);
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Server error' });
    }
});

// Get smartphones by brand
router.get('/brand/:brand', async (req, res) => {
    try {
        const [smartphones] = await db.query(`
      SELECT s.*, 
             COALESCE(AVG(r.rating), 0) as avg_rating,
             COUNT(r.id) as review_count
      FROM smartphones s
      LEFT JOIN reviews r ON s.id = r.smartphone_id
      WHERE s.brand = ?
      GROUP BY s.id
      ORDER BY s.price ASC
    `, [req.params.brand]);

        res.json(smartphones);
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Server error' });
    }
});

// Get recommendations based on criteria
router.get('/recommendations/best', async (req, res) => {
    try {
        const { criteria = 'overall' } = req.query;

        let orderBy = 'performance_score DESC, camera_score DESC, battery_score DESC';

        switch (criteria) {
            case 'battery':
                orderBy = 'battery_score DESC, performance_score DESC';
                break;
            case 'camera':
                orderBy = 'camera_score DESC, performance_score DESC';
                break;
            case 'performance':
                orderBy = 'performance_score DESC, ram DESC';
                break;
            case 'budget':
                orderBy = 'price ASC, performance_score DESC';
                break;
            case 'premium':
                orderBy = 'price DESC, performance_score DESC';
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

// Get smartphone by ID (must be after specific routes)
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

// Add smartphone (admin only)
router.post('/', authMiddleware, adminMiddleware, async (req, res) => {
    try {
        const { name, brand, price, processor, ram, memory, screen_size, performance_score, camera_score, connectivity_score, battery_score, link, image_url, description, specifications, stock } = req.body;

        const [result] = await db.query(
            `INSERT INTO smartphones (name, brand, price, processor, ram, memory, screen_size, performance_score, camera_score, connectivity_score, battery_score, link, image_url, description, specifications, stock)
       VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
            [name, brand, price, processor, ram, memory, screen_size, performance_score, camera_score, connectivity_score, battery_score, link, image_url, description, specifications, stock]
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
        const { name, brand, price, processor, ram, memory, screen_size, performance_score, camera_score, connectivity_score, battery_score, link, image_url, description, specifications, stock } = req.body;

        await db.query(
            `UPDATE smartphones SET name=?, brand=?, price=?, processor=?, ram=?, memory=?, screen_size=?, performance_score=?, camera_score=?, connectivity_score=?, battery_score=?, link=?, image_url=?, description=?, specifications=?, stock=?
       WHERE id=?`,
            [name, brand, price, processor, ram, memory, screen_size, performance_score, camera_score, connectivity_score, battery_score, link, image_url, description, specifications, stock, req.params.id]
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
