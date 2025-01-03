const { sql } = require('../configs/dbConfig');

const getDataByName = async (req, res) => {
    const {name} = req.body;

    if (!name) return res.status(400).json({ message: 'Name is required' });

    try {
        const pool = await sql.connect();
        const query = `
            SELECT (Name, Price, Warranty, Brand, Description, OtherInfor) FROM Product
            WHERE Name = @name;
        `;

        await pool.request()
            .input('name', sql.NVarChar, name)
            .query(query);

        if (Name === null) return res.status(404).json({ message: 'Product not found' });
        return res.status(200).json({ 
            name: Name,
            price: Price,
            warranty: Warranty,
            brand: Brand,
            description: Description
        });
    }
    catch (error) {
        console.error('Error getting product:', error);
        return res.status(500).json({ message: 'Error getting product' });
    }
}

const insertProduct = async (req, res) =>
{
    const { name, price, warranty, brand, description, otherInfor } = req.body;

    if (!name || !price) return res.status(400).json({ message: 'Name and price are required' });

    try
    {
        const pool = await sql.connect();
        const query = `
            INSERT INTO Product (Name, Price, Warranty, Brand, Description, OtherInfor)
            VALUES (@name, @price, @warranty, @brand, @description, @otherInfor)
        `;

        await pool.request()
            .input('name', sql.NVarChar, name)
            .input('price', sql.Decimal(10, 2), price)
            .input('warranty', sql.NVarChar, warranty)
            .input('brand', sql.NVarChar, brand)
            .input('description', sql.NVarChar, description)
            .input('otherInfor', sql.NVarChar, otherInfor)
            .query(query);

        return res.status(200).json({ message: 'Product added successfully' });
    }
    catch (error)
    {
        console.error('Error inserting product:', error);
        return res.status(500).json({ message: 'Error adding product' });
    }
};

module.exports = { '
    getDataByName,
    insertProduct 
};
