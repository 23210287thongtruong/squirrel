# SQL Project: Database Schema and Management

This project contains SQL scripts and migrations for creating, managing, and maintaining a relational database using PostgreSQL syntax. The structure is organized to separate logical components such as database setup, tables, constraints, initial data, functions, triggers, and more.

## Folder Structure
```
.
│
├── database/
│   ├── 01_create_database.sql
│   ├── 02_set_roles_permissions.sql
│
├── tables/
│   ├── 10_create_table_users.sql
│   ├── 11_create_table_orders.sql
│   ├── 12_create_table_products.sql
│
├── constraints/
│   ├── 20_add_constraints.sql
│   ├── 21_add_indexes.sql
│
├── triggers/
│   ├── 40_trigger_update_last_modified.sql
│   ├── 41_trigger_check_inventory.sql
│
├── functions/
│   ├── 30_functions_users.sql
│   ├── 31_functions_orders.sql
│
├── seed/
│   ├── 50_insert_initial_users.sql
│   ├── 51_insert_initial_orders.sql
│   ├── 52_insert_initial_products.sql
│
├── cleanup/
│   ├── 90_drop_all.sql
│   ├── 91_reset_database.sql
│
└── migrations/
    ├── 60_migration_v1.sql
    ├── 61_migration_v2.sql
└── README.md                 # This file describing the project
```
## File naming convention
```
<sequence_number>_<description>.sql
```

- `<sequence_number>`: A two-digit number indicating the order of execution or creation. This helps in organizing the files sequentially.
- `<description>`: A brief description of the file's purpose or content, using underscores to separate words.

### Examples:
- `01_create_database.sql`
- `10_create_table_users.sql`
- `20_add_constraints.sql`
- `30_functions_users.sql`
- `50_insert_initial_users.sql`
- `90_drop_all.sql`
- `60_migration_v1.sql`

Ensure that the sequence numbers are unique within their respective folders to avoid conflicts and maintain a clear execution order.

## Git Branch Naming Convention
Branch names should follow the format:
- **`<folder-name>`**: The folder in your SQL project (e.g., `tables`, `constraints`, `functions`, etc.).
- **`<sequence-number>`**: The sequence number of the file being worked on (e.g., `01`, `10`, `20`, etc.).
- **`<description>`**: A short description of the change or task being performed.

### Examples:
- For creating a users table:
  ```plaintext
  tables/10_create_table_users

## Folder explanation:
1. **database/**
    - **Purpose**: Contains scripts for setting up the database and configuring roles/permissions.
    - **Files**:
        - `01_create_database.sql`: Creates the database.
        - `02_set_roles_permissions.sql`: Configures user roles and permissions.

2. **tables/**
    - **Purpose**: Contains scripts for creating database tables.
    - **Files**:
        - `10_create_table_*.sql`: Defines the structure of tables (e.g., `create_table_users.sql`).

3. **constraints/**
    - **Purpose**: Contains scripts for adding constraints like foreign keys, unique constraints, and indexes.
    - **Files**:
        - `20_add_constraints.sql`: Adds foreign keys, unique, and other constraints.
        - `21_add_indexes.sql`: Creates indexes on tables for better performance.

4. **triggers/**
    - **Purpose**: Contains trigger definitions for automating actions in the database.
    - **Files**:
        - `40_trigger_*.sql`: Defines triggers (e.g., `trigger_update_last_modified.sql`).

5. **functions/**
    - **Purpose**: Contains custom SQL functions for reusable logic.
    - **Files**:
        - `30_functions_*.sql`: Defines SQL functions (e.g., `functions_users.sql`).

6. **seed/**
    - **Purpose**: Contains scripts for inserting initial data (seeding the database).
    - **Files**:
        - `50_insert_initial_*.sql`: Inserts initial records (e.g., `insert_initial_users.sql`).

7. **cleanup/**
    - **Purpose**: Contains scripts for cleaning or resetting the database.
    - **Files**:
        - `90_drop_all.sql`: Drops all database objects (tables, constraints, etc.).
        - `91_reset_database.sql`: Resets data without dropping tables.

8. **migrations/**
    - **Purpose**: Contains migration scripts for database schema changes.
    - **Files**:
        - `60_migration_v1.sql`: Schema changes or updates for version 1.
        - `61_migration_v2.sql`: Schema changes or updates for version 2.
