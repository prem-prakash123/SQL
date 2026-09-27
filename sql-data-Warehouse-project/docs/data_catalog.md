## Data Catalog for Gold Layer

### Overview

The Gold Layer is the business-level data representation, structured to support analytical and reporting use cases. It consists of **dimension tables** and **fact tables** that provide customer, product, and sales information for business analysis.

---

### 1. gold.dim_customers

**Purpose:** Stores customer details enriched with demographic and geographic information.

| **Column Name** | **Data Type** | **Description**                                                                      |
| --------------- | ------------- | ------------------------------------------------------------------------------------ |
| customer_key    | INT           | Surrogate key uniquely identifying each customer record in the dimension table.      |
| customer_id     | INT           | Unique numerical identifier assigned to each customer in the CRM system.             |
| customer_number | NVARCHAR(50)  | Alphanumeric customer identifier used for tracking and referencing customer records. |
| first_name      | NVARCHAR(50)  | The customer's first name, cleaned and standardized from the source system.          |
| last_name       | NVARCHAR(50)  | The customer's last name or family name.                                             |
| country         | CHAR(20)      | The country associated with the customer, standardized from ERP location data.       |
| marital_status  | NVARCHAR(50)  | The customer's marital status, such as 'Married' or 'Single'.                        |
| gender          | NVARCHAR(50)  | The customer's standardized gender, such as 'Male', 'Female', or 'n/a'.              |
| birthdate       | DATE          | The customer's date of birth.                                                        |
| create_date     | DATE          | The date when the customer record was originally created in the CRM system.          |

---

### 2. gold.dim_products

**Purpose:** Provides product information and attributes used for product analysis and reporting.

| **Column Name**      | **Data Type** | **Description**                                                                                    |
| -------------------- | ------------- | -------------------------------------------------------------------------------------------------- |
| product_key          | INT           | Surrogate key uniquely identifying each product record in the dimension table.                     |
| product_id           | INT           | Unique numerical identifier assigned to the product in the CRM system.                             |
| product_number       | NVARCHAR(50)  | Structured alphanumeric identifier representing the product for tracking and referencing.          |
| product_name         | NVARCHAR(50)  | Descriptive name of the product, including details such as product type, color, or size.           |
| category_id          | NVARCHAR(50)  | Unique identifier representing the high-level product category.                                    |
| category             | NVARCHAR(50)  | The broader classification of the product, such as Bikes or Components.                            |
| subcategory          | NVARCHAR(50)  | A more detailed classification of the product within its category.                                 |
| maintenance_required | NVARCHAR(50)  | Indicates whether the product requires maintenance, based on the ERP product category information. |
| cost                 | INT           | The cost or base price of the product.                                                             |
| product_line         | NVARCHAR(50)  | The product line or series to which the product belongs, such as Road, Touring, or Mountain.       |
| start_date           | DATE          | The date when the product became available for sale or use.                                        |
| end_date             | DATE          | The date when the product stopped being active or available.                                       |

---

### 3. gold.fact_sales_details

**Purpose:** Stores transactional sales data and connects sales transactions with customer and product dimensions for analytical reporting.

| **Column Name** | **Data Type** | **Description**                                                        |
| --------------- | ------------- | ---------------------------------------------------------------------- |
| order_number    | VARCHAR(50)   | Unique alphanumeric identifier assigned to each sales order.           |
| product_key     | INT           | Surrogate key linking the sales transaction to the product dimension.  |
| customer_key    | INT           | Surrogate key linking the sales transaction to the customer dimension. |
| order_date      | DATE          | The date when the sales order was placed.                              |
| shipping_date   | DATE          | The date when the ordered product was shipped to the customer.         |
| due_date        | DATE          | The date by which the order was due.                                   |
| sales           | INT           | The total monetary value of the sales transaction for the line item.   |
| quantity        | INT           | The number of units of the product ordered in the sales transaction.   |
| price           | INT           | The price per unit of the product in the sales transaction.            |
