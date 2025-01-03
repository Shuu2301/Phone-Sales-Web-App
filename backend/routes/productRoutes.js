const express = require('express');
const { insertProduct } = require('../controllers/productController');
const router = express.Router();

// Route to insert a new product
router.post('/add', insertProduct);

module.exports = router;
