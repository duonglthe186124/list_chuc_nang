USE master
GO

IF EXISTS (SELECT * FROM sys.databases WHERE name = 'SWP391_WarehouseManagements')
BEGIN
	ALTER DATABASE [SWP391_WarehouseManagements] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE SWP391_WarehouseManagements
END

CREATE DATABASE SWP391_WarehouseManagements
GO

USE SWP391_WarehouseManagements
GO

CREATE TABLE Roles
(
	role_id INT IDENTITY(1,1) PRIMARY KEY,
	role_name VARCHAR(255) NOT NULL UNIQUE,
	description VARCHAR(1000) NULL
)

CREATE TABLE Features
(
	feature_id INT IDENTITY(1,1) PRIMARY KEY,
	feature_name VARCHAR(100) NOT NULL UNIQUE,
	description VARCHAR(1000) NULL
)

CREATE TABLE Feature_role
(
	role_id INT REFERENCES Roles(role_id),
	feature_id INT REFERENCES Features(feature_id),
	PRIMARY KEY(role_id, feature_id),
)

CREATE TABLE Users
(
	user_id INT IDENTITY(1,1) PRIMARY KEY,
	email VARCHAR(255) NOT NULL UNIQUE,
	password VARCHAR(255) NOT NULL,
	fullname VARCHAR(255) NOT NULL,
	phone VARCHAR(20) NOT NULL,
	address VARCHAR(255) NOT NULL,
	sec_address VARCHAR(255) NULL,
	role_id INT NULL REFERENCES Roles(role_id),
	is_actived BIT DEFAULT 0,
	is_deleted BIT DEFAULT 0,
)

CREATE TABLE Positions
(
	position_id INT IDENTITY(1,1) PRIMARY KEY,
	position_name VARCHAR(100) NOT NULL,
	description VARCHAR(1000) NULL,
)

CREATE TABLE Employees
(
	employee_id INT IDENTITY(1,1) PRIMARY KEY,
	user_id INT NOT NULL REFERENCES Users(user_id),
	employee_code VARCHAR(50) NOT NULL UNIQUE,
	fullname VARCHAR(255) NOT NULL,
	phone VARCHAR(20) NOT NULL,
	hire_date DATETIME NOT NULL DEFAULT CAST(GETDATE() AS DATE),
	position_id INT NOT NULL REFERENCES Positions(position_id),
	bank_account VARCHAR(100) NULL,
	is_activated BIT DEFAULT 1,
	boss_id INT NULL REFERENCES Employees(employee_id)
)

CREATE TABLE Product_specs
(
	spec_id INT IDENTITY(1,1) PRIMARY KEY,
	cpu VARCHAR(255) NOT NULL,
	memory VARCHAR(255) NOT NULL,
	storage VARCHAR(255) NOT NULL,
	battery_capacity INT NOT NULL,
	color VARCHAR(50) NOT NULL
)

CREATE TABLE Brands
(
	brand_id INT IDENTITY(1,1) PRIMARY KEY,
	brand_name VARCHAR(100) NOT NULL UNIQUE,
)

CREATE TABLE Product_types
(
	type_id INT IDENTITY(1,1) PRIMARY KEY,
	type_name VARCHAR(100) NOT NULL UNIQUE,
)

CREATE TABLE Products
(
	product_id INT IDENTITY(1,1) PRIMARY KEY,
	product_name VARCHAR(255) NOT NULL,
	brand_id INT NOT NULL REFERENCES Brands(brand_id),
	spec_id INT NOT NULL REFERENCES Product_specs(spec_id),
	type_id INT NOT NULL REFERENCES Product_types(type_id),
	description VARCHAR(1000) NULL,
	created_at DATETIME NOT NULL DEFAULT CAST(GETDATE() AS DATE)
)

CREATE TABLE Product_units
(
	unit_id	INT IDENTITY(1,1) PRIMARY KEY,
	product_id INT NOT NULL REFERENCES Products(product_id),
	status VARCHAR(50) NOT NULL,
	warranty_end_date DATETIME NOT NULL,
	created_at DATETIME NOT NULL DEFAULT CAST(GETDATE() AS DATE)
)

CREATE TABLE Product_images
(
	image_id INT IDENTITY(1,1) PRIMARY KEY,
	product_id INT NOT NULL REFERENCES Products(product_id),
	image_url VARCHAR(500) NOT NULL,
	alt_text VARCHAR(255) NULL
)

CREATE TABLE Warehouse_locations
(
	location_id INT IDENTITY(1,1) PRIMARY KEY,
	code VARCHAR(255) NOT NULL UNIQUE,
	area VARCHAR(50) NOT NULL,
	aisle VARCHAR(50) NOT NULL,
	slot VARCHAR(50) NOT NULL,
	max_capacity INT NOT NULL,
	current_capacity INT NOT NULL,
	description VARCHAR(1000) NULL
)

CREATE TABLE Inventory_records
(
	inventory_id INT IDENTITY(1,1) PRIMARY KEY,
	product_id INT NOT NULL REFERENCES Products(product_id),
	location_id INT NOT NULL REFERENCES Warehouse_locations(location_id),
	qty INT NOT NULL,
	last_updated DATETIME
)

CREATE TABLE Suppliers
(
	supplier_id INT IDENTITY(1,1) PRIMARY KEY,
	supplier_name VARCHAR(100) NOT NULL,
	address VARCHAR(255) NOT NULL,
	phone VARCHAR(20) NOT NULL,
	email VARCHAR(255) NOT NULL,
	representative VARCHAR(255) NOT NULL,
	payment_method VARCHAR(100) NOT NULL,
	note VARCHAR(1000) NULL,
)

CREATE TABLE Purchase_orders
(
	po_id INT IDENTITY(1,1) PRIMARY KEY,
	po_code VARCHAR(100) NOT NULL UNIQUE,
	supplier_id INT NOT NULL REFERENCES Suppliers(supplier_id),
	created_by INT NOT NULL REFERENCES Employees(employee_id),
	created_at DATETIME NOT NULL DEFAULT CAST(GETDATE() AS DATE),
	status VARCHAR(50) CHECK(status IN ('ACTIVE', 'INACTIVE', 'ONBOARDING'))NOT NULL ,
	total_amount INT NOT NULL,
)

CREATE TABLE Purchase_order_lines
(
	po_line_id INT IDENTITY(1,1) PRIMARY KEY,
	po_id INT NOT NULL REFERENCES Purchase_orders(po_id),
	product_id INT NOT NULL REFERENCES Products(product_id),
	unit_price FLOAT NOT NULL,
	qty INT NOT NULL,
	line_amount FLOAT NOT NULL,
)

CREATE TABLE Inbound_inventory
(
	inbound_id INT IDENTITY(1,1) PRIMARY KEY,
	inbound_code VARCHAR(100) UNIQUE,
	supplier_id INT NOT NULL REFERENCES Suppliers(supplier_id),
	po_id INT NULL REFERENCES Purchase_orders(po_id),
	received_by INT NOT NULL REFERENCES Employees(employee_id),
	received_at DATETIME NOT NULL DEFAULT CAST(GETDATE() AS DATE),
	note VARCHAR(1000) NULL,
)

CREATE TABLE Outbound_inventory
(
	outbound_id INT IDENTITY(1,1) PRIMARY KEY,
	outbound_code VARCHAR(100) UNIQUE,
	customer_name VARCHAR(255),
	created_by INT NOT NULL REFERENCES Employees(employee_id),
	created_at DATETIME NOT NULL DEFAULT CAST(GETDATE() AS DATE),
	note VARCHAR(1000) NULL,
)

CREATE TABLE Inventory_transactions
(
	tx_id INT IDENTITY(1,1) PRIMARY KEY,
	tx_type VARCHAR(25) CHECK(tx_type IN('Inbound', 'Outbound', 'Moving', 'Destroy')),
	product_id INT NOT NULL REFERENCES Products(product_id),
	unit_id INT NOT NULL REFERENCES Product_units(unit_id),
	qty INT NOT NULL,
	from_location INT NULL REFERENCES Warehouse_locations(location_id),
	to_location INT NULL REFERENCES Warehouse_locations(location_id),
	ref_code VARCHAR(100) NOT NULL,
	related_inbound_id INT NULL REFERENCES Inbound_inventory(inbound_id),
	related_outbound_id INT NULL REFERENCES Outbound_inventory(outbound_id),
	employee_id INT NOT NULL REFERENCES Employees(employee_id),
	txdate DATETIME NOT NULL DEFAULT CAST(GETDATE() AS DATE),
	note VARCHAR(1000) NULL
)

CREATE TABLE Inbound_lines
(
	inbound_line_id INT IDENTITY(1,1) PRIMARY KEY,
	inbound_id INT NOT NULL REFERENCES Inbound_inventory(inbound_id),
	product_id INT NOT NULL REFERENCES Products(product_id),
	unit_id INT NOT NULL REFERENCES Product_units(unit_id),
	qty INT NOT NULL,
	unit_price FLOAT NOT NULL,
)

CREATE TABLE Outbound_lines
(
	outbound_line_id INT IDENTITY(1,1) PRIMARY KEY,
	outbound_id INT NOT NULL REFERENCES Inbound_inventory(inbound_id),
	product_id INT NOT NULL REFERENCES Products(product_id),
	unit_id INT NOT NULL REFERENCES Product_units(unit_id),
	qty INT NOT NULL,
	unit_price FLOAT NOT NULL,
)

CREATE TABLE Quality_controls
(
	qc_id INT IDENTITY(1,1) PRIMARY KEY,
	unit_id INT NULL REFERENCES Product_units(unit_id),
	inbound_line_id INT NULL REFERENCES Inbound_lines(inbound_line_id),
	inspector_id INT NOT NULL REFERENCES Employees(employee_id),
	qc_date DATETIME NOT NULL DEFAULT CAST(GETDATE() AS DATE),
	state VARCHAR(50) NOT NULL,
	error VARCHAR(255) NULL,
	remarks VARCHAR(255) NULL,
)

CREATE TABLE Shifts
(
	shift_id INT IDENTITY(1,1) PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	start_time DATETIME NOT NULL,
	end_time DATETIME NOT NULL,
	note VARCHAR(1000) NULL
)

CREATE TABLE Shift_assignments
(
	assign_id INT IDENTITY(1,1) PRIMARY KEY,
	shift_id INT NOT NULL REFERENCES Shifts(shift_id),
	employee_id INT NOT NULL REFERENCES Employees(employee_id),
	assign_date DATETIME NOT NULL,
	location_id INT REFERENCES Warehouse_locations(location_id),
	role_in_shift VARCHAR(100) NOT NULL,
)

CREATE TABLE Attendances
(
	attendance_id INT IDENTITY(1,1) PRIMARY KEY,
	assign_id INT NOT NULL REFERENCES Shift_assignments(assign_id),
	employee_id INT NOT NULL REFERENCES Employees(employee_id),
	check_in DATETIME NOT NULL,
	check_out DATETIME NOT NULL,
	hours_worked FLOAT NOT NULL,
	note VARCHAR(1000) NULL,
)

CREATE TABLE Payrolls
(
	payroll_id INT IDENTITY(1,1) PRIMARY KEY,
	employee_id INT NOT NULL REFERENCES Employees(employee_id),
	period_start DATETIME NOT NULL,
	period_end DATETIME NOT NULL,
	gross_amount FLOAT NOT NULL,
	net_amount FLOAT NOT NULL,
	created_at DATETIME NOT NULL DEFAULT CAST(GETDATE() AS DATE)
)

CREATE TABLE Salary_components
(
	comp_id INT IDENTITY(1,1) PRIMARY KEY,
	payroll_id INT NOT NULL REFERENCES Payrolls(payroll_id),
	comp_type VARCHAR(50) NOT NULL,
	amount FLOAT NOT NULL,
)

-- Roles
INSERT INTO Roles (role_name, description) VALUES
('Admin', 'Full system access'),
('Manager', 'Manage teams and reports'),
('Staff', 'Regular employee access'),
('Viewer', 'Read-only access');

-- Features
INSERT INTO Features (feature_name, description) VALUES
('User Management', 'Manage system users'),
('Reports', 'Generate and view reports'),
('Inventory', 'Manage inbound and outbound inventory'),
('Dashboard', 'View system overview');

-- Feature_role mapping
INSERT INTO Feature_role (role_id, feature_id) VALUES
(1,1), (1,2), (1,3), (1,4),   -- Admin has all
(2,2), (2,3), (2,4),          -- Manager
(3,3), (3,4),                 -- Staff
(4,4);                        -- Viewer

INSERT INTO Positions (position_name) VALUES
('CEO'),
('Manager'),
('Team Leader'),
('Developer'),
('HR');

-- Users
INSERT INTO Users (email, password, fullname, phone, address, sec_address, role_id, is_actived, is_deleted) VALUES
('admin@example.com', 'hashedpw1', 'System Admin', '0900000001', '123 Main St', NULL, 1, 1, 0),
('manager1@example.com', 'hashedpw2', 'Nguyen Van A', '0900000002', '45 Le Loi', NULL, 2, 1, 0),
('manager2@example.com', 'hashedpw3', 'Tran Thi B', '0900000003', '78 Tran Hung Dao', NULL, 2, 1, 0),
('staff1@example.com', 'hashedpw4', 'Le Van C', '0900000004', '12 Hai Ba Trung', NULL, 3, 1, 0),
('staff2@example.com', 'hashedpw5', 'Pham Thi D', '0900000005', '34 Pasteur', NULL, 3, 1, 0),
('staff3@example.com', 'hashedpw6', 'Do Van E', '0900000006', '99 Vo Van Tan', NULL, 3, 0, 0),
('viewer1@example.com', 'hashedpw7', 'Bui Thi F', '0900000007', '56 Nguyen Trai', NULL, 4, 1, 0),
('viewer2@example.com', 'hashedpw8', 'Hoang Van G', '0900000008', '22 Nguyen Hue', NULL, 4, 1, 0);

-- Employees
INSERT INTO Employees (user_id, employee_code, fullname, phone, hire_date, position_id, bank_account, is_activated, boss_id) VALUES
(1, 'EMP001', 'System Admin', '0900000001', GETDATE(), 1, '123-456-789', 1, NULL),  -- CEO
(2, 'EMP002', 'Nguyen Van A', '0900000002', GETDATE(), 2, '222-333-444', 1, 1),     -- Manager under Admin
(3, 'EMP003', 'Tran Thi B', '0900000003', GETDATE(), 2, '333-444-555', 1, 1),       -- Another Manager
(4, 'EMP004', 'Le Van C', '0900000004', GETDATE(), 4, '444-555-666', 1, 2),         -- Staff under Manager A
(5, 'EMP005', 'Pham Thi D', '0900000005', GETDATE(), 4, '555-666-777', 1, 2),       -- Staff under Manager A
(6, 'EMP006', 'Do Van E', '0900000006', GETDATE(), 4, '666-777-888', 0, 3),         -- Inactive staff under Manager B
(7, 'EMP007', 'Bui Thi F', '0900000007', GETDATE(), 5, '777-888-999', 1, 2),        -- HR under Manager A
(8, 'EMP008', 'Hoang Van G', '0900000008', GETDATE(), 5, '888-999-000', 1, 3);      -- HR under Manager B

-- Insert into Positions
INSERT INTO Positions (position_name, description) VALUES
('Warehouse Supervisor', 'Oversees warehouse operations'),
('Inventory Clerk', 'Handles inventory tracking'),
('Delivery Driver', 'Manages product deliveries');

-- Insert into Product_specs
INSERT INTO Product_specs (cpu, memory, storage, battery_capacity, color) VALUES
('Intel i5', '8GB', '256GB SSD', 4000, 'Silver'),
('AMD Ryzen 7', '16GB', '512GB SSD', 4500, 'Black'),
('Intel i7', '16GB', '1TB SSD', 5000, 'Space Gray');

-- Insert into Brands
INSERT INTO Brands (brand_name) VALUES
('Dell'),
('HP'),
('Apple');

-- Insert into Product_types
INSERT INTO Product_types (type_name) VALUES
('Laptop'),
('Desktop'),
('Tablet');

-- Insert into Products
INSERT INTO Products (product_name, brand_id, spec_id, type_id, description, created_at) VALUES
('XPS 13', 1, 1, 1, '13-inch laptop with high performance', '2025-09-01'),
('EliteBook', 2, 2, 1, 'Business-class laptop', '2025-09-02'),
('MacBook Pro', 3, 3, 1, 'Premium laptop for professionals', '2025-09-03');

-- Insert into Product_units
INSERT INTO Product_units (product_id, status, warranty_end_date, created_at) VALUES
(1, 'Available', '2026-09-01', '2025-09-01'),
(2, 'Available', '2026-09-02', '2025-09-02'),
(3, 'In Use', '2026-09-03', '2025-09-03');

-- Insert into Product_images
INSERT INTO Product_images (product_id, image_url, alt_text) VALUES
(1, 'http://example.com/images/xps13.jpg', 'Dell XPS 13'),
(2, 'http://example.com/images/elitebook.jpg', 'HP EliteBook'),
(3, 'http://example.com/images/macbookpro.jpg', 'MacBook Pro');

-- Insert into Warehouse_locations
INSERT INTO Warehouse_locations (code, area, aisle, slot, max_capacity, current_capacity, description) VALUES
('WH001', 'A', '1', 'A1', 100, 50, 'Main storage area'),
('WH002', 'B', '2', 'B1', 200, 100, 'Secondary storage area'),
('WH003', 'C', '3', 'C1', 150, 75, 'Electronics storage');

-- Insert into Inventory_records
INSERT INTO Inventory_records (product_id, location_id, qty, last_updated) VALUES
(1, 1, 20, '2025-09-30'),
(2, 2, 15, '2025-09-30'),
(3, 3, 10, '2025-09-30');

-- Insert into Suppliers
INSERT INTO Suppliers (supplier_name, address, phone, email, representative, payment_method, note) VALUES
('Tech Supplies', '789 Tech Rd', '1112223333', 'contact@techsupplies.com', 'Alice Smith', 'Bank Transfer', 'Reliable supplier'),
('Gadget Corp', '456 Gadget St', '4445556666', 'sales@gadgetcorp.com', 'Bob Johnson', 'Credit', NULL);

-- Insert into Purchase_orders
INSERT INTO Purchase_orders (po_code, supplier_id, created_by, created_at, status, total_amount) VALUES
('PO001', 1, 1, '2025-09-01', 'ACTIVE', 5000),
('PO002', 2, 2, '2025-09-02', 'ONBOARDING', 3000);

-- Insert into Purchase_order_lines
INSERT INTO Purchase_order_lines (po_id, product_id, unit_price, qty, line_amount, total_amount) VALUES
(1, 1, 1000.00, 3, 3000.00, 3000),
(2, 2, 800.00, 2, 1600.00, 1600);

-- Insert into Inbound_inventory
INSERT INTO Inbound_inventory (inbound_code, supplier_id, po_id, received_by, received_at, note) VALUES
('IN001', 1, 1, 1, '2025-09-01', 'Received in good condition'),
('IN002', 2, 2, 2, '2025-09-02', NULL);

-- Insert into Outbound_inventory
INSERT INTO Outbound_inventory (outbound_code, customer_name, created_by, created_at, note) VALUES
('OUT001', 'Tech Retail', 1, '2025-09-03', 'Urgent delivery'),
('OUT002', 'Gadget Store', 2, '2025-09-04', NULL);

-- Insert into Inventory_transactions
INSERT INTO Inventory_transactions (tx_type, product_id, unit_id, qty, from_location, to_location, ref_code, related_inbound_id, related_outbound_id, employee_id, txdate, note) VALUES
('Inbound', 1, 1, 10, NULL, 1, 'IN001', 1, NULL, 1, '2025-09-01', 'Initial stock'),
('Outbound', 2, 2, 5, 2, NULL, 'OUT001', NULL, 1, 2, '2025-09-03', 'Customer order');

-- Insert into Inbound_lines
INSERT INTO Inbound_lines (inbound_id, product_id, unit_id, qty, unit_price) VALUES
(1, 1, 1, 10, 1000.00),
(2, 2, 2, 5, 800.00);

-- Insert into Outbound_lines
INSERT INTO Outbound_lines (outbound_id, product_id, unit_id, qty, unit_price) VALUES
(1, 1, 1, 5, 1000.00),
(2, 2, 2, 3, 800.00);

-- Insert into Quality_controls
INSERT INTO Quality_controls (unit_id, inbound_line_id, inspector_id, qc_date, state, error, remarks) VALUES
(1, 1, 1, '2025-09-01', 'Passed', NULL, 'All units functional'),
(2, 2, 2, '2025-09-02', 'Failed', 'Defective battery', 'Return to supplier');

-- Insert into Shifts
INSERT INTO Shifts (name, start_time, end_time, note) VALUES
('Morning Shift', '2025-09-30 08:00:00', '2025-09-30 16:00:00', 'Main shift'),
('Night Shift', '2025-09-30 16:00:00', '2025-09-30 00:00:00', 'Overnight');

-- Insert into Shift_assignments
INSERT INTO Shift_assignments (shift_id, employee_id, assign_date, location_id, role_in_shift) VALUES
(1, 1, '2025-09-30', 1, 'Supervisor'),
(2, 2, '2025-09-30', 2, 'Clerk');

-- Insert into Attendances
INSERT INTO Attendances (assign_id, employee_id, check_in, check_out, hours_worked, note) VALUES
(1, 1, '2025-09-30 08:00:00', '2025-09-30 16:00:00', 8.0, 'On time'),
(2, 2, '2025-09-30 16:00:00', '2025-09-30 00:00:00', 8.0, NULL);

-- Insert into Payrolls
INSERT INTO Payrolls (employee_id, period_start, period_end, gross_amount, net_amount, created_at) VALUES
(1, '2025-09-01', '2025-09-30', 5000.00, 4500.00, '2025-09-30'),
(2, '2025-09-01', '2025-09-30', 4000.00, 3600.00, '2025-09-30');

-- Insert into Salary_components
INSERT INTO Salary_components (payroll_id, comp_type, amount) VALUES
(1, 'Base Salary', 4000.00),
(1, 'Bonus', 1000.00),
(2, 'Base Salary', 3500.00),
(2, 'Overtime', 500.00);