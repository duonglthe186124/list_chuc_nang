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
	hire_date DATETIME NOT NULL DEFAULT CAST(GETDATE() AS DATE),
	position_id INT NOT NULL REFERENCES Positions(position_id),
	bank_account VARCHAR(100) NULL,
	boss_id INT NULL REFERENCES Employees(employee_id)
)

CREATE TABLE Product_specs
(
	spec_id INT IDENTITY(1,1) PRIMARY KEY,
	cpu VARCHAR(255) NOT NULL,
	memory VARCHAR(255) NOT NULL,
	storage VARCHAR(255) NOT NULL,
	battery_capacity INT NOT NULL,
	color VARCHAR(50) NOT NULL,
	screen_size FLOAT NOT NULL,
	screen_type VARCHAR(50) NOT NULL,
	camera INT NOT NULL
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
	unit_name VARCHAR(50) NOT NULL,
	qty INT NOT NULL,
	unit_price FLOAT NOT NULL,
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

CREATE TABLE Orders
(
	order_id INT IDENTITY(1,1) PRIMARY KEY,
	user_id INT REFERENCES Users(user_id),
	total_amount DECIMAL(18,2) NOT NULL,
	status VARCHAR(50) NOT NULL,
	order_date DATETIME NOT NULL DEFAULT CAST(GETDATE() AS DATE),
	receive_date DATETIME NOT NULL,
)

CREATE TABLE Order_details
(
	order_no INT IDENTITY(1,1) PRIMARY KEY,
	order_id INT REFERENCES Orders(order_id),
	product_id INT REFERENCES Products(product_id),
	qty INT NOT NULL,
	unit_price DECIMAL(18,2) NOT NULL,
	line_amount DECIMAL(18,2) NOT NULL,
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
	display_name VARCHAR(250) NOT NULL,
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
	user_id INT NOT NULL REFERENCES Users(user_id),
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
	outbound_id INT NOT NULL REFERENCES Outbound_inventory(outbound_id),
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

USE SWP391_WarehouseManagements
GO

-- Insert into Roles (20 records)
INSERT INTO Roles (role_name, description) VALUES
('Admin', 'System administrator'),
('Manager', 'Warehouse manager'),
('Employee', 'General employee'),
('Supervisor', 'Shift supervisor'),
('Accountant', 'Handles finances'),
('HR', 'Human resources'),
('IT Support', 'Technical support'),
('Sales', 'Sales representative'),
('Purchasing', 'Handles purchases'),
('Quality Control', 'Inspects products'),
('Inventory Clerk', 'Manages inventory'),
('Shipping', 'Handles outbound'),
('Receiving', 'Handles inbound'),
('Maintenance', 'Facility maintenance'),
('Security', 'Warehouse security'),
('Trainer', 'Employee trainer'),
('Analyst', 'Data analyst'),
('Auditor', 'Internal auditor'),
('Guest', 'Limited access'),
('Vendor', 'External vendor access');

-- Insert into Features (20 records)
INSERT INTO Features (feature_name, description) VALUES
('User Management', 'Manage users'),
('Inventory View', 'View inventory'),
('Order Processing', 'Process orders'),
('Purchase Orders', 'Create POs'),
('Reports', 'Generate reports'),
('Employee Scheduling', 'Schedule shifts'),
('Quality Control', 'Perform QC'),
('Inbound Management', 'Manage inbounds'),
('Outbound Management', 'Manage outbounds'),
('Product Catalog', 'Manage products'),
('Supplier Management', 'Manage suppliers'),
('Customer Management', 'Manage customers'),
('Payroll', 'Process payroll'),
('Attendance Tracking', 'Track attendance'),
('Warehouse Mapping', 'Manage locations'),
('Transaction Logging', 'Log transactions'),
('Analytics Dashboard', 'View analytics'),
('Backup Data', 'Backup system data'),
('Audit Logs', 'View audit logs'),
('Notifications', 'Send notifications');

-- Insert into Feature_role (20 records, assuming role_id 1-10 and feature_id 1-10 for simplicity, adjust as needed)
INSERT INTO Feature_role (role_id, feature_id) VALUES
(1,1), (1,2), (1,3), (1,4), (1,5),
(2,2), (2,3), (2,6), (2,7), (2,8),
(3,2), (3,8), (3,9), (3,10), (3,11),
(4,6), (4,12), (4,13), (4,14), (4,15);

-- Insert into Users (20 records)
INSERT INTO Users (email, password, fullname, phone, address, sec_address, role_id, is_actived, is_deleted) VALUES
('user1@example.com', 'pass1', 'User One', '1234567890', 'Addr1', 'Sec1', 1, 1, 0),
('user2@example.com', 'pass2', 'User Two', '1234567891', 'Addr2', 'Sec2', 2, 1, 0),
('user3@example.com', 'pass3', 'User Three', '1234567892', 'Addr3', NULL, 3, 1, 0),
('user4@example.com', 'pass4', 'User Four', '1234567893', 'Addr4', 'Sec4', 4, 1, 0),
('user5@example.com', 'pass5', 'User Five', '1234567894', 'Addr5', NULL, 5, 1, 0),
('user6@example.com', 'pass6', 'User Six', '1234567895', 'Addr6', 'Sec6', 6, 1, 0),
('user7@example.com', 'pass7', 'User Seven', '1234567896', 'Addr7', NULL, 7, 1, 0),
('user8@example.com', 'pass8', 'User Eight', '1234567897', 'Addr8', 'Sec8', 8, 1, 0),
('user9@example.com', 'pass9', 'User Nine', '1234567898', 'Addr9', NULL, 9, 1, 0),
('user10@example.com', 'pass10', 'User Ten', '1234567899', 'Addr10', 'Sec10', 10, 1, 0),
('user11@example.com', 'pass11', 'User Eleven', '1234567800', 'Addr11', NULL, 1, 1, 0),
('user12@example.com', 'pass12', 'User Twelve', '1234567801', 'Addr12', 'Sec12', 2, 1, 0),
('user13@example.com', 'pass13', 'User Thirteen', '1234567802', 'Addr13', NULL, 3, 1, 0),
('user14@example.com', 'pass14', 'User Fourteen', '1234567803', 'Addr14', 'Sec14', 4, 1, 0),
('user15@example.com', 'pass15', 'User Fifteen', '1234567804', 'Addr15', NULL, 5, 1, 0),
('user16@example.com', 'pass16', 'User Sixteen', '1234567805', 'Addr16', 'Sec16', 6, 1, 0),
('user17@example.com', 'pass17', 'User Seventeen', '1234567806', 'Addr17', NULL, 7, 1, 0),
('user18@example.com', 'pass18', 'User Eighteen', '1234567807', 'Addr18', 'Sec18', 8, 1, 0),
('user19@example.com', 'pass19', 'User Nineteen', '1234567808', 'Addr19', NULL, 9, 1, 0),
('user20@example.com', 'pass20', 'User Twenty', '1234567809', 'Addr20', 'Sec20', 10, 1, 0);

-- Insert into Positions (20 records)
INSERT INTO Positions (position_name, description) VALUES
('Manager', 'Oversees operations'),
('Clerk', 'Handles paperwork'),
('Forklift Operator', 'Operates machinery'),
('Picker', 'Picks orders'),
('Packer', 'Packs items'),
('Receiver', 'Receives goods'),
('Shipper', 'Ships goods'),
('Inspector', 'Inspects quality'),
('Accountant', 'Manages finances'),
('HR Specialist', 'Handles HR'),
('IT Technician', 'Tech support'),
('Sales Rep', 'Sales'),
('Buyer', 'Purchases'),
('Analyst', 'Analyzes data'),
('Trainer', 'Trains staff'),
('Security Guard', 'Security'),
('Maintenance Tech', 'Maintenance'),
('Auditor', 'Audits'),
('Supervisor', 'Supervises shifts'),
('Coordinator', 'Coordinates tasks');

-- Insert into Employees (20 records, assuming user_id 1-20, position_id 1-20, boss_id NULL or cycling)
INSERT INTO Employees (user_id, employee_code, hire_date, position_id, bank_account, boss_id) VALUES
(1, 'EMP001', '2023-01-01', 1, 'Bank1', NULL),
(2, 'EMP002', '2023-02-01', 2, 'Bank2', 1),
(3, 'EMP003', '2023-03-01', 3, 'Bank3', 1),
(4, 'EMP004', '2023-04-01', 4, 'Bank4', 2),
(5, 'EMP005', '2023-05-01', 5, 'Bank5', 2),
(6, 'EMP006', '2023-06-01', 6, 'Bank6', 3),
(7, 'EMP007', '2023-07-01', 7, 'Bank7', 3),
(8, 'EMP008', '2023-08-01', 8, 'Bank8', 4),
(9, 'EMP009', '2023-09-01', 9, 'Bank9', 4),
(10, 'EMP010', '2023-10-01', 10, 'Bank10', 5),
(11, 'EMP011', '2023-11-01', 11, 'Bank11', 5),
(12, 'EMP012', '2023-12-01', 12, 'Bank12', 6),
(13, 'EMP013', '2024-01-01', 13, 'Bank13', 6),
(14, 'EMP014', '2024-02-01', 14, 'Bank14', 7),
(15, 'EMP015', '2024-03-01', 15, 'Bank15', 7),
(16, 'EMP016', '2024-04-01', 16, 'Bank16', 8),
(17, 'EMP017', '2024-05-01', 17, 'Bank17', 8),
(18, 'EMP018', '2024-06-01', 18, 'Bank18', 9),
(19, 'EMP019', '2024-07-01', 19, 'Bank19', 9),
(20, 'EMP020', '2024-08-01', 20, 'Bank20', 10);

-- Insert into Product_specs (20 records)
INSERT INTO Product_specs (cpu, memory, storage, battery_capacity, color, screen_size, screen_type, camera) VALUES
('CPU1', '8GB', '256GB', 4000, 'Black', 6.1, 'OLED', 12),
('CPU2', '16GB', '512GB', 5000, 'White', 6.5, 'LCD', 48),
('CPU3', '4GB', '128GB', 3000, 'Red', 5.5, 'IPS', 8),
('CPU4', '32GB', '1TB', 6000, 'Blue', 7.0, 'AMOLED', 64),
('CPU5', '8GB', '256GB', 4500, 'Green', 6.2, 'OLED', 16),
('CPU6', '16GB', '512GB', 5500, 'Silver', 6.7, 'LCD', 32),
('CPU7', '4GB', '128GB', 3500, 'Gold', 5.8, 'IPS', 12),
('CPU8', '32GB', '1TB', 6500, 'Black', 7.2, 'AMOLED', 48),
('CPU9', '8GB', '256GB', 4000, 'White', 6.1, 'OLED', 64),
('CPU10', '16GB', '512GB', 5000, 'Red', 6.5, 'LCD', 8),
('CPU11', '4GB', '128GB', 3000, 'Blue', 5.5, 'IPS', 16),
('CPU12', '32GB', '1TB', 6000, 'Green', 7.0, 'AMOLED', 32),
('CPU13', '8GB', '256GB', 4500, 'Silver', 6.2, 'OLED', 12),
('CPU14', '16GB', '512GB', 5500, 'Gold', 6.7, 'LCD', 48),
('CPU15', '4GB', '128GB', 3500, 'Black', 5.8, 'IPS', 64),
('CPU16', '32GB', '1TB', 6500, 'White', 7.2, 'AMOLED', 8),
('CPU17', '8GB', '256GB', 4000, 'Red', 6.1, 'OLED', 16),
('CPU18', '16GB', '512GB', 5000, 'Blue', 6.5, 'LCD', 32),
('CPU19', '4GB', '128GB', 3000, 'Green', 5.5, 'IPS', 12),
('CPU20', '32GB', '1TB', 6000, 'Silver', 7.0, 'AMOLED', 48);

-- Insert into Brands (20 records)
INSERT INTO Brands (brand_name) VALUES
('Brand1'), ('Brand2'), ('Brand3'), ('Brand4'), ('Brand5'),
('Brand6'), ('Brand7'), ('Brand8'), ('Brand9'), ('Brand10'),
('Brand11'), ('Brand12'), ('Brand13'), ('Brand14'), ('Brand15'),
('Brand16'), ('Brand17'), ('Brand18'), ('Brand19'), ('Brand20');

-- Insert into Product_types (20 records)
INSERT INTO Product_types (type_name) VALUES
('Type1'), ('Type2'), ('Type3'), ('Type4'), ('Type5'),
('Type6'), ('Type7'), ('Type8'), ('Type9'), ('Type10'),
('Type11'), ('Type12'), ('Type13'), ('Type14'), ('Type15'),
('Type16'), ('Type17'), ('Type18'), ('Type19'), ('Type20');

-- Insert into Products (20 records, using brand_id 1-20, spec_id 1-20, type_id 1-20)
INSERT INTO Products (product_name, brand_id, spec_id, type_id, description, created_at) VALUES
('Product1', 1, 1, 1, 'Desc1', '2023-01-01'),
('Product2', 2, 2, 2, 'Desc2', '2023-02-01'),
('Product3', 3, 3, 3, 'Desc3', '2023-03-01'),
('Product4', 4, 4, 4, 'Desc4', '2023-04-01'),
('Product5', 5, 5, 5, 'Desc5', '2023-05-01'),
('Product6', 6, 6, 6, 'Desc6', '2023-06-01'),
('Product7', 7, 7, 7, 'Desc7', '2023-07-01'),
('Product8', 8, 8, 8, 'Desc8', '2023-08-01'),
('Product9', 9, 9, 9, 'Desc9', '2023-09-01'),
('Product10', 10, 10, 10, 'Desc10', '2023-10-01'),
('Product11', 11, 11, 11, 'Desc11', '2023-11-01'),
('Product12', 12, 12, 12, 'Desc12', '2023-12-01'),
('Product13', 13, 13, 13, 'Desc13', '2024-01-01'),
('Product14', 14, 14, 14, 'Desc14', '2024-02-01'),
('Product15', 15, 15, 15, 'Desc15', '2024-03-01'),
('Product16', 16, 16, 16, 'Desc16', '2024-04-01'),
('Product17', 17, 17, 17, 'Desc17', '2024-05-01'),
('Product18', 18, 18, 18, 'Desc18', '2024-06-01'),
('Product19', 19, 19, 19, 'Desc19', '2024-07-01'),
('Product20', 20, 20, 20, 'Desc20', '2024-08-01');

-- Insert into Product_units (20 records, product_id 1-20)
INSERT INTO Product_units (product_id, unit_name, qty, unit_price, status, warranty_end_date, created_at) VALUES
(1, 'Unit1', 100, 10.5, 'Available', '2025-01-01', '2023-01-01'),
(2, 'Unit2', 200, 20.5, 'Available', '2025-02-01', '2023-02-01'),
(3, 'Unit3', 300, 30.5, 'Available', '2025-03-01', '2023-03-01'),
(4, 'Unit4', 400, 40.5, 'Available', '2025-04-01', '2023-04-01'),
(5, 'Unit5', 500, 50.5, 'Available', '2025-05-01', '2023-05-01'),
(6, 'Unit6', 600, 60.5, 'Available', '2025-06-01', '2023-06-01'),
(7, 'Unit7', 700, 70.5, 'Available', '2025-07-01', '2023-07-01'),
(8, 'Unit8', 800, 80.5, 'Available', '2025-08-01', '2023-08-01'),
(9, 'Unit9', 900, 90.5, 'Available', '2025-09-01', '2023-09-01'),
(10, 'Unit10', 1000, 100.5, 'Available', '2025-10-01', '2023-10-01'),
(11, 'Unit11', 1100, 110.5, 'Available', '2025-11-01', '2023-11-01'),
(12, 'Unit12', 1200, 120.5, 'Available', '2025-12-01', '2023-12-01'),
(13, 'Unit13', 1300, 130.5, 'Available', '2026-01-01', '2024-01-01'),
(14, 'Unit14', 1400, 140.5, 'Available', '2026-02-01', '2024-02-01'),
(15, 'Unit15', 1500, 150.5, 'Available', '2026-03-01', '2024-03-01'),
(16, 'Unit16', 1600, 160.5, 'Available', '2026-04-01', '2024-04-01'),
(17, 'Unit17', 1700, 170.5, 'Available', '2026-05-01', '2024-05-01'),
(18, 'Unit18', 1800, 180.5, 'Available', '2026-06-01', '2024-06-01'),
(19, 'Unit19', 1900, 190.5, 'Available', '2026-07-01', '2024-07-01'),
(20, 'Unit20', 2000, 200.5, 'Available', '2026-08-01', '2024-08-01');

-- Insert into Product_images (20 records, product_id 1-20)
INSERT INTO Product_images (product_id, image_url, alt_text) VALUES
(1, 'url1', 'Alt1'),
(2, 'url2', 'Alt2'),
(3, 'url3', 'Alt3'),
(4, 'url4', 'Alt4'),
(5, 'url5', 'Alt5'),
(6, 'url6', 'Alt6'),
(7, 'url7', 'Alt7'),
(8, 'url8', 'Alt8'),
(9, 'url9', 'Alt9'),
(10, 'url10', 'Alt10'),
(11, 'url11', 'Alt11'),
(12, 'url12', 'Alt12'),
(13, 'url13', 'Alt13'),
(14, 'url14', 'Alt14'),
(15, 'url15', 'Alt15'),
(16, 'url16', 'Alt16'),
(17, 'url17', 'Alt17'),
(18, 'url18', 'Alt18'),
(19, 'url19', 'Alt19'),
(20, 'url20', 'Alt20');

-- Insert into Orders (20 records, customer_id 1-20, product_id 1-20)
INSERT INTO Orders (user_id, total_amount, status, order_date, receive_date) VALUES
(1, 105.0, 'Pending', '2024-01-01', '2024-01-10'),
(2, 410.0, 'Shipped', '2024-02-01', '2024-02-10'),
(3, 915.0, 'Delivered', '2024-03-01', '2024-03-10'),
(4, 1620.0, 'Pending', '2024-04-01', '2024-04-10'),
(5, 2525.0, 'Shipped', '2024-05-01', '2024-05-10'),
(6, 3630.0, 'Delivered', '2024-06-01', '2024-06-10'),
(7, 4935.0, 'Pending', '2024-07-01', '2024-07-10'),
(8, 6440.0, 'Shipped', '2024-08-01', '2024-08-10'),
(9, 8145.0, 'Delivered', '2024-09-01', '2024-09-10'),
(10, 10050.0, 'Pending', '2024-10-01', '2024-10-10'),
(11, 12155.0, 'Shipped', '2024-11-01', '2024-11-10'),
(12, 14460.0, 'Delivered', '2024-12-01', '2024-12-10'),
(13, 16965.0, 'Pending', '2025-01-01', '2025-01-10'),
(14, 19670.0, 'Shipped', '2025-02-01', '2025-02-10'),
(15, 22575.0, 'Delivered', '2025-03-01', '2025-03-10'),
(16, 25680.0, 'Pending', '2025-04-01', '2025-04-10'),
(17, 28985.0, 'Shipped', '2025-05-01', '2025-05-10'),
(18, 32490.0, 'Delivered', '2025-06-01', '2025-06-10'),
(19, 36195.0, 'Pending', '2025-07-01', '2025-07-10'),
(20, 40100.0, 'Shipped', '2025-08-01', '2025-08-10');

-- Insert into Order_details (new table)
INSERT INTO Order_details (order_id, product_id, qty, unit_price, line_amount) VALUES
(1, 1, 10, 10.5, 105.0),
(2, 2, 20, 20.5, 410.0),
(3, 3, 30, 30.5, 915.0),
(4, 4, 40, 40.5, 1620.0),
(5, 5, 50, 50.5, 2525.0),
(6, 6, 60, 60.5, 3630.0),
(7, 7, 70, 70.5, 4935.0),
(8, 8, 80, 80.5, 6440.0),
(9, 9, 90, 90.5, 8145.0),
(10, 10, 100, 100.5, 10050.0),
(11, 11, 110, 110.5, 12155.0),
(12, 12, 120, 120.5, 14460.0),
(13, 13, 130, 130.5, 16965.0),
(14, 14, 140, 140.5, 19670.0),
(15, 15, 150, 150.5, 22575.0),
(16, 16, 160, 160.5, 25680.0),
(17, 17, 170, 170.5, 28985.0),
(18, 18, 180, 180.5, 32490.0),
(19, 19, 190, 190.5, 36195.0),
(20, 20, 200, 200.5, 40100.0);

-- Insert into Warehouse_locations (20 records)
INSERT INTO Warehouse_locations (code, area, aisle, slot, max_capacity, current_capacity, description) VALUES
('LOC001', 'Area1', 'Aisle1', 'Slot1', 1000, 500, 'Desc1'),
('LOC002', 'Area2', 'Aisle2', 'Slot2', 2000, 1000, 'Desc2'),
('LOC003', 'Area3', 'Aisle3', 'Slot3', 3000, 1500, 'Desc3'),
('LOC004', 'Area4', 'Aisle4', 'Slot4', 4000, 2000, 'Desc4'),
('LOC005', 'Area5', 'Aisle5', 'Slot5', 5000, 2500, 'Desc5'),
('LOC006', 'Area6', 'Aisle6', 'Slot6', 6000, 3000, 'Desc6'),
('LOC007', 'Area7', 'Aisle7', 'Slot7', 7000, 3500, 'Desc7'),
('LOC008', 'Area8', 'Aisle8', 'Slot8', 8000, 4000, 'Desc8'),
('LOC009', 'Area9', 'Aisle9', 'Slot9', 9000, 4500, 'Desc9'),
('LOC010', 'Area10', 'Aisle10', 'Slot10', 10000, 5000, 'Desc10'),
('LOC011', 'Area11', 'Aisle11', 'Slot11', 11000, 5500, 'Desc11'),
('LOC012', 'Area12', 'Aisle12', 'Slot12', 12000, 6000, 'Desc12'),
('LOC013', 'Area13', 'Aisle13', 'Slot13', 13000, 6500, 'Desc13'),
('LOC014', 'Area14', 'Aisle14', 'Slot14', 14000, 7000, 'Desc14'),
('LOC015', 'Area15', 'Aisle15', 'Slot15', 15000, 7500, 'Desc15'),
('LOC016', 'Area16', 'Aisle16', 'Slot16', 16000, 8000, 'Desc16'),
('LOC017', 'Area17', 'Aisle17', 'Slot17', 17000, 8500, 'Desc17'),
('LOC018', 'Area18', 'Aisle18', 'Slot18', 18000, 9000, 'Desc18'),
('LOC019', 'Area19', 'Aisle19', 'Slot19', 19000, 9500, 'Desc19'),
('LOC020', 'Area20', 'Aisle20', 'Slot20', 20000, 10000, 'Desc20');

-- Insert into Inventory_records (20 records, product_id 1-20, location_id 1-20)
INSERT INTO Inventory_records (product_id, location_id, qty, last_updated) VALUES
(1, 1, 100, '2024-01-01'),
(2, 2, 200, '2024-02-01'),
(3, 3, 300, '2024-03-01'),
(4, 4, 400, '2024-04-01'),
(5, 5, 500, '2024-05-01'),
(6, 6, 600, '2024-06-01'),
(7, 7, 700, '2024-07-01'),
(8, 8, 800, '2024-08-01'),
(9, 9, 900, '2024-09-01'),
(10, 10, 1000, '2024-10-01'),
(11, 11, 1100, '2024-11-01'),
(12, 12, 1200, '2024-12-01'),
(13, 13, 1300, '2025-01-01'),
(14, 14, 1400, '2025-02-01'),
(15, 15, 1500, '2025-03-01'),
(16, 16, 1600, '2025-04-01'),
(17, 17, 1700, '2025-05-01'),
(18, 18, 1800, '2025-06-01'),
(19, 19, 1900, '2025-07-01'),
(20, 20, 2000, '2025-08-01');

-- Insert into Suppliers (adjusted, added display_name)
INSERT INTO Suppliers (supplier_name, display_name, address, phone, email, representative, payment_method, note) VALUES
('Supp1', 'Supp1 Display', 'Addr1', '1234567890', 'supp1@email.com', 'Rep1', 'Credit', 'Note1'),
('Supp2', 'Supp2 Display', 'Addr2', '1234567891', 'supp2@email.com', 'Rep2', 'Cash', 'Note2'),
('Supp3', 'Supp3 Display', 'Addr3', '1234567892', 'supp3@email.com', 'Rep3', 'Credit', 'Note3'),
('Supp4', 'Supp4 Display', 'Addr4', '1234567893', 'supp4@email.com', 'Rep4', 'Cash', 'Note4'),
('Supp5', 'Supp5 Display', 'Addr5', '1234567894', 'supp5@email.com', 'Rep5', 'Credit', 'Note5'),
('Supp6', 'Supp6 Display', 'Addr6', '1234567895', 'supp6@email.com', 'Rep6', 'Cash', 'Note6'),
('Supp7', 'Supp7 Display', 'Addr7', '1234567896', 'supp7@email.com', 'Rep7', 'Credit', 'Note7'),
('Supp8', 'Supp8 Display', 'Addr8', '1234567897', 'supp8@email.com', 'Rep8', 'Cash', 'Note8'),
('Supp9', 'Supp9 Display', 'Addr9', '1234567898', 'supp9@email.com', 'Rep9', 'Credit', 'Note9'),
('Supp10', 'Supp10 Display', 'Addr10', '1234567899', 'supp10@email.com', 'Rep10', 'Cash', 'Note10'),
('Supp11', 'Supp11 Display', 'Addr11', '1234567800', 'supp11@email.com', 'Rep11', 'Credit', 'Note11'),
('Supp12', 'Supp12 Display', 'Addr12', '1234567801', 'supp12@email.com', 'Rep12', 'Cash', 'Note12'),
('Supp13', 'Supp13 Display', 'Addr13', '1234567802', 'supp13@email.com', 'Rep13', 'Credit', 'Note13'),
('Supp14', 'Supp14 Display', 'Addr14', '1234567803', 'supp14@email.com', 'Rep14', 'Cash', 'Note14'),
('Supp15', 'Supp15 Display', 'Addr15', '1234567804', 'supp15@email.com', 'Rep15', 'Credit', 'Note15'),
('Supp16', 'Supp16 Display', 'Addr16', '1234567805', 'supp16@email.com', 'Rep16', 'Cash', 'Note16'),
('Supp17', 'Supp17 Display', 'Addr17', '1234567806', 'supp17@email.com', 'Rep17', 'Credit', 'Note17'),
('Supp18', 'Supp18 Display', 'Addr18', '1234567807', 'supp18@email.com', 'Rep18', 'Cash', 'Note18'),
('Supp19', 'Supp19 Display', 'Addr19', '1234567808', 'supp19@email.com', 'Rep19', 'Credit', 'Note19'),
('Supp20', 'Supp20 Display', 'Addr20', '1234567809', 'supp20@email.com', 'Rep20', 'Cash', 'Note20');

-- Insert into Purchase_orders (20 records, supplier_id 1-20, created_by 1-20, status 'ACTIVE' for all)
INSERT INTO Purchase_orders (po_code, supplier_id, created_by, created_at, status, total_amount) VALUES
('PO001', 1, 1, '2024-01-01', 'ACTIVE', 1000),
('PO002', 2, 2, '2024-02-01', 'ACTIVE', 2000),
('PO003', 3, 3, '2024-03-01', 'ACTIVE', 3000),
('PO004', 4, 4, '2024-04-01', 'ACTIVE', 4000),
('PO005', 5, 5, '2024-05-01', 'ACTIVE', 5000),
('PO006', 6, 6, '2024-06-01', 'ACTIVE', 6000),
('PO007', 7, 7, '2024-07-01', 'ACTIVE', 7000),
('PO008', 8, 8, '2024-08-01', 'ACTIVE', 8000),
('PO009', 9, 9, '2024-09-01', 'ACTIVE', 9000),
('PO010', 10, 10, '2024-10-01', 'ACTIVE', 10000),
('PO011', 11, 11, '2024-11-01', 'ACTIVE', 11000),
('PO012', 12, 12, '2024-12-01', 'ACTIVE', 12000),
('PO013', 13, 13, '2025-01-01', 'ACTIVE', 13000),
('PO014', 14, 14, '2025-02-01', 'ACTIVE', 14000),
('PO015', 15, 15, '2025-03-01', 'ACTIVE', 15000),
('PO016', 16, 16, '2025-04-01', 'ACTIVE', 16000),
('PO017', 17, 17, '2025-05-01', 'ACTIVE', 17000),
('PO018', 18, 18, '2025-06-01', 'ACTIVE', 18000),
('PO019', 19, 19, '2025-07-01', 'ACTIVE', 19000),
('PO020', 20, 20, '2025-08-01', 'ACTIVE', 20000);

-- Insert into Purchase_order_lines (20 records, po_id 1-20, product_id 1-20)
INSERT INTO Purchase_order_lines (po_id, product_id, unit_price, qty, line_amount) VALUES
(1, 1, 10.5, 100, 1050),
(2, 2, 20.5, 200, 4100),
(3, 3, 30.5, 300, 9150),
(4, 4, 40.5, 400, 16200),
(5, 5, 50.5, 500, 25250),
(6, 6, 60.5, 600, 36300),
(7, 7, 70.5, 700, 49350),
(8, 8, 80.5, 800, 64400),
(9, 9, 90.5, 900, 81450),
(10, 10, 100.5, 1000, 100500),
(11, 11, 110.5, 1100, 121550),
(12, 12, 120.5, 1200, 144600),
(13, 13, 130.5, 1300, 169650),
(14, 14, 140.5, 1400, 196700),
(15, 15, 150.5, 1500, 225750),
(16, 16, 160.5, 1600, 256800),
(17, 17, 170.5, 1700, 289850),
(18, 18, 180.5, 1800, 324900),
(19, 19, 190.5, 1900, 361950),
(20, 20, 200.5, 2000, 401000);

-- Insert into Inbound_inventory (20 records, supplier_id 1-20, po_id 1-20, received_by 1-20)
INSERT INTO Inbound_inventory (inbound_code, supplier_id, po_id, received_by, received_at, note) VALUES
('INB001', 1, 1, 1, '2024-01-01', 'Note1'),
('INB002', 2, 2, 2, '2024-02-01', 'Note2'),
('INB003', 3, 3, 3, '2024-03-01', 'Note3'),
('INB004', 4, 4, 4, '2024-04-01', 'Note4'),
('INB005', 5, 5, 5, '2024-05-01', 'Note5'),
('INB006', 6, 6, 6, '2024-06-01', 'Note6'),
('INB007', 7, 7, 7, '2024-07-01', 'Note7'),
('INB008', 8, 8, 8, '2024-08-01', 'Note8'),
('INB009', 9, 9, 9, '2024-09-01', 'Note9'),
('INB010', 10, 10, 10, '2024-10-01', 'Note10'),
('INB011', 11, 11, 11, '2024-11-01', 'Note11'),
('INB012', 12, 12, 12, '2024-12-01', 'Note12'),
('INB013', 13, 13, 13, '2025-01-01', 'Note13'),
('INB014', 14, 14, 14, '2025-02-01', 'Note14'),
('INB015', 15, 15, 15, '2025-03-01', 'Note15'),
('INB016', 16, 16, 16, '2025-04-01', 'Note16'),
('INB017', 17, 17, 17, '2025-05-01', 'Note17'),
('INB018', 18, 18, 18, '2025-06-01', 'Note18'),
('INB019', 19, 19, 19, '2025-07-01', 'Note19'),
('INB020', 20, 20, 20, '2025-08-01', 'Note20');

-- Insert into Outbound_inventory (20 records, created_by 1-20)
-- Insert into Outbound_inventory (adjusted, replaced customer_name with user_id)
INSERT INTO Outbound_inventory (outbound_code, user_id, created_by, created_at, note) VALUES
('OUT001', 1, 1, '2024-01-01', 'Note1'),
('OUT002', 2, 2, '2024-02-01', 'Note2'),
('OUT003', 3, 3, '2024-03-01', 'Note3'),
('OUT004', 4, 4, '2024-04-01', 'Note4'),
('OUT005', 5, 5, '2024-05-01', 'Note5'),
('OUT006', 6, 6, '2024-06-01', 'Note6'),
('OUT007', 7, 7, '2024-07-01', 'Note7'),
('OUT008', 8, 8, '2024-08-01', 'Note8'),
('OUT009', 9, 9, '2024-09-01', 'Note9'),
('OUT010', 10, 10, '2024-10-01', 'Note10'),
('OUT011', 11, 11, '2024-11-01', 'Note11'),
('OUT012', 12, 12, '2024-12-01', 'Note12'),
('OUT013', 13, 13, '2025-01-01', 'Note13'),
('OUT014', 14, 14, '2025-02-01', 'Note14'),
('OUT015', 15, 15, '2025-03-01', 'Note15'),
('OUT016', 16, 16, '2025-04-01', 'Note16'),
('OUT017', 17, 17, '2025-05-01', 'Note17'),
('OUT018', 18, 18, '2025-06-01', 'Note18'),
('OUT019', 19, 19, '2025-07-01', 'Note19'),
('OUT020', 20, 20, '2025-08-01', 'Note20');

-- Insert into Inventory_transactions (20 records, tx_type 'Inbound' for example, cycling references)
INSERT INTO Inventory_transactions (tx_type, product_id, unit_id, qty, from_location, to_location, ref_code, related_inbound_id, related_outbound_id, employee_id, txdate, note) VALUES
('Inbound', 1, 1, 100, NULL, 1, 'REF001', 1, NULL, 1, '2024-01-01', 'Note1'),
('Outbound', 2, 2, 200, 2, NULL, 'REF002', NULL, 2, 2, '2024-02-01', 'Note2'),
('Moving', 3, 3, 300, 3, 4, 'REF003', NULL, NULL, 3, '2024-03-01', 'Note3'),
('Destroy', 4, 4, 400, NULL, NULL, 'REF004', NULL, NULL, 4, '2024-04-01', 'Note4'),
('Inbound', 5, 5, 500, NULL, 5, 'REF005', 5, NULL, 5, '2024-05-01', 'Note5'),
('Outbound', 6, 6, 600, 6, NULL, 'REF006', NULL, 6, 6, '2024-06-01', 'Note6'),
('Moving', 7, 7, 700, 7, 8, 'REF007', NULL, NULL, 7, '2024-07-01', 'Note7'),
('Destroy', 8, 8, 800, NULL, NULL, 'REF008', NULL, NULL, 8, '2024-08-01', 'Note8'),
('Inbound', 9, 9, 900, NULL, 9, 'REF009', 9, NULL, 9, '2024-09-01', 'Note9'),
('Outbound', 10, 10, 1000, 10, NULL, 'REF010', NULL, 10, 10, '2024-10-01', 'Note10'),
('Moving', 11, 11, 1100, 11, 12, 'REF011', NULL, NULL, 11, '2024-11-01', 'Note11'),
('Destroy', 12, 12, 1200, NULL, NULL, 'REF012', NULL, NULL, 12, '2024-12-01', 'Note12'),
('Inbound', 13, 13, 1300, NULL, 13, 'REF013', 13, NULL, 13, '2025-01-01', 'Note13'),
('Outbound', 14, 14, 1400, 14, NULL, 'REF014', NULL, 14, 14, '2025-02-01', 'Note14'),
('Moving', 15, 15, 1500, 15, 16, 'REF015', NULL, NULL, 15, '2025-03-01', 'Note15'),
('Destroy', 16, 16, 1600, NULL, NULL, 'REF016', NULL, NULL, 16, '2025-04-01', 'Note16'),
('Inbound', 17, 17, 1700, NULL, 17, 'REF017', 17, NULL, 17, '2025-05-01', 'Note17'),
('Outbound', 18, 18, 1800, 18, NULL, 'REF018', NULL, 18, 18, '2025-06-01', 'Note18'),
('Moving', 19, 19, 1900, 19, 20, 'REF019', NULL, NULL, 19, '2025-07-01', 'Note19'),
('Destroy', 20, 20, 2000, NULL, NULL, 'REF020', NULL, NULL, 20, '2025-08-01', 'Note20');

-- Insert into Inbound_lines (20 records, inbound_id 1-20, product_id 1-20, unit_id 1-20)
INSERT INTO Inbound_lines (inbound_id, product_id, unit_id, qty, unit_price) VALUES
(1, 1, 1, 100, 10.5),
(2, 2, 2, 200, 20.5),
(3, 3, 3, 300, 30.5),
(4, 4, 4, 400, 40.5),
(5, 5, 5, 500, 50.5),
(6, 6, 6, 600, 60.5),
(7, 7, 7, 700, 70.5),
(8, 8, 8, 800, 80.5),
(9, 9, 9, 900, 90.5),
(10, 10, 10, 1000, 100.5),
(11, 11, 11, 1100, 110.5),
(12, 12, 12, 1200, 120.5),
(13, 13, 13, 1300, 130.5),
(14, 14, 14, 1400, 140.5),
(15, 15, 15, 1500, 150.5),
(16, 16, 16, 1600, 160.5),
(17, 17, 17, 1700, 170.5),
(18, 18, 18, 1800, 180.5),
(19, 19, 19, 1900, 190.5),
(20, 20, 20, 2000, 200.5);

-- Insert into Outbound_lines (20 records, outbound_id 1-20, product_id 1-20, unit_id 1-20)
INSERT INTO Outbound_lines (outbound_id, product_id, unit_id, qty, unit_price) VALUES
(1, 1, 1, 100, 10.5),
(2, 2, 2, 200, 20.5),
(3, 3, 3, 300, 30.5),
(4, 4, 4, 400, 40.5),
(5, 5, 5, 500, 50.5),
(6, 6, 6, 600, 60.5),
(7, 7, 7, 700, 70.5),
(8, 8, 8, 800, 80.5),
(9, 9, 9, 900, 90.5),
(10, 10, 10, 1000, 100.5),
(11, 11, 11, 1100, 110.5),
(12, 12, 12, 1200, 120.5),
(13, 13, 13, 1300, 130.5),
(14, 14, 14, 1400, 140.5),
(15, 15, 15, 1500, 150.5),
(16, 16, 16, 1600, 160.5),
(17, 17, 17, 1700, 170.5),
(18, 18, 18, 1800, 180.5),
(19, 19, 19, 1900, 190.5),
(20, 20, 20, 2000, 200.5);

-- Insert into Quality_controls (20 records, unit_id 1-20, inbound_line_id 1-20, inspector_id 1-20)
INSERT INTO Quality_controls (unit_id, inbound_line_id, inspector_id, qc_date, state, error, remarks) VALUES
(1, 1, 1, '2024-01-01', 'Passed', NULL, 'Remark1'),
(2, 2, 2, '2024-02-01', 'Failed', 'Error2', 'Remark2'),
(3, 3, 3, '2024-03-01', 'Passed', NULL, 'Remark3'),
(4, 4, 4, '2024-04-01', 'Failed', 'Error4', 'Remark4'),
(5, 5, 5, '2024-05-01', 'Passed', NULL, 'Remark5'),
(6, 6, 6, '2024-06-01', 'Failed', 'Error6', 'Remark6'),
(7, 7, 7, '2024-07-01', 'Passed', NULL, 'Remark7'),
(8, 8, 8, '2024-08-01', 'Failed', 'Error8', 'Remark8'),
(9, 9, 9, '2024-09-01', 'Passed', NULL, 'Remark9'),
(10, 10, 10, '2024-10-01', 'Failed', 'Error10', 'Remark10'),
(11, 11, 11, '2024-11-01', 'Passed', NULL, 'Remark11'),
(12, 12, 12, '2024-12-01', 'Failed', 'Error12', 'Remark12'),
(13, 13, 13, '2025-01-01', 'Passed', NULL, 'Remark13'),
(14, 14, 14, '2025-02-01', 'Failed', 'Error14', 'Remark14'),
(15, 15, 15, '2025-03-01', 'Passed', NULL, 'Remark15'),
(16, 16, 16, '2025-04-01', 'Failed', 'Error16', 'Remark16'),
(17, 17, 17, '2025-05-01', 'Passed', NULL, 'Remark17'),
(18, 18, 18, '2025-06-01', 'Failed', 'Error18', 'Remark18'),
(19, 19, 19, '2025-07-01', 'Passed', NULL, 'Remark19'),
(20, 20, 20, '2025-08-01', 'Failed', 'Error20', 'Remark20');

-- Insert into Shifts (20 records)
INSERT INTO Shifts (name, start_time, end_time, note) VALUES
('Shift1', '2024-01-01 08:00:00', '2024-01-01 16:00:00', 'Note1'),
('Shift2', '2024-01-01 16:00:00', '2024-01-02 00:00:00', 'Note2'),
('Shift3', '2024-01-02 00:00:00', '2024-01-02 08:00:00', 'Note3'),
('Shift4', '2024-01-02 08:00:00', '2024-01-02 16:00:00', 'Note4'),
('Shift5', '2024-01-02 16:00:00', '2024-01-03 00:00:00', 'Note5'),
('Shift6', '2024-01-03 00:00:00', '2024-01-03 08:00:00', 'Note6'),
('Shift7', '2024-01-03 08:00:00', '2024-01-03 16:00:00', 'Note7'),
('Shift8', '2024-01-03 16:00:00', '2024-01-04 00:00:00', 'Note8'),
('Shift9', '2024-01-04 00:00:00', '2024-01-04 08:00:00', 'Note9'),
('Shift10', '2024-01-04 08:00:00', '2024-01-04 16:00:00', 'Note10'),
('Shift11', '2024-01-04 16:00:00', '2024-01-05 00:00:00', 'Note11'),
('Shift12', '2024-01-05 00:00:00', '2024-01-05 08:00:00', 'Note12'),
('Shift13', '2024-01-05 08:00:00', '2024-01-05 16:00:00', 'Note13'),
('Shift14', '2024-01-05 16:00:00', '2024-01-06 00:00:00', 'Note14'),
('Shift15', '2024-01-06 00:00:00', '2024-01-06 08:00:00', 'Note15'),
('Shift16', '2024-01-06 08:00:00', '2024-01-06 16:00:00', 'Note16'),
('Shift17', '2024-01-06 16:00:00', '2024-01-07 00:00:00', 'Note17'),
('Shift18', '2024-01-07 00:00:00', '2024-01-07 08:00:00', 'Note18'),
('Shift19', '2024-01-07 08:00:00', '2024-01-07 16:00:00', 'Note19'),
('Shift20', '2024-01-07 16:00:00', '2024-01-08 00:00:00', 'Note20');

-- Insert into Shift_assignments (20 records, shift_id 1-20, employee_id 1-20, location_id 1-20)
INSERT INTO Shift_assignments (shift_id, employee_id, assign_date, location_id, role_in_shift) VALUES
(1, 1, '2024-01-01', 1, 'Role1'),
(2, 2, '2024-01-02', 2, 'Role2'),
(3, 3, '2024-01-03', 3, 'Role3'),
(4, 4, '2024-01-04', 4, 'Role4'),
(5, 5, '2024-01-05', 5, 'Role5'),
(6, 6, '2024-01-06', 6, 'Role6'),
(7, 7, '2024-01-07', 7, 'Role7'),
(8, 8, '2024-01-08', 8, 'Role8'),
(9, 9, '2024-01-09', 9, 'Role9'),
(10, 10, '2024-01-10', 10, 'Role10'),
(11, 11, '2024-01-11', 11, 'Role11'),
(12, 12, '2024-01-12', 12, 'Role12'),
(13, 13, '2024-01-13', 13, 'Role13'),
(14, 14, '2024-01-14', 14, 'Role14'),
(15, 15, '2024-01-15', 15, 'Role15'),
(16, 16, '2024-01-16', 16, 'Role16'),
(17, 17, '2024-01-17', 17, 'Role17'),
(18, 18, '2024-01-18', 18, 'Role18'),
(19, 19, '2024-01-19', 19, 'Role19'),
(20, 20, '2024-01-20', 20, 'Role20');

-- Insert into Attendances (20 records, assign_id 1-20, employee_id 1-20)
INSERT INTO Attendances (assign_id, employee_id, check_in, check_out, hours_worked, note) VALUES
(1, 1, '2024-01-01 08:00:00', '2024-01-01 16:00:00', 8, 'Note1'),
(2, 2, '2024-01-02 08:00:00', '2024-01-02 16:00:00', 8, 'Note2'),
(3, 3, '2024-01-03 08:00:00', '2024-01-03 16:00:00', 8, 'Note3'),
(4, 4, '2024-01-04 08:00:00', '2024-01-04 16:00:00', 8, 'Note4'),
(5, 5, '2024-01-05 08:00:00', '2024-01-05 16:00:00', 8, 'Note5'),
(6, 6, '2024-01-06 08:00:00', '2024-01-06 16:00:00', 8, 'Note6'),
(7, 7, '2024-01-07 08:00:00', '2024-01-07 16:00:00', 8, 'Note7'),
(8, 8, '2024-01-08 08:00:00', '2024-01-08 16:00:00', 8, 'Note8'),
(9, 9, '2024-01-09 08:00:00', '2024-01-09 16:00:00', 8, 'Note9'),
(10, 10, '2024-01-10 08:00:00', '2024-01-10 16:00:00', 8, 'Note10'),
(11, 11, '2024-01-11 08:00:00', '2024-01-11 16:00:00', 8, 'Note11'),
(12, 12, '2024-01-12 08:00:00', '2024-01-12 16:00:00', 8, 'Note12'),
(13, 13, '2024-01-13 08:00:00', '2024-01-13 16:00:00', 8, 'Note13'),
(14, 14, '2024-01-14 08:00:00', '2024-01-14 16:00:00', 8, 'Note14'),
(15, 15, '2024-01-15 08:00:00', '2024-01-15 16:00:00', 8, 'Note15'),
(16, 16, '2024-01-16 08:00:00', '2024-01-16 16:00:00', 8, 'Note16'),
(17, 17, '2024-01-17 08:00:00', '2024-01-17 16:00:00', 8, 'Note17'),
(18, 18, '2024-01-18 08:00:00', '2024-01-18 16:00:00', 8, 'Note18'),
(19, 19, '2024-01-19 08:00:00', '2024-01-19 16:00:00', 8, 'Note19'),
(20, 20, '2024-01-20 08:00:00', '2024-01-20 16:00:00', 8, 'Note20');

-- Insert into Payrolls (20 records, employee_id 1-20)
INSERT INTO Payrolls (employee_id, period_start, period_end, gross_amount, net_amount, created_at) VALUES
(1, '2024-01-01', '2024-01-31', 5000, 4000, '2024-02-01'),
(2, '2024-01-01', '2024-01-31', 6000, 4800, '2024-02-01'),
(3, '2024-01-01', '2024-01-31', 7000, 5600, '2024-02-01'),
(4, '2024-01-01', '2024-01-31', 8000, 6400, '2024-02-01'),
(5, '2024-01-01', '2024-01-31', 9000, 7200, '2024-02-01'),
(6, '2024-01-01', '2024-01-31', 10000, 8000, '2024-02-01'),
(7, '2024-01-01', '2024-01-31', 11000, 8800, '2024-02-01'),
(8, '2024-01-01', '2024-01-31', 12000, 9600, '2024-02-01'),
(9, '2024-01-01', '2024-01-31', 13000, 10400, '2024-02-01'),
(10, '2024-01-01', '2024-01-31', 14000, 11200, '2024-02-01'),
(11, '2024-01-01', '2024-01-31', 15000, 12000, '2024-02-01'),
(12, '2024-01-01', '2024-01-31', 16000, 12800, '2024-02-01'),
(13, '2024-01-01', '2024-01-31', 17000, 13600, '2024-02-01'),
(14, '2024-01-01', '2024-01-31', 18000, 14400, '2024-02-01'),
(15, '2024-01-01', '2024-01-31', 19000, 15200, '2024-02-01'),
(16, '2024-01-01', '2024-01-31', 20000, 16000, '2024-02-01'),
(17, '2024-01-01', '2024-01-31', 21000, 16800, '2024-02-01'),
(18, '2024-01-01', '2024-01-31', 22000, 17600, '2024-02-01'),
(19, '2024-01-01', '2024-01-31', 23000, 18400, '2024-02-01'),
(20, '2024-01-01', '2024-01-31', 24000, 19200, '2024-02-01');

-- Insert into Salary_components (20 records, payroll_id 1-20)
INSERT INTO Salary_components (payroll_id, comp_type, amount) VALUES
(1, 'Base', 4000),
(2, 'Bonus', 2000),
(3, 'Base', 5000),
(4, 'Bonus', 3000),
(5, 'Base', 6000),
(6, 'Bonus', 4000),
(7, 'Base', 7000),
(8, 'Bonus', 5000),
(9, 'Base', 8000),
(10, 'Bonus', 6000),
(11, 'Base', 9000),
(12, 'Bonus', 7000),
(13, 'Base', 10000),
(14, 'Bonus', 8000),
(15, 'Base', 11000),
(16, 'Bonus', 9000),
(17, 'Base', 12000),
(18, 'Bonus', 10000),
(19, 'Base', 13000),
(20, 'Bonus', 11000);