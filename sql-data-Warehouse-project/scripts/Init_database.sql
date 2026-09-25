## Data Warehouse – Database & Schema Setup

This SQL script creates the **Datawarehouse** database and sets up three schemas:

* **`bronze`** – Stores raw source data from CRM and ERP systems.
* **`silver`** – Stores cleaned and transformed data.
* **`gold`** – Stores business-ready data for reporting and analytics.

The script also switches to the newly created database before creating the schemas.


Use master;

create database Datawarehouse;
use Datawarehouse;

create schema bronze;
go
create schema sliver;
go
create schema gold;
go
