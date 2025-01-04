const express = require('express');
const { getDataByName, getDataById, getAllData, insertProduct } = require('../controllers/productController');
const router = express.Router();

// Insert a new product
router.post('/add', insertProduct);

// Get a product by name
router.get('/get', getDataByName);

// Get a product by id
router.route("/get/id/:id").get(getDataById);

// Get all products
router.route("/get/all").get(getAllData);

module.exports = router;
