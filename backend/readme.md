# Project Setup Guide

## Prerequisites
1. **Microsoft SQL Server**: Install Microsoft SQL Server for database management.
2. **SQL Server Management Studio (SSMS)** *(Optional)*: Install [SSMS](https://learn.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver16) for easy database testing and interaction.

---

## Steps to Configure the Project

### 1. Database Setup
- Use the provided `database Sql.sql` file to seed your database.
  - Open `SSMS` or your preferred SQL editor.
  - Paste the contents of `database Sql.sql` into a new query and execute it.

---

### 2. Configure Database Connection
- Edit `dbConfig.js`:
  - Update the `dbConfig` object with the following:
    - `user`: Your SQL Server username.
    - `password`: Your SQL Server password.
    - `server`: The IP address of your SQL Server.
    - `database`: The name of your database.

---

### 3. Define Routes
- Open `productRoutes.js`:
  - Add the API endpoints (routes) related to products.

---

### 4. Implement Controller Logic
- Open `productController.js`:
  - Write the logic to interact with the database.
  - Refer to the pre-existing function `insertProduct` as an example.

---

### 5. Run the server
1. Install the project dependencies:
   ```bash
   npm install
   ```
2. Start the development server:
   ```bash
   npm run devStart
   ```

## API Documentation

### Add Product
- **Method**: `POST`
- **URI**: `http://localhost:3000/product/add`
- **Body**:
  ```json
  {
      "name": "Test New Product",
      "price": 199.99,
      "quantity": 50,
      "warranty": "1 year",
      "brand": "Brand A",
      "description": "Description of the new product",
      "otherInfor": "Additional information"
  }
  ```

  ### Get Product By Id
- **Method**: `GET`
- **URI**: `http://localhost:3000/get/id/:id`

  ### Get All Products
- **Method**: `GET`
- **URI**: `http://localhost:3000/get/all`
