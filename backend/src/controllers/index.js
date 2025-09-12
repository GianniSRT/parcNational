import { Router } from 'express';

const router = Router();

// Example controller functions
const getItems = (req, res) => {
    res.send('Get all items');
};

const createItem = (req, res) => {
    res.send('Create an item');
};

// Define routes
router.get('/items', getItems);
router.post('/items', createItem);

export default router;