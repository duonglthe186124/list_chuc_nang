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
	role_name NVARCHAR(255) NOT NULL UNIQUE,
	description NVARCHAR(1000) NULL
)

CREATE TABLE Features
(
	feature_id INT IDENTITY(1,1) PRIMARY KEY,
	feature_name NVARCHAR(100) NOT NULL UNIQUE,
	description NVARCHAR(1000) NULL
)

CREATE TABLE Feature_role
(
	role_id INT NOT NULL REFERENCES Roles(role_id),
	feature_id INT NOT NULL REFERENCES Features(feature_id),
	PRIMARY KEY(role_id, feature_id)
)

CREATE TABLE Users
(
	user_id INT IDENTITY(1,1) PRIMARY KEY,
	email NVARCHAR(255) NOT NULL UNIQUE,
	password NVARCHAR(255) NOT NULL,
	fullname NVARCHAR(255) NOT NULL,
	phone NVARCHAR(20) NOT NULL,
	address NVARCHAR(255) NOT NULL,
	sec_address NVARCHAR(255) NULL,
	role_id INT NULL REFERENCES Roles(role_id),
	is_actived BIT NOT NULL DEFAULT 0,
	is_deleted BIT NOT NULL DEFAULT 0
)

CREATE TABLE Positions
(
	position_id INT IDENTITY(1,1) PRIMARY KEY,
	position_name NVARCHAR(100) NOT NULL,
	description NVARCHAR(1000) NULL
)

CREATE TABLE Employees
(
	employee_id INT IDENTITY(1,1) PRIMARY KEY,
	user_id INT NOT NULL REFERENCES Users(user_id),
	employee_code NVARCHAR(50) NOT NULL UNIQUE,
	hire_date DATETIME2(0) NOT NULL DEFAULT SYSUTCDATETIME(),
	position_id INT NOT NULL REFERENCES Positions(position_id),
	bank_account NVARCHAR(100) NULL,
	boss_id INT NULL REFERENCES Employees(employee_id)
)

CREATE TABLE Brands
(
	brand_id INT IDENTITY(1,1) PRIMARY KEY,
	brand_name NVARCHAR(100) NOT NULL UNIQUE
)

CREATE TABLE Product_specs
(
	spec_id INT IDENTITY(1,1) PRIMARY KEY,
	cpu NVARCHAR(255) NOT NULL,
	memory NVARCHAR(255) NOT NULL,
	storage NVARCHAR(255) NOT NULL,
	battery_capacity INT NOT NULL,
	color NVARCHAR(50) NOT NULL,
	screen_size DECIMAL(4,2) NOT NULL,
	screen_type NVARCHAR(50) NOT NULL,
	camera INT NOT NULL
)

CREATE TABLE Products
(
    product_id INT IDENTITY(1,1) PRIMARY KEY,
	sku_code NVARCHAR(50) NOT NULL UNIQUE,
	name NVARCHAR(200) NOT NULL,
	brand_id INT NOT NULL REFERENCES Brands(brand_id),
	spec_id INT NOT NULL REFERENCES Product_specs(spec_id),
	description NVARCHAR(1000) NULL,
	created_at DATETIME2(0) DEFAULT SYSUTCDATETIME(),
	updated_at DATETIME2(0) DEFAULT SYSUTCDATETIME()
);

CREATE TABLE Product_images
(
	image_id INT IDENTITY(1,1) PRIMARY KEY,
	product_id INT NOT NULL REFERENCES Products(product_id),
	image_url NVARCHAR(500) NOT NULL,
	alt_text NVARCHAR(255) NULL
)

CREATE TABLE Warehouse_locations
(
	location_id INT IDENTITY(1,1) PRIMARY KEY,
	code NVARCHAR(255) NOT NULL UNIQUE,
	area NVARCHAR(50) NOT NULL,
	aisle NVARCHAR(50) NOT NULL,
	slot NVARCHAR(50) NOT NULL,
	capacity INT NOT NULL,
	description NVARCHAR(1000) NULL,
	created_at DATETIME2(0) DEFAULT SYSUTCDATETIME()
)


CREATE TABLE Containers
(
	container_id INT IDENTITY(1,1) PRIMARY KEY,
	container_code VARCHAR(64) NOT NULL UNIQUE,
	location_id INT NOT NULL REFERENCES Warehouse_locations(location_id),
	created_at DATETIME2(0) DEFAULT SYSUTCDATETIME()
)

CREATE TABLE Product_units
(
	unit_id INT IDENTITY(1,1) PRIMARY KEY,
	imei NVARCHAR(50) NULL UNIQUE,
	serial_number NVARCHAR(100) NULL,
	warranty_start DATETIME2(0) DEFAULT SYSUTCDATETIME(),
	warranty_end DATETIME2(0) DEFAULT SYSUTCDATETIME(),
	product_id INT NOT NULL REFERENCES Products(product_id),
	purchase_price DECIMAL(18,2) DEFAULT NULL,
	received_date DATETIME2(0) DEFAULT NULL,
	container_id INT NOT NULL REFERENCES Containers(container_id),
	status NVARCHAR(50) NOT NULL DEFAULT 'AVAILABLE',
	created_at DATETIME2(0) DEFAULT SYSUTCDATETIME(),
	updated_at DATETIME2(0) DEFAULT SYSUTCDATETIME(),
	CONSTRAINT CHK_Product_units_status CHECK (status IN ('AVAILABLE','RESERVED','SOLD','DAMAGED','RETURNED'))
)

CREATE TABLE Orders
(
	order_id INT IDENTITY(1,1) PRIMARY KEY,
	user_id INT NULL REFERENCES Users(user_id),
	total_amount DECIMAL(18,2) NOT NULL,
	status NVARCHAR(50) NOT NULL DEFAULT 'PENDING',
	order_date DATETIME2(0) NOT NULL DEFAULT SYSUTCDATETIME(),
	CONSTRAINT CHK_Orders_status CHECK (status IN ('PENDING','CONFIRMED','SHIPPED','CANCELLED'))
)

CREATE TABLE Order_details
(
	order_no INT IDENTITY(1,1) PRIMARY KEY,
	order_id INT NULL REFERENCES Orders(order_id),
	unit_id INT NULL REFERENCES Product_units(unit_id),
	qty INT NOT NULL,
	unit_price DECIMAL(18,2) NOT NULL,
	line_amount DECIMAL(18,2) NOT NULL
)

CREATE TABLE Suppliers
(
	supplier_id INT IDENTITY(1,1) PRIMARY KEY,
	supplier_name NVARCHAR(100) NOT NULL,
	display_name NVARCHAR(250) NOT NULL,
	address NVARCHAR(255) NOT NULL,
	phone NVARCHAR(20) NOT NULL,
	email NVARCHAR(255) NOT NULL,
	representative NVARCHAR(255) NOT NULL,
	payment_method NVARCHAR(100) NOT NULL,
	note NVARCHAR(1000) NULL
)

CREATE TABLE Purchase_orders
(
	po_id INT IDENTITY(1,1) PRIMARY KEY,
	po_code NVARCHAR(100) NOT NULL UNIQUE,
	supplier_id INT NOT NULL REFERENCES Suppliers(supplier_id),
	created_by INT NOT NULL REFERENCES Employees(employee_id),
	created_at DATETIME2(0) NOT NULL DEFAULT SYSUTCDATETIME(),
	status NVARCHAR(50) NOT NULL DEFAULT 'PENDING',
	total_amount DECIMAL(18,2) NOT NULL,
	note NVARCHAR(MAX) NULL,
	CONSTRAINT CHK_Purchase_orders_status CHECK (status IN ('PENDING','ACTIVE','COMPLETED','CANCELLED'))
)

CREATE TABLE Purchase_order_lines
(
	po_line_id INT IDENTITY(1,1) PRIMARY KEY,
	po_id INT NOT NULL REFERENCES Purchase_orders(po_id),
	product_id INT NOT NULL REFERENCES Products(product_id),
	unit_price DECIMAL(18,2) NOT NULL,
	qty INT NOT NULL
)

CREATE TABLE Receipts
(
	receipts_id INT IDENTITY(1,1) PRIMARY KEY,
	receipts_no NVARCHAR(50) NOT NULL UNIQUE,
	po_id INT NOT NULL REFERENCES Purchase_orders(po_id),
	received_by INT NOT NULL REFERENCES Employees(employee_id),
	status NVARCHAR(50) NOT NULL DEFAULT 'PENDING',
	note NVARCHAR(MAX) NULL,
	received_at DATETIME2(0) DEFAULT SYSUTCDATETIME(),
	CONSTRAINT CHK_Receipts_status CHECK (status IN ('PENDING','RECEIVED','PARTIAL','CANCELLED'))
)

CREATE TABLE Receipt_lines
(
	line_id INT IDENTITY(1,1) PRIMARY KEY,
	receipt_id INT NOT NULL REFERENCES Receipts(receipts_id),
	product_id INT NOT NULL REFERENCES Products(product_id),
	qty_expected INT NOT NULL,
	qty_received INT DEFAULT 0,
	unit_price DECIMAL(18,2) DEFAULT NULL,
	note NVARCHAR(255) DEFAULT NULL
)

CREATE TABLE Receipt_units
(
	id INT IDENTITY(1,1) PRIMARY KEY,
	line_id INT NOT NULL REFERENCES Receipt_lines(line_id),
	unit_id INT NOT NULL REFERENCES Product_units(unit_id) UNIQUE
)

CREATE TABLE Shipments
(
	shipment_id INT IDENTITY(1,1) PRIMARY KEY,
	shipment_no NVARCHAR(50) NOT NULL UNIQUE,
	order_id INT NOT NULL REFERENCES Orders(order_id),
	created_by INT NOT NULL REFERENCES Employees(employee_id),
	requested_at DATETIME2(0) DEFAULT SYSUTCDATETIME(),
	status NVARCHAR(50) NOT NULL DEFAULT 'PENDING',
	note NVARCHAR(1000) NULL,
	CONSTRAINT CHK_Shipments_status CHECK (status IN ('PENDING','PICKED','SHIPPED','CANCELLED'))
)

CREATE TABLE Shipment_lines
(
	line_id INT IDENTITY(1,1) PRIMARY KEY,
	shipment_id INT NOT NULL REFERENCES Shipments(shipment_id),
	product_id INT NOT NULL REFERENCES Products(product_id),
	qty INT NOT NULL
)

CREATE TABLE Shipment_units
(
	id INT IDENTITY(1,1) PRIMARY KEY,
	line_id INT NOT NULL REFERENCES Shipment_lines(line_id),
	unit_id INT NOT NULL REFERENCES Product_units(unit_id)
)

CREATE TABLE Stock_adjustments
(
	adjustment_id INT IDENTITY(1,1) PRIMARY KEY,
	adjustment_no NVARCHAR(50) UNIQUE,
	product_id INT NULL REFERENCES Products(product_id),
	unit_id INT NULL REFERENCES Product_units(unit_id),
	qty_before INT NULL,
	qty_after INT NULL,
	delta INT NULL,
	reason NVARCHAR(255) NULL,
	created_by INT NOT NULL REFERENCES Employees(employee_id),
	created_at DATETIME2(0) DEFAULT SYSUTCDATETIME()
)

CREATE TABLE Shifts
(
	shift_id INT IDENTITY(1,1) PRIMARY KEY,
	name NVARCHAR(100) NOT NULL,
	start_time TIME NOT NULL,
	end_time TIME NOT NULL,
	note NVARCHAR(1000) NULL
)

CREATE TABLE Shift_assignments
(
	assign_id INT IDENTITY(1,1) PRIMARY KEY,
	shift_id INT NOT NULL REFERENCES Shifts(shift_id),
	employee_id INT NOT NULL REFERENCES Employees(employee_id),
	assign_date DATE NOT NULL,
	location_id INT REFERENCES Warehouse_locations(location_id),
	role_in_shift NVARCHAR(100) NOT NULL
)

CREATE TABLE Attendances
(
	attendance_id INT IDENTITY(1,1) PRIMARY KEY,
	assign_id INT NOT NULL REFERENCES Shift_assignments(assign_id),
	employee_id INT NOT NULL REFERENCES Employees(employee_id),
	check_in DATETIME2(0) NOT NULL,
	check_out DATETIME2(0) NULL,
	hours_worked FLOAT NULL,
	note NVARCHAR(1000) NULL
)

CREATE TABLE Payrolls
(
	payroll_id INT IDENTITY(1,1) PRIMARY KEY,
	employee_id INT NOT NULL REFERENCES Employees(employee_id),
	period_start DATE NOT NULL,
	period_end DATE NOT NULL,
	gross_amount DECIMAL(18,2) NOT NULL,
	net_amount DECIMAL(18,2) NOT NULL,
	created_at DATETIME2(0) NOT NULL DEFAULT SYSUTCDATETIME()
)

CREATE TABLE Salary_components
(
	comp_id INT IDENTITY(1,1) PRIMARY KEY,
	payroll_id INT NOT NULL REFERENCES Payrolls(payroll_id),
	comp_type NVARCHAR(50) NOT NULL,
	amount DECIMAL(18,2) NOT NULL
)



CREATE TABLE Returns (
    return_id INT IDENTITY(1,1) PRIMARY KEY,
    return_no NVARCHAR(100) NOT NULL UNIQUE,
    order_id INT NOT NULL REFERENCES Orders(order_id),
    created_by INT NOT NULL REFERENCES Users(user_id),       
    created_at DATETIME2(0) NOT NULL DEFAULT SYSUTCDATETIME(),
    status NVARCHAR(50) NOT NULL DEFAULT 'OPEN',
	CONSTRAINT CHK_Returns_status CHECK (status IN ('OPEN','RECEIVED','INSPECTED','RESOLVED'))
);

CREATE TABLE Return_lines (
    return_line_id INT IDENTITY(1,1) PRIMARY KEY,
    return_id INT NOT NULL REFERENCES Returns(return_id),
    unit_id INT NULL REFERENCES Product_units(unit_id),
    reason NVARCHAR(1000) NULL,
);

CREATE TABLE Quality_Inspections
(
  inspection_id    INT IDENTITY(1,1) PRIMARY KEY,
  inspection_no    NVARCHAR(50) NOT NULL UNIQUE,            
  unit_id          INT NULL REFERENCES Product_units(unit_id),   
  location_id      INT NULL REFERENCES Warehouse_locations(location_id),
  inspected_by     INT NULL REFERENCES Employees(employee_id),
  inspected_at     DATETIME2(0) NOT NULL DEFAULT SYSUTCDATETIME(),
  status           NVARCHAR(20) NOT NULL DEFAULT 'PENDING', 
  result           NVARCHAR(200) NULL,                     
  note             NVARCHAR(1000) NULL,                     
  CONSTRAINT CHK_QualityStatus CHECK (status IN ('PENDING','PASSED','FAILED','QUARANTINE'))
);

CREATE TABLE PO_Cache(
	po_code_head NVARCHAR(50) DEFAULT 'PO',
	po_code_date DATETIME,
	po_code_no INT
)

CREATE TABLE PNK_Cache(
	receipt_code_head NVARCHAR(50) DEFAULT 'PNK',
	receipt_code_date DATETIME,
	receipt_code_no INT
)

USE SWP391_WarehouseManagements
GO

-- Insert data into Roles
INSERT INTO Roles (role_name, description) VALUES
('Admin', 'System administrator with full access'),
('Warehouse Manager', 'Manages warehouse operations'),
('Inventory Staff', 'Handles inventory and stock'),
('Sales Staff', 'Manages customer orders'),
('HR Manager', 'Manages employee records and payroll'),
('Quality Inspector', 'Performs quality checks'),
('Purchase Manager', 'Handles purchase orders'),
('Shipment Coordinator', 'Manages shipments'),
('Employee', 'General employee role'),
('Guest', 'Limited access for external users');

-- Insert data into Features
INSERT INTO Features (feature_name, description) VALUES
('Manage Users', 'Manage user accounts'),
('View Inventory', 'View stock levels'),
('Update Inventory', 'Update stock quantities'),
('Create Purchase Order', 'Create new purchase orders'),
('Manage Shipments', 'Manage shipment processes'),
('Perform Quality Inspection', 'Conduct quality checks'),
('Manage Payroll', 'Handle payroll processing'),
('View Reports', 'Access system reports'),
('Manage Roles', 'Assign and modify roles'),
('Track Attendance', 'Record employee attendance');

-- Insert data into Feature_role
INSERT INTO Feature_role (role_id, feature_id) VALUES
(1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 6), (1, 7), (1, 8), (1, 9), (1, 10),
(2, 2), (2, 3), (2, 4), (2, 5), (2, 6),
(3, 2), (3, 3), (3, 6),
(4, 2), (4, 5),
(5, 7), (5, 10);

-- Insert data into Users
INSERT INTO Users (email, password, fullname, phone, address, sec_address, role_id, is_actived, is_deleted) VALUES
('admin@warehouse.com', 'pass123', 'John Admin', '0123456789', '123 Main St', NULL, 1, 1, 0),
('manager@warehouse.com', 'pass456', 'Jane Manager', '0987654321', '456 Oak Ave', '789 Pine Rd', 2, 1, 0),
('inventory@warehouse.com', 'pass789', 'Bob Inventory', '0234567890', '789 Elm St', NULL, 3, 1, 0),
('sales@warehouse.com', 'pass101', 'Alice Sales', '0345678901', '101 Birch Rd', NULL, 4, 1, 0),
('hr@warehouse.com', 'pass112', 'Tom HR', '0456789012', '202 Cedar Ln', NULL, 5, 1, 0),
('inspector@warehouse.com', 'pass131', 'Emma Inspector', '0567890123', '303 Maple Dr', NULL, 6, 1, 0),
('purchase@warehouse.com', 'pass415', 'Mike Purchase', '0678901234', '404 Walnut St', NULL, 7, 1, 0),
('shipment@warehouse.com', 'pass161', 'Sarah Shipment', '0789012345', '505 Spruce Ave', NULL, 8, 1, 0),
('employee1@warehouse.com', 'pass718', 'David Employee', '0890123456', '606 Ash St', NULL, 9, 1, 0),
('guest@warehouse.com', 'pass192', 'Guest User', '0901234567', '707 Willow Rd', NULL, 10, 1, 0);

-- Insert data into Positions
INSERT INTO Positions (position_name, description) VALUES
('System Admin', 'Manages IT systems'),
('Warehouse Supervisor', 'Oversees warehouse operations'),
('Inventory Clerk', 'Tracks inventory'),
('Sales Representative', 'Handles sales'),
('HR Specialist', 'Manages HR tasks'),
('Quality Control', 'Performs inspections'),
('Procurement Officer', 'Manages purchases'),
('Logistics Coordinator', 'Coordinates shipments'),
('General Worker', 'General warehouse tasks'),
('Accountant', 'Handles financial records');

-- Insert data into Employees
INSERT INTO Employees (user_id, employee_code, hire_date, position_id, bank_account, boss_id) VALUES
(1, 'EMP001', '2023-01-01', 1, '1234567890', NULL),
(2, 'EMP002', '2023-02-01', 2, '2345678901', 1),
(3, 'EMP003', '2023-03-01', 3, '3456789012', 2),
(4, 'EMP004', '2023-04-01', 4, '4567890123', 2),
(5, 'EMP005', '2023-05-01', 5, '5678901234', 1),
(6, 'EMP006', '2023-06-01', 6, '6789012345', 2),
(7, 'EMP007', '2023-07-01', 7, '7890123456', 2),
(8, 'EMP008', '2023-08-01', 8, '8901234567', 2),
(9, 'EMP009', '2023-09-01', 9, '9012345678', 2),
(10, 'EMP010', '2023-10-01', 10, '0123456789', 1);

-- Insert data into Brands (20 records)
INSERT INTO Brands (brand_name) VALUES
('Apple'), ('Samsung'), ('Xiaomi'), ('Oppo'), ('Vivo'), ('Huawei'), ('Sony'), ('LG'), ('Nokia'), ('OnePlus'),
('Realme'), ('Asus'), ('Lenovo'), ('Motorola'), ('Google'), ('HTC'), ('ZTE'), ('Vsmart'), ('BlackBerry'), ('Poco');

-- Insert data into Product_specs (20 records)
INSERT INTO Product_specs (cpu, memory, storage, battery_capacity, color, screen_size, screen_type, camera) VALUES
('A16 Bionic', '6GB', '128GB', 3200, 'Black', 6.1, 'OLED', 48),
('Exynos 2200', '8GB', '256GB', 4000, 'White', 6.2, 'AMOLED', 50),
('Snapdragon 8 Gen 2', '12GB', '512GB', 4500, 'Blue', 6.7, 'AMOLED', 64),
('Dimensity 9000', '8GB', '128GB', 5000, 'Green', 6.5, 'IPS', 48),
('A15 Bionic', '4GB', '64GB', 3000, 'Red', 5.4, 'OLED', 12),
('Kirin 9000', '8GB', '256GB', 4400, 'Silver', 6.6, 'OLED', 50),
('Snapdragon 870', '6GB', '128GB', 4200, 'Gold', 6.4, 'AMOLED', 48),
('Helio G95', '6GB', '64GB', 5000, 'Black', 6.5, 'IPS', 64),
('A14 Bionic', '4GB', '256GB', 2815, 'White', 6.1, 'OLED', 12),
('Snapdragon 888', '12GB', '256GB', 4500, 'Blue', 6.7, 'AMOLED', 108),
('Dimensity 1200', '8GB', '128GB', 4000, 'Green', 6.3, 'AMOLED', 50),
('Exynos 2100', '8GB', '128GB', 4800, 'Black', 6.2, 'AMOLED', 64),
('Snapdragon 865', '6GB', '128GB', 4300, 'Silver', 6.5, 'IPS', 48),
('A13 Bionic', '4GB', '64GB', 3110, 'Red', 6.1, 'LCD', 12),
('Kirin 990', '8GB', '256GB', 4200, 'Gold', 6.4, 'OLED', 40),
('Snapdragon 765G', '6GB', '128GB', 4100, 'Blue', 6.4, 'AMOLED', 48),
('Helio P90', '4GB', '64GB', 4000, 'Black', 6.3, 'IPS', 48),
('Dimensity 800U', '6GB', '128GB', 3800, 'White', 6.5, 'AMOLED', 64),
('Snapdragon 855', '8GB', '256GB', 4000, 'Green', 6.4, 'AMOLED', 48),
('Exynos 990', '8GB', '128GB', 4300, 'Silver', 6.7, 'AMOLED', 64);

-- Insert data into Products (20 records)
INSERT INTO Products (sku_code, name, brand_id, spec_id, description) VALUES
('SKU001', 'iPhone 14', 1, 1, 'Latest iPhone model'),
('SKU002', 'Galaxy S23', 2, 2, 'Flagship Samsung phone'),
('SKU003', 'Mi 13', 3, 3, 'High-performance Xiaomi phone'),
('SKU004', 'Reno 8', 4, 4, 'Sleek Oppo smartphone'),
('SKU005', 'Vivo X80', 5, 5, 'Vivo flagship device'),
('SKU006', 'P50 Pro', 6, 6, 'Huawei premium phone'),
('SKU007', 'Xperia 1 IV', 7, 7, 'Sony multimedia phone'),
('SKU008', 'G8 ThinQ', 8, 8, 'LG innovative phone'),
('SKU009', 'Nokia G50', 9, 9, 'Affordable Nokia phone'),
('SKU010', 'OnePlus 10 Pro', 10, 10, 'High-speed OnePlus device'),
('SKU011', 'Realme GT', 11, 11, 'Budget performance phone'),
('SKU012', 'Zenfone 8', 12, 12, 'Compact Asus phone'),
('SKU013', 'Moto G Power', 13, 13, 'Long battery life phone'),
('SKU014', 'Pixel 6', 14, 14, 'Google AI-powered phone'),
('SKU015', 'HTC U12', 15, 15, 'HTC flagship device'),
('SKU016', 'ZTE Axon', 16, 16, 'ZTE premium phone'),
('SKU017', 'Vsmart Joy', 17, 17, 'Affordable Vsmart phone'),
('SKU018', 'BlackBerry Key2', 18, 18, 'Physical keyboard phone'),
('SKU019', 'Poco F4', 19, 19, 'High-value Poco phone'),
('SKU020', 'Galaxy A53', 2, 20, 'Mid-range Samsung phone');

-- Insert data into Product_images (20 records)
INSERT INTO Product_images (product_id, image_url, alt_text) VALUES
(1, 'http://example.com/images/iphone14.jpg', 'iPhone 14 front view'),
(2, 'http://example.com/images/galaxys23.jpg', 'Galaxy S23 side view'),
(3, 'http://example.com/images/mi13.jpg', 'Mi 13 back view'),
(4, 'http://example.com/images/reno8.jpg', 'Reno 8 front view'),
(5, 'http://example.com/images/vivox80.jpg', 'Vivo X80 side view'),
(6, 'http://example.com/images/p50pro.jpg', 'P50 Pro back view'),
(7, 'http://example.com/images/xperia1iv.jpg', 'Xperia 1 IV front view'),
(8, 'http://example.com/images/g8thinq.jpg', 'G8 ThinQ side view'),
(9, 'http://example.com/images/nokiag50.jpg', 'Nokia G50 back view'),
(10, 'http://example.com/images/oneplus10pro.jpg', 'OnePlus 10 Pro front view'),
(11, 'http://example.com/images/realmegt.jpg', 'Realme GT side view'),
(12, 'http://example.com/images/zenfone8.jpg', 'Zenfone 8 back view'),
(13, 'http://example.com/images/motogpower.jpg', 'Moto G Power front view'),
(14, 'http://example.com/images/pixel6.jpg', 'Pixel 6 side view'),
(15, 'http://example.com/images/htcu12.jpg', 'HTC U12 back view'),
(16, 'http://example.com/images/zteaxon.jpg', 'ZTE Axon front view'),
(17, 'http://example.com/images/vsmartjoy.jpg', 'Vsmart Joy side view'),
(18, 'http://example.com/images/blackberrykey2.jpg', 'BlackBerry Key2 back view'),
(19, 'http://example.com/images/pocof4.jpg', 'Poco F4 front view'),
(20, 'http://example.com/images/galaxya53.jpg', 'Galaxy A53 side view');

-- Insert data into Warehouse_locations
INSERT INTO Warehouse_locations (code, area, aisle, slot, capacity, description) VALUES
('LOC001', 'A', '1', 'S1', 100, 'Main storage area'),
('LOC002', 'A', '1', 'S2', 80, 'Secondary storage'),
('LOC003', 'B', '2', 'S1', 120, 'High-capacity storage'),
('LOC004', 'B', '2', 'S2', 90, 'Medium storage'),
('LOC005', 'C', '3', 'S1', 150, 'Large storage area'),
('LOC006', 'C', '3', 'S2', 70, 'Small storage'),
('LOC007', 'D', '4', 'S1', 100, 'Electronics storage'),
('LOC008', 'D', '4', 'S2', 60, 'Fragile items storage'),
('LOC009', 'E', '5', 'S1', 110, 'General storage'),
('LOC010', 'E', '5', 'S2', 85, 'Backup storage');

-- Insert data into Containers
INSERT INTO Containers (container_code, location_id) VALUES
('CONT001', 1),
('CONT002', 2),
('CONT003', 3),
('CONT004', 4),
('CONT005', 5),
('CONT006', 6),
('CONT007', 7),
('CONT008', 8),
('CONT009', 9),
('CONT010', 10);

-- Insert data into Product_units (20 records)
INSERT INTO Product_units (imei, serial_number, warranty_start, warranty_end, product_id, purchase_price, received_date, container_id, status) VALUES
('IMEI001', 'SN001', '2023-01-01', '2024-01-01', 1, 999.99, '2023-01-01', 1, 'AVAILABLE'),
('IMEI002', 'SN002', '2023-02-01', '2024-02-01', 2, 899.99, '2023-02-01', 2, 'AVAILABLE'),
('IMEI003', 'SN003', '2023-03-01', '2024-03-01', 3, 799.99, '2023-03-01', 3, 'AVAILABLE'),
('IMEI004', 'SN004', '2023-04-01', '2024-04-01', 4, 699.99, '2023-04-01', 4, 'AVAILABLE'),
('IMEI005', 'SN005', '2023-05-01', '2024-05-01', 5, 599.99, '2023-05-01', 5, 'AVAILABLE'),
('IMEI006', 'SN006', '2023-06-01', '2024-06-01', 6, 1099.99, '2023-06-01', 6, 'AVAILABLE'),
('IMEI007', 'SN007', '2023-07-01', '2024-07-01', 7, 999.99, '2023-07-01', 7, 'AVAILABLE'),
('IMEI008', 'SN008', '2023-08-01', '2024-08-01', 8, 499.99, '2023-08-01', 8, 'AVAILABLE'),
('IMEI009', 'SN009', '2023-09-01', '2024-09-01', 9, 399.99, '2023-09-01', 9, 'AVAILABLE'),
('IMEI010', 'SN010', '2023-10-01', '2024-10-01', 10, 899.99, '2023-10-01', 10, 'AVAILABLE'),
('IMEI011', 'SN011', '2023-11-01', '2024-11-01', 11, 499.99, '2023-11-01', 1, 'AVAILABLE'),
('IMEI012', 'SN012', '2023-12-01', '2024-12-01', 12, 699.99, '2023-12-01', 2, 'AVAILABLE'),
('IMEI013', 'SN013', '2024-01-01', '2025-01-01', 13, 599.99, '2024-01-01', 3, 'AVAILABLE'),
('IMEI014', 'SN014', '2024-02-01', '2025-02-01', 14, 799.99, '2024-02-01', 4, 'AVAILABLE'),
('IMEI015', 'SN015', '2024-03-01', '2025-03-01', 15, 499.99, '2024-03-01', 5, 'AVAILABLE'),
('IMEI016', 'SN016', '2024-04-01', '2025-04-01', 16, 399.99, '2024-04-01', 6, 'AVAILABLE'),
('IMEI017', 'SN017', '2024-05-1', '2025-05-01', 17, 299.99, '2024-05-01', 7, 'AVAILABLE'),
('IMEI018', 'SN018', '2024-06-01', '2025-06-01', 18, 599.99, '2024-06-01', 8, 'AVAILABLE'),
('IMEI019', 'SN019', '2024-07-01', '2025-07-01', 19, 499.99, '2024-07-01', 9, 'AVAILABLE'),
('IMEI020', 'SN020', '2024-08-01', '2025-08-01', 20, 599.99, '2024-08-01', 10, 'AVAILABLE'),
('IMEI021', 'SN021', '2024-08-01', '2025-08-01', 20, 599.99, '2024-08-01', 10, 'AVAILABLE'),
('IMEI022', 'SN022', '2024-08-01', '2025-08-01', 20, 599.99, '2024-08-01', 10, 'AVAILABLE'),
('IMEI023', 'SN023', '2024-08-01', '2025-08-01', 20, 599.99, '2024-08-01', 10, 'AVAILABLE');

-- Insert data into Orders
INSERT INTO Orders (user_id, total_amount, status, order_date) VALUES
(4, 1999.98, 'SHIPPED', '2023-01-01'),
(4, 2699.97, 'CONFIRMED', '2023-02-01'),
(4, 3199.96, 'PENDING', '2023-03-01'),
(4, 3499.95, 'SHIPPED', '2023-04-01'),
(4, 599.99, 'CANCELLED', '2023-05-01'),
(4, 2199.98, 'SHIPPED', '2023-06-01'),
(4, 2999.97, 'CONFIRMED', '2023-07-01'),
(4, 1999.96, 'SHIPPED', '2023-08-01'),
(4, 1999.95, 'PENDING', '2023-09-01'),
(4, 1799.98, 'SHIPPED', '2023-10-01');

-- Insert data into Order_details
INSERT INTO Order_details (order_id, unit_id, qty, unit_price, line_amount) VALUES
(1, 1, 2, 999.99, 1999.98),
(2, 2, 3, 899.99, 2699.97),
(3, 3, 4, 799.99, 3199.96),
(4, 4, 5, 699.99, 3499.95),
(5, 5, 1, 599.99, 599.99),
(6, 6, 2, 1099.99, 2199.98),
(7, 7, 3, 999.99, 2999.97),
(8, 8, 4, 499.99, 1999.96),
(9, 9, 5, 399.99, 1999.95),
(10, 10, 2, 899.99, 1799.98);


-- Insert data into Suppliers
INSERT INTO Suppliers (supplier_name, display_name, address, phone, email, representative, payment_method, note) VALUES
('TechSupply', 'Tech Supply Co.', '123 Tech Rd', '0123456789', 'contact@techsupply.com', 'John Supplier', 'Bank Transfer', NULL),
('GadgetWorld', 'Gadget World Ltd.', '456 Gadget St', '0987654321', 'info@gadgetworld.com', 'Jane Supplier', 'Credit Card', 'Reliable supplier'),
('ElectroMart', 'Electro Mart Inc.', '789 Electro Ave', '0234567890', 'sales@electromart.com', 'Bob Supplier', 'Bank Transfer', NULL),
('PhoneZone', 'Phone Zone Corp.', '101 Phone Rd', '0345678901', 'contact@phonezone.com', 'Alice Supplier', 'Cash', NULL),
('TechTrend', 'Tech Trend Ltd.', '202 Trend St', '0456789012', 'info@techtrend.com', 'Tom Supplier', 'Bank Transfer', NULL),
('MobileHub', 'Mobile Hub Inc.', '303 Hub Ave', '0567890123', 'sales@mobilehub.com', 'Emma Supplier', 'Credit Card', NULL),
('GizmoSupply', 'Gizmo Supply Co.', '404 Gizmo Rd', '0678901234', 'contact@gizmosupply.com', 'Mike Supplier', 'Bank Transfer', NULL),
('TechBit', 'Tech Bit Ltd.', '505 Bit St', '0789012345', 'info@techbit.com', 'Sarah Supplier', 'Cash', NULL),
('SmartZone', 'Smart Zone Corp.', '606 Zone Ave', '0890123456', 'sales@smartzone.com', 'David Supplier', 'Bank Transfer', NULL),
('ElectroTrend', 'Electro Trend Inc.', '707 Trend Rd', '0901234567', 'contact@electrotrend.com', 'Guest Supplier', 'Credit Card', NULL);

-- Insert data into Purchase_orders
INSERT INTO Purchase_orders (po_code, supplier_id, created_by, created_at, status, total_amount) VALUES
('PO001', 1, 7, '2023-01-01', 'COMPLETED', 9999.90),
('PO002', 2, 7, '2023-02-01', 'ACTIVE', 8999.90),
('PO003', 3, 7, '2023-03-01', 'PENDING', 7999.90),
('PO004', 4, 7, '2023-04-01', 'COMPLETED', 6999.90),
('PO005', 5, 7, '2023-05-01', 'CANCELLED', 5999.90),
('PO006', 6, 7, '2023-06-01', 'ACTIVE', 10999.90),
('PO007', 7, 7, '2023-07-01', 'PENDING', 9999.90),
('PO008', 8, 7, '2023-08-01', 'COMPLETED', 4999.90),
('PO009', 9, 7, '2023-09-01', 'ACTIVE', 3999.90),
('PO010', 10, 7, '2023-10-01', 'COMPLETED', 8999.90);

-- Insert data into Purchase_order_lines
INSERT INTO Purchase_order_lines (po_id, product_id, unit_price, qty) VALUES
(1, 1, 999.99, 10),
(2, 2, 899.99, 10),
(3, 3, 799.99, 10),
(4, 4, 699.99, 10),
(5, 5, 599.99, 10),
(6, 6, 1099.99, 10),
(7, 7, 999.99, 10),
(8, 8, 499.99, 10),
(9, 9, 399.99, 10),
(10, 10, 899.99, 10);

-- Insert data into Receipts
INSERT INTO Receipts (receipts_no, po_id, received_by, status, note, received_at) VALUES
('REC001', 1, 3, 'RECEIVED', 'Received in full', '2023-01-02'),
('REC002', 2, 3, 'PARTIAL', 'Partial delivery', '2023-02-02'),
('REC003', 3, 3, 'PENDING', NULL, '2023-03-02'),
('REC004', 4, 3, 'RECEIVED', 'Complete', '2023-04-02'),
('REC005', 5, 3, 'CANCELLED', 'Order cancelled', '2023-05-02'),
('REC006', 6, 3, 'RECEIVED', 'Received in full', '2023-06-02'),
('REC007', 7, 3, 'PENDING', NULL, '2023-07-02'),
('REC008', 8, 3, 'RECEIVED', 'Complete', '2023-08-02'),
('REC009', 9, 3, 'PARTIAL', 'Missing items', '2023-09-02'),
('REC010', 10, 3, 'RECEIVED', 'Complete', '2023-10-02'),
('REC011', 10, 3, 'RECEIVED', 'Complete', '2023-10-02');

-- Insert data into Receipt_lines
INSERT INTO Receipt_lines (receipt_id, product_id, qty_expected, qty_received, unit_price, note) VALUES
(1, 1, 10, 10, 999.99, 'All units received'),
(2, 2, 10, 5, 899.99, 'Partial delivery'),
(3, 3, 10, 0, 799.99, 'Pending delivery'),
(4, 4, 10, 10, 699.99, 'All units received'),
(5, 5, 10, 0, 599.99, 'Order cancelled'),
(6, 6, 10, 10, 1099.99, 'All units received'),
(7, 7, 10, 0, 999.99, 'Pending delivery'),
(8, 8, 10, 10, 499.99, 'All units received'),
(9, 9, 10, 8, 399.99, 'Missing 2 units'),
(10, 10, 10, 10, 899.99, 'All units received'),
(11, 10, 50, 38, 899.99, 'All units received'),
(11, 1, 35, 24, 253.33, 'All unit received');

-- Insert data into Receipt_units
INSERT INTO Receipt_units (line_id, unit_id) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
(6, 6), (7, 7), (8, 8), (9, 9), (10, 10), (10, 11), (10, 12);

-- Insert data into Shipments
INSERT INTO Shipments (shipment_no, order_id, created_by, requested_at, status, note) VALUES
('SHP001', 4, 8, '2023-01-05', 'SHIPPED', 'Shipped to customer'),
('SHP002', 4, 8, '2023-02-05', 'PICKED', 'Ready for shipping'),
('SHP003', 4, 8, '2023-03-05', 'PENDING', NULL),
('SHP004', 4, 8, '2023-04-05', 'SHIPPED', 'Shipped to customer'),
('SHP005', 4, 8, '2023-05-05', 'CANCELLED', 'Customer cancelled'),
('SHP006', 4, 8, '2023-06-05', 'SHIPPED', 'Shipped to customer'),
('SHP007', 4, 8, '2023-07-05', 'PENDING', NULL),
('SHP008', 4, 8, '2023-08-05', 'SHIPPED', 'Shipped to customer'),
('SHP009', 4, 8, '2023-09-05', 'PICKED', 'Ready for shipping'),
('SHP010', 4, 8, '2023-10-05', 'SHIPPED', 'Shipped to customer');

-- Insert data into Shipment_lines
INSERT INTO Shipment_lines (shipment_id, product_id, qty) VALUES
(1, 1, 2),
(2, 2, 3),
(3, 3, 4),
(4, 4, 5),
(5, 5, 0),
(6, 6, 2),
(7, 7, 3),
(8, 8, 4),
(9, 9, 5),
(10, 10, 2);

-- Insert data into Shipment_units
INSERT INTO Shipment_units (line_id, unit_id) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
(6, 6), (7, 7), (8, 8), (9, 9), (10, 10);

-- Insert data into Stock_adjustments
INSERT INTO Stock_adjustments (adjustment_no, product_id, unit_id, qty_before, qty_after, delta, reason, created_by) VALUES
('ADJ001', 1, 1, 10, 8, -2, 'Damaged units', 3),
('ADJ002', 2, 2, 10, 9, -1, 'Lost unit', 3),
('ADJ003', 3, 3, 10, 10, 0, 'Stock check', 3),
('ADJ004', 4, 4, 10, 12, 2, 'Found units', 3),
('ADJ005', 5, 5, 10, 8, -2, 'Theft', 3),
('ADJ006', 6, 6, 10, 9, -1, 'Damaged unit', 3),
('ADJ007', 7, 7, 10, 10, 0, 'Stock verification', 3),
('ADJ008', 8, 8, 10, 11, 1, 'Extra unit found', 3),
('ADJ009', 9, 9, 10, 7, -3, 'Damaged units', 3),
('ADJ010', 10, 10, 10, 9, -1, 'Lost unit', 3);


-- Insert data into Shifts
INSERT INTO Shifts (name, start_time, end_time, note) VALUES
('Morning Shift', '08:00:00', '16:00:00', 'Main warehouse shift'),
('Afternoon Shift', '16:00:00', '00:00:00', 'Evening warehouse shift'),
('Night Shift', '00:00:00', '08:00:00', 'Overnight shift'),
('Weekend Morning', '09:00:00', '17:00:00', 'Weekend shift'),
('Weekend Afternoon', '17:00:00', '01:00:00', 'Weekend evening shift'),
('Morning Inspection', '07:00:00', '15:00:00', 'Inspection shift'),
('Afternoon Inspection', '15:00:00', '23:00:00', 'Evening inspection'),
('Morning Packing', '08:00:00', '16:00:00', 'Packing shift'),
('Afternoon Packing', '16:00:00', '00:00:00', 'Evening packing'),
('Admin Shift', '09:00:00', '17:00:00', 'Admin tasks');

-- Insert data into Shift_assignments
INSERT INTO Shift_assignments (shift_id, employee_id, assign_date, location_id, role_in_shift) VALUES
(1, 3, '2023-01-01', 1, 'Inventory Clerk'),
(2, 4, '2023-01-01', 2, 'Sales Representative'),
(3, 6, '2023-01-01', 3, 'Quality Inspector'),
(4, 8, '2023-01-01', 4, 'Logistics Coordinator'),
(5, 9, '2023-01-01', 5, 'General Worker'),
(6, 6, '2023-01-02', 6, 'Quality Inspector'),
(7, 3, '2023-01-02', 7, 'Inventory Clerk'),
(8, 4, '2023-01-02', 8, 'Sales Representative'),
(9, 8, '2023-01-02', 9, 'Logistics Coordinator'),
(10, 1, '2023-01-02', 10, 'System Admin');

-- Insert data into Attendances
INSERT INTO Attendances (assign_id, employee_id, check_in, check_out, hours_worked, note) VALUES
(1, 3, '2023-01-01 08:00:00', '2023-01-01 16:00:00', 8.0, NULL),
(2, 4, '2023-01-01 16:00:00', '2023-01-02 00:00:00', 8.0, NULL),
(3, 6, '2023-01-01 00:00:00', '2023-01-01 08:00:00', 8.0, NULL),
(4, 8, '2023-01-01 09:00:00', '2023-01-01 17:00:00', 8.0, NULL),
(5, 9, '2023-01-01 17:00:00', '2023-01-02 01:00:00', 8.0, NULL),
(6, 6, '2023-01-02 07:00:00', '2023-01-02 15:00:00', 8.0, NULL),
(7, 3, '2023-01-02 08:00:00', '2023-01-02 16:00:00', 8.0, NULL),
(8, 4, '2023-01-02 16:00:00', '2023-01-03 00:00:00', 8.0, NULL),
(9, 8, '2023-01-02 08:00:00', '2023-01-02 16:00:00', 8.0, NULL),
(10, 1, '2023-01-02 09:00:00', '2023-01-02 17:00:00', 8.0, NULL);

-- Insert data into Payrolls
INSERT INTO Payrolls (employee_id, period_start, period_end, gross_amount, net_amount, created_at) VALUES
(1, '2023-01-01', '2023-01-31', 5000.00, 4500.00, '2023-02-01'),
(2, '2023-01-01', '2023-01-31', 4000.00, 3600.00, '2023-02-01'),
(3, '2023-01-01', '2023-01-31', 3000.00, 2700.00, '2023-02-01'),
(4, '2023-01-01', '2023-01-31', 3500.00, 3150.00, '2023-02-01'),
(5, '2023-01-01', '2023-01-31', 4000.00, 3600.00, '2023-02-01'),
(6, '2023-01-01', '2023-01-31', 3200.00, 2880.00, '2023-02-01'),
(7, '2023-01-01', '2023-01-31', 3800.00, 3420.00, '2023-02-01'),
(8, '2023-01-01', '2023-01-31', 3600.00, 3240.00, '2023-02-01'),
(9, '2023-01-01', '2023-01-31', 3000.00, 2700.00, '2023-02-01'),
(10, '2023-01-01', '2023-01-31', 4500.00, 4050.00, '2023-02-01');

-- Insert data into Salary_components
INSERT INTO Salary_components (payroll_id, comp_type, amount) VALUES
(1, 'Base Salary', 4000.00),
(1, 'Bonus', 1000.00),
(2, 'Base Salary', 3500.00),
(2, 'Overtime', 500.00),
(3, 'Base Salary', 3000.00),
(4, 'Base Salary', 3000.00),
(4, 'Commission', 500.00),
(5, 'Base Salary', 4000.00),
(6, 'Base Salary', 3200.00),
(7, 'Base Salary', 3800.00);


-- Insert data into Returns
INSERT INTO Returns (return_no, order_id, created_by, created_at, status) VALUES
('RET001', 1, 4, '2023-01-06', 'RECEIVED'),
('RET002', 2, 4, '2023-02-06', 'OPEN'),
('RET003', 3, 4, '2023-03-06', 'INSPECTED'),
('RET004', 4, 4, '2023-04-06', 'RESOLVED'),
('RET005', 5, 4, '2023-05-06', 'OPEN'),
('RET006', 6, 4, '2023-06-06', 'RECEIVED'),
('RET007', 7, 4, '2023-07-06', 'INSPECTED'),
('RET008', 8, 4, '2023-08-06', 'RESOLVED'),
('RET009', 9, 4, '2023-09-06', 'OPEN'),
('RET010', 10, 4, '2023-10-06', 'RECEIVED');

-- Insert data into Return_lines
INSERT INTO Return_lines (return_id, unit_id, reason) VALUES
(1, 1, 'Defective unit'),
(2, 2, 'Wrong item'),
(3, 3, 'Damaged in transit'),
(4, 4, 'Customer changed mind'),
(5, 5, 'Not as described'),
(6, 6, 'Defective unit'),
(7, 7, 'Wrong color'),
(8, 8, 'Customer return'),
(9, 9, 'Faulty product'),
(10, 10, 'Damaged item');

-- Insert data into Quality_Inspections
INSERT INTO Quality_Inspections (inspection_no, unit_id, location_id, inspected_by, inspected_at, status, result, note) VALUES
('INS001', 1, 1, 6, '2023-01-07', 'PASSED', 'No defects', NULL),
('INS002', 2, 2, 6, '2023-02-07', 'FAILED', 'Screen issue', 'Needs repair'),
('INS003', 3, 3, 6, '2023-03-07', 'PENDING', NULL, NULL),
('INS004', 4, 4, 6, '2023-04-07', 'PASSED', 'All good', NULL),
('INS005', 5, 5, 6, '2023-05-07', 'QUARANTINE', 'Battery issue', 'Under review'),
('INS006', 6, 6, 6, '2023-06-07', 'PASSED', 'No defects', NULL),
('INS007', 7, 7, 6, '2023-07-07', 'FAILED', 'Camera issue', 'Needs repair'),
('INS008', 8, 8, 6, '2023-08-07', 'PASSED', 'All good', NULL),
('INS009', 9, 9, 6, '2023-09-07', 'PENDING', NULL, NULL),
('INS010', 10, 10, 6, '2023-10-07', 'PASSED', 'No defects', NULL);