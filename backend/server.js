const express = require('express');
const { connectToDatabase } = require('./configs/dbConfig');
const productRoutes = require('./routes/productRoutes');

const app = express();
const port = 3000;

// Middleware to parse JSON
app.use(express.json());

// Connect to the database
connectToDatabase();

// Register the product routes
app.use('/product', productRoutes);

// Start the Express server
app.listen(port, () =>
{
    console.log(`Server is running on http://localhost:${port}`);
});
