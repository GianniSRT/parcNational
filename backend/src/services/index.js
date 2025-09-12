import express from 'express';
import { someServiceFunction } from './someService';

const router = express.Router();

// Example route using a service function
router.get('/example', async (req, res) => {
    try {
        const data = await someServiceFunction();
        res.json(data);
    } catch (error) {
        res.status(500).json({ message: 'Error retrieving data' });
    }
});

export default router;