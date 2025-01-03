const express = require('express');
const { getDataByName, insertProduct } = require('../controllers/productController');
const router = express.Router();

// Route to insert a new product
router.get('/get', getDataByName);
router.post('/add', insertProduct);

module.exports = router;
