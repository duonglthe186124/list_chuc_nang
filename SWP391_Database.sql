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
	is_actived BIT DEFAULT 0,
	is_deleted BIT DEFAULT 0
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

CREATE TABLE Product_units
(
	unit_id INT IDENTITY(1,1) PRIMARY KEY,
	imei NVARCHAR(50) UNIQUE,
	serial_number NVARCHAR(100) NULL,
	warranty_start_date DATETIME2(0) DEFAULT SYSUTCDATETIME(),
	warranty_end_date DATETIME2(0) DEFAULT SYSUTCDATETIME(),
	product_id INT NOT NULL REFERENCES Products(product_id),
	purchase_price DECIMAL(18,2) DEFAULT NULL,
	received_date DATETIME2(0) DEFAULT NULL,
	current_location_id INT NOT NULL REFERENCES Warehouse_locations(location_id),
	status NVARCHAR(50) NOT NULL DEFAULT 'AVAILABLE',
	last_tx_id INT DEFAULT NULL,
	created_by INT DEFAULT NULL,
	created_at DATETIME2(0) DEFAULT SYSUTCDATETIME(),
	updated_at DATETIME2(0) DEFAULT SYSUTCDATETIME(),
	CONSTRAINT CHK_Product_units_status CHECK (status IN ('AVAILABLE','RESERVED','SOLD','DAMAGED','RETURNED'))
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
	CONSTRAINT CHK_Purchase_orders_status CHECK (status IN ('PENDING','ACTIVE','COMPLETED','CANCELLED'))
)

CREATE TABLE Purchase_order_lines
(
	po_line_id INT IDENTITY(1,1) PRIMARY KEY,
	po_id INT NOT NULL REFERENCES Purchase_orders(po_id),
	product_id INT NOT NULL REFERENCES Products(product_id),
	unit_price DECIMAL(18,2) NOT NULL,
	qty INT NOT NULL,
	line_amount DECIMAL(18,2) NOT NULL
)

CREATE TABLE Stock_receipts
(
	receipts_id INT IDENTITY(1,1) PRIMARY KEY,
	receipts_no NVARCHAR(50) NOT NULL UNIQUE,
	supplier_id INT NOT NULL REFERENCES Suppliers(supplier_id),
	created_by INT NOT NULL REFERENCES Employees(employee_id),
	requested_at DATETIME2(0) DEFAULT SYSUTCDATETIME(),
	status NVARCHAR(50) NOT NULL DEFAULT 'PENDING',
	approved_by INT DEFAULT NULL,
	approved_at DATETIME2(0) DEFAULT NULL,
	note NVARCHAR(MAX) NULL,
	created_at DATETIME2(0) DEFAULT SYSUTCDATETIME(),
	CONSTRAINT CHK_Stock_receipts_status CHECK (status IN ('PENDING','RECEIVED','PARTIAL','CANCELLED'))
)

CREATE TABLE Stock_receipt_lines
(
	line_id INT IDENTITY(1,1) PRIMARY KEY,
	receipt_id INT NOT NULL REFERENCES Stock_receipts(receipts_id),
	product_id INT NOT NULL REFERENCES Products(product_id),
	qty_expected INT NOT NULL,
	qty_received INT DEFAULT 0,
	unit_price DECIMAL(18,2) DEFAULT NULL,
	note NVARCHAR(255) DEFAULT NULL
)

CREATE TABLE Stock_receipt_units
(
	id INT IDENTITY(1,1) PRIMARY KEY,
	line_id INT NOT NULL REFERENCES Stock_receipt_lines(line_id),
	unit_id INT NOT NULL REFERENCES Product_units(unit_id) UNIQUE
)

CREATE TABLE Stock_shipments
(
	shipment_id INT IDENTITY(1,1) PRIMARY KEY,
	shipment_no NVARCHAR(50) NOT NULL UNIQUE,
	customer NVARCHAR(200) NULL,
	created_by INT NOT NULL REFERENCES Employees(employee_id),
	requested_at DATETIME2(0) DEFAULT SYSUTCDATETIME(),
	status NVARCHAR(50) NOT NULL DEFAULT 'PENDING',
	approved_by INT DEFAULT NULL,
	approved_at DATETIME2(0) DEFAULT NULL,
	note NVARCHAR(1000) NULL,
	CONSTRAINT CHK_Stock_shipments_status CHECK (status IN ('PENDING','PICKED','SHIPPED','CANCELLED'))
)

CREATE TABLE Stock_shipment_lines
(
	line_id INT IDENTITY(1,1) PRIMARY KEY,
	shipment_id INT NOT NULL REFERENCES Stock_shipments(shipment_id),
	product_id INT NOT NULL REFERENCES Products(product_id),
	qty INT NOT NULL
)

CREATE TABLE Stock_shipment_units
(
	id INT IDENTITY(1,1) PRIMARY KEY,
	line_id INT NOT NULL REFERENCES Stock_shipment_lines(line_id),
	unit_id INT NOT NULL REFERENCES Product_units(unit_id)
)

CREATE TABLE Stock_moves
(
	move_id INT IDENTITY(1,1) PRIMARY KEY,
	move_no NVARCHAR(50) UNIQUE,
	unit_id INT DEFAULT NULL,
	product_id INT DEFAULT NULL,
	qty INT DEFAULT NULL,
	from_location_id INT NULL REFERENCES Warehouse_locations(location_id),
	to_location_id INT NULL REFERENCES Warehouse_locations(location_id),
	status NVARCHAR(50) NOT NULL DEFAULT 'PENDING',
	created_by INT NULL,
	approved_by INT NULL,
	created_at DATETIME2(0) DEFAULT SYSUTCDATETIME(),
	approved_at DATETIME2(0) DEFAULT NULL,
	note NVARCHAR(255) NULL,
	FOREIGN KEY (unit_id) REFERENCES Product_units(unit_id),
	FOREIGN KEY (product_id) REFERENCES Products(product_id),
	CONSTRAINT CHK_Stock_moves_status CHECK (status IN ('PENDING','APPROVED','COMPLETED','CANCELLED'))
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
	created_by INT NULL,
	created_at DATETIME2(0) DEFAULT SYSUTCDATETIME()
)

CREATE TABLE Stock_audit_logs
(
	audit_id BIGINT IDENTITY(1,1) PRIMARY KEY,
	event_time DATETIME2(0) DEFAULT SYSUTCDATETIME(),
	user_id INT NULL,
	event_type NVARCHAR(50) NULL,
	reference_table NVARCHAR(50) NULL,
	reference_id BIGINT NULL,
	unit_cost DECIMAL(18,2) NULL, 
	monetary_value DECIMAL(18,2) NULL,
	detail NVARCHAR(1000) NULL,
	note NVARCHAR(MAX) NULL
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

CREATE TABLE Orders
(
	order_id INT IDENTITY(1,1) PRIMARY KEY,
	user_id INT NULL REFERENCES Users(user_id),
	total_amount DECIMAL(18,2) NOT NULL,
	status NVARCHAR(50) NOT NULL DEFAULT 'PENDING',
	order_date DATETIME2(0) NOT NULL DEFAULT SYSUTCDATETIME(),
	receive_date DATETIME2(0) NULL,
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

CREATE TABLE Containers (
    container_id INT IDENTITY(1,1) PRIMARY KEY,
	container_code NVARCHAR(100) NOT NULL UNIQUE,
	description NVARCHAR(500) NULL,
	status NVARCHAR(50) NOT NULL DEFAULT 'SEALED',
	location_id INT NOT NULL REFERENCES Warehouse_locations(location_id), 
	created_at DATETIME2(0) NOT NULL DEFAULT SYSUTCDATETIME()
);

CREATE TABLE Container_units (
    container_id INT REFERENCES Containers(container_id),
    unit_id INT REFERENCES Product_units(unit_id),
    PRIMARY KEY(container_id, unit_id)
);

CREATE TABLE Returns (
    return_id INT IDENTITY(1,1) PRIMARY KEY,
    return_no NVARCHAR(100) NOT NULL UNIQUE,
    order_id INT NOT NULL REFERENCES Orders(order_id),
    customer_name NVARCHAR(255) NULL,
    created_by INT NOT NULL REFERENCES Users(user_id),       
    created_at DATETIME2(0) NOT NULL DEFAULT SYSUTCDATETIME(),
    status NVARCHAR(50) NOT NULL DEFAULT 'OPEN',
	CONSTRAINT CHK_Returns_status CHECK (status IN ('OPEN','RECEIVED','INSPECTED','RESOLVED'))
);

  CREATE TABLE Return_lines (
    return_line_id INT IDENTITY(1,1) PRIMARY KEY,
    return_id INT NOT NULL REFERENCES Returns(return_id),
    unit_id INT NOT NULL REFERENCES Product_units(unit_id),            
    qty INT NULL DEFAULT 1,
    reason NVARCHAR(1000) NULL,
    created_at DATETIME2(0) NOT NULL DEFAULT SYSUTCDATETIME()
);

-- 1. Insert into Roles (10 records)
INSERT INTO Roles (role_name, description) VALUES
(N'Admin', N'Quản trị viên hệ thống với quyền truy cập đầy đủ'),
(N'Warehouse Manager', N'Quản lý kho, giám sát hàng tồn kho và vận hành'),
(N'Inventory Staff', N'Nhân viên kiểm kê hàng hóa'),
(N'Sales', N'Nhân viên bán hàng, xử lý đơn hàng'),
(N'Purchasing', N'Nhân viên thu mua, tạo đơn hàng mua'),
(N'Supervisor', N'Giám sát hoạt động kho'),
(N'Accountant', N'Nhân viên kế toán, xử lý thanh toán'),
(N'Customer Support', N'Hỗ trợ khách hàng, xử lý trả hàng'),
(N'Technician', N'Nhân viên kỹ thuật, bảo trì thiết bị kho'),
(N'Security', N'Nhân viên bảo vệ kho');

-- 2. Insert into Features (12 records)
INSERT INTO Features (feature_name, description) VALUES
(N'View Inventory', N'Xem thông tin hàng tồn kho'),
(N'Manage Inventory', N'Quản lý nhập/xuất hàng tồn kho'),
(N'Create PO', N'Tạo đơn hàng mua'),
(N'Approve PO', N'Phê duyệt đơn hàng mua'),
(N'Manage Users', N'Quản lý tài khoản người dùng'),
(N'View Reports', N'Xem báo cáo kho và tài chính'),
(N'Manage Products', N'Quản lý thông tin sản phẩm'),
(N'Process Returns', N'Xử lý yêu cầu trả hàng'),
(N'Manage Employees', N'Quản lý thông tin nhân viên'),
(N'View Audit Logs', N'Xem nhật ký kiểm tra'),
(N'Manage Shifts', N'Quản lý ca làm việc'),
(N'View Payroll', N'Xem thông tin lương');

-- 3. Insert into Feature_role (12 records)
INSERT INTO Feature_role (role_id, feature_id) VALUES
(1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 6), -- Admin có quyền truy cập nhiều tính năng
(2, 1), (2, 2), (2, 6), -- Warehouse Manager
(3, 1), (3, 2), -- Inventory Staff
(4, 1), (4, 8); -- Sales

-- 4. Insert into Users (15 records)
INSERT INTO Users (email, password, fullname, phone, address, sec_address, role_id, is_actived, is_deleted) VALUES
(N'admin@warehouse.com', N'hashed_password_1', N'Nguyen Van Admin', N'0123456789', N'123 Hanoi St', NULL, 1, 1, 0),
(N'manager1@warehouse.com', N'hashed_password_2', N'Tran Thi Manager', N'0987654321', N'456 Saigon St', NULL, 2, 1, 0),
(N'inventory1@warehouse.com', N'hashed_password_3', N'Le Van Inventory', N'0912345678', N'789 Danang St', NULL, 3, 1, 0),
(N'sales1@warehouse.com', N'hashed_password_4', N'Pham Thi Sales', N'0934567890', N'101 Cantho St', NULL, 4, 1, 0),
(N'purchasing1@warehouse.com', N'hashed_password_5', N'Hoang Van Purchasing', N'0945678901', N'202 Hue St', NULL, 5, 1, 0),
(N'supervisor1@warehouse.com', N'hashed_password_6', N'Vo Thi Supervisor', N'0956789012', N'303 Hanoi St', NULL, 6, 1, 0),
(N'accountant1@warehouse.com', N'hashed_password_7', N'Nguyen Thi Accountant', N'0967890123', N'404 Saigon St', NULL, 7, 1, 0),
(N'customer1@warehouse.com', N'hashed_password_8', N'Tran Van Customer', N'0978901234', N'505 Danang St', NULL, 8, 1, 0),
(N'technician1@warehouse.com', N'hashed_password_9', N'Le Thi Technician', N'0989012345', N'606 Cantho St', NULL, 9, 1, 0),
(N'security1@warehouse.com', N'hashed_password_10', N'Pham Van Security', N'0990123456', N'707 Hue St', NULL, 10, 1, 0),
(N'user11@warehouse.com', N'hashed_password_11', N'Nguyen Van A', N'0911112222', N'808 Hanoi St', NULL, 3, 1, 0),
(N'user12@warehouse.com', N'hashed_password_12', N'Tran Thi B', N'0922223333', N'909 Saigon St', NULL, 4, 1, 0),
(N'user13@warehouse.com', N'hashed_password_13', N'Le Van C', N'0933334444', N'1010 Danang St', NULL, 5, 1, 0),
(N'user14@warehouse.com', N'hashed_password_14', N'Pham Thi D', N'0944445555', N'1111 Cantho St', NULL, 6, 1, 0),
(N'user15@warehouse.com', N'hashed_password_15', N'Hoang Van E', N'0955556666', N'1212 Hue St', NULL, 7, 1, 0);

-- 5. Insert into Positions (10 records)
INSERT INTO Positions (position_name, description) VALUES
(N'Warehouse Manager', N'Quản lý toàn bộ hoạt động kho'),
(N'Inventory Clerk', N'Kiểm kê và quản lý hàng tồn'),
(N'Sales Representative', N'Xử lý đơn hàng bán'),
(N'Purchasing Officer', N'Quản lý mua hàng'),
(N'Supervisor', N'Giám sát nhân viên kho'),
(N'Accountant', N'Xử lý tài chính và lương'),
(N'Customer Support', N'Hỗ trợ khách hàng'),
(N'Technician', N'Bảo trì thiết bị kho'),
(N'Security Guard', N'Bảo vệ kho'),
(N'Admin', N'Quản trị hệ thống');

-- 6. Insert into Employees (10 records)
INSERT INTO Employees (user_id, employee_code, hire_date, position_id, bank_account, boss_id) VALUES
(1, N'EMP001', '2023-01-01', 10, N'1234567890', NULL),
(2, N'EMP002', '2023-02-01', 1, N'2345678901', 1),
(3, N'EMP003', '2023-03-01', 2, N'3456789012', 2),
(4, N'EMP004', '2023-04-01', 3, N'4567890123', 2),
(5, N'EMP005', '2023-05-01', 4, N'5678901234', 2),
(6, N'EMP006', '2023-06-01', 5, N'6789012345', 2),
(7, N'EMP007', '2023-07-01', 6, N'7890123456', 1),
(8, N'EMP008', '2023-08-01', 7, N'8901234567', 2),
(9, N'EMP009', '2023-09-01', 8, N'9012345678', 2),
(10, N'EMP010', '2023-10-01', 9, N'0123456789', 2);

-- 7. Insert into Brands (10 records)
INSERT INTO Brands (brand_name) VALUES
(N'Apple'), (N'Samsung'), (N'Xiaomi'), (N'Oppo'), (N'Vivo'),
(N'Sony'), (N'LG'), (N'Nokia'), (N'Huawei'), (N'Realme');

-- 8. Insert into Product_specs (10 records)
INSERT INTO Product_specs (cpu, memory, storage, battery_capacity, color, screen_size, screen_type, camera) VALUES
(N'A15 Bionic', N'6GB', N'128GB', 3240, N'Black', 6.1, N'OLED', 12),
(N'Snapdragon 888', N'8GB', N'256GB', 5000, N'Blue', 6.7, N'AMOLED', 48),
(N'Exynos 2100', N'12GB', N'512GB', 4500, N'White', 6.2, N'AMOLED', 64),
(N'MediaTek Dimensity 1200', N'8GB', N'128GB', 4000, N'Red', 6.4, N'LCD', 48),
(N'A14 Bionic', N'4GB', N'64GB', 2815, N'Green', 5.4, N'OLED', 12),
(N'Snapdragon 865', N'6GB', N'128GB', 4300, N'Black', 6.5, N'AMOLED', 32),
(N'Kirin 9000', N'8GB', N'256GB', 4400, N'Silver', 6.6, N'OLED', 50),
(N'MediaTek Helio G95', N'6GB', N'128GB', 5000, N'Gold', 6.4, N'LCD', 64),
(N'Snapdragon 720G', N'4GB', N'64GB', 5020, N'Blue', 6.5, N'AMOLED', 48),
(N'A13 Bionic', N'4GB', N'128GB', 3110, N'Red', 6.1, N'LCD', 12);

-- 9. Insert into Products (10 records)
INSERT INTO Products (sku_code, name, brand_id, spec_id, description) VALUES
(N'SKU001', N'iPhone 13', 1, 1, N'iPhone 13 with A15 Bionic chip'),
(N'SKU002', N'Galaxy S21', 2, 2, N'Samsung Galaxy S21 with Snapdragon 888'),
(N'SKU003', N'Mi 11', 3, 3, N'Xiaomi Mi 11 with high performance'),
(N'SKU004', N'Reno 6', 4, 4, N'Oppo Reno 6 with sleek design'),
(N'SKU005', N'V21', 5, 5, N'Vivo V21 with great camera'),
(N'SKU006', N'Xperia 5', 6, 6, N'Sony Xperia 5 with compact design'),
(N'SKU007', N'G8 ThinQ', 7, 7, N'LG G8 ThinQ with OLED display'),
(N'SKU008', N'8.3 5G', 8, 8, N'Nokia 8.3 5G with great connectivity'),
(N'SKU009', N'P40 Pro', 9, 9, N'Huawei P40 Pro with powerful camera'),
(N'SKU010', N'GT Neo', 10, 10, N'Realme GT Neo with fast charging');

-- 10. Insert into Warehouse_locations (10 records)
INSERT INTO Warehouse_locations (code, area, aisle, slot, capacity, description) VALUES
(N'LOC001', N'A1', N'Aisle1', N'Slot1', 100, N'Main storage for electronics'),
(N'LOC002', N'A1', N'Aisle2', N'Slot1', 50, N'Secondary storage'),
(N'LOC003', N'B1', N'Aisle1', N'Slot2', 200, N'High capacity storage'),
(N'LOC004', N'B1', N'Aisle2', N'Slot2', 150, N'Medium capacity storage'),
(N'LOC005', N'C1', N'Aisle1', N'Slot3', 80, N'Small item storage'),
(N'LOC006', N'C1', N'Aisle2', N'Slot3', 120, N'Mixed item storage'),
(N'LOC007', N'D1', N'Aisle1', N'Slot4', 90, N'Spare parts storage'),
(N'LOC008', N'D1', N'Aisle2', N'Slot4', 60, N'Fragile item storage'),
(N'LOC009', N'E1', N'Aisle1', N'Slot5', 110, N'Bulk item storage'),
(N'LOC010', N'E1', N'Aisle2', N'Slot5', 70, N'Backup storage');

-- 11. Insert into Product_units (15 records)
INSERT INTO Product_units (imei, serial_number, product_id, purchase_price, received_date, current_location_id, status, created_by) VALUES
(N'IMEI001', N'SN001', 1, 699.99, '2023-11-01', 1, N'AVAILABLE', 1),
(N'IMEI002', N'SN002', 1, 699.99, '2023-11-01', 1, N'AVAILABLE', 1),
(N'IMEI003', N'SN003', 2, 799.99, '2023-11-02', 2, N'AVAILABLE', 1),
(N'IMEI004', N'SN004', 2, 799.99, '2023-11-02', 2, N'RESERVED', 1),
(N'IMEI005', N'SN005', 3, 599.99, '2023-11-03', 3, N'AVAILABLE', 1),
(N'IMEI006', N'SN006', 3, 599.99, '2023-11-03', 3, N'SOLD', 1),
(N'IMEI007', N'SN007', 4, 499.99, '2023-11-04', 4, N'AVAILABLE', 1),
(N'IMEI008', N'SN008', 4, 499.99, '2023-11-04', 4, N'AVAILABLE', 1),
(N'IMEI009', N'SN009', 5, 399.99, '2023-11-05', 5, N'AVAILABLE', 1),
(N'IMEI010', N'SN010', 5, 399.99, '2023-11-05', 5, N'AVAILABLE', 1),
(N'IMEI011', N'SN011', 6, 899.99, '2023-11-06', 6, N'AVAILABLE', 1),
(N'IMEI012', N'SN012', 6, 899.99, '2023-11-06', 6, N'RESERVED', 1),
(N'IMEI013', N'SN013', 7, 699.99, '2023-11-07', 7, N'AVAILABLE', 1),
(N'IMEI014', N'SN014', 8, 499.99, '2023-11-08', 8, N'AVAILABLE', 1),
(N'IMEI015', N'SN015', 9, 999.99, '2023-11-09', 9, N'AVAILABLE', 1);

-- 12. Insert into Suppliers (10 records)
INSERT INTO Suppliers (supplier_name, display_name, address, phone, email, representative, payment_method, note) VALUES
(N'Supplier A', N'Apple Distributor', N'123 Tech St, Hanoi', N'0111222333', N'supplierA@tech.com', N'John Doe', N'Bank Transfer', NULL),
(N'Supplier B', N'Samsung Distributor', N'456 Tech St, Saigon', N'0222333444', N'supplierB@tech.com', N'Jane Smith', N'Bank Transfer', NULL),
(N'Supplier C', N'Xiaomi Distributor', N'789 Tech St, Danang', N'0333444555', N'supplierC@tech.com', N'Mike Johnson', N'Cash', NULL),
(N'Supplier D', N'Oppo Distributor', N'101 Tech St, Cantho', N'0444555666', N'supplierD@tech.com', N'Anna Brown', N'Bank Transfer', NULL),
(N'Supplier E', N'Vivo Distributor', N'202 Tech St, Hue', N'0555666777', N'supplierE@tech.com', N'Peter Lee', N'Cash', NULL),
(N'Supplier F', N'Sony Distributor', N'303 Tech St, Hanoi', N'0666777888', N'supplierF@tech.com', N'Lisa Wong', N'Bank Transfer', NULL),
(N'Supplier G', N'LG Distributor', N'404 Tech St, Saigon', N'0777888999', N'supplierG@tech.com', N'Tom Clark', N'Cash', NULL),
(N'Supplier H', N'Nokia Distributor', N'505 Tech St, Danang', N'0888999000', N'supplierH@tech.com', N'Emma Davis', N'Bank Transfer', NULL),
(N'Supplier I', N'Huawei Distributor', N'606 Tech St, Cantho', N'0999000111', N'supplierI@tech.com', N'David Wilson', N'Cash', NULL),
(N'Supplier J', N'Realme Distributor', N'707 Tech St, Hue', N'0100111222', N'supplierJ@tech.com', N'Sarah Taylor', N'Bank Transfer', NULL);

-- 13. Insert into Purchase_orders (10 records)
INSERT INTO Purchase_orders (po_code, supplier_id, created_by, created_at, status, total_amount) VALUES
(N'PO001', 1, 1, '2023-11-01', N'PENDING', 1399.98),
(N'PO002', 2, 2, '2023-11-02', N'ACTIVE', 1599.98),
(N'PO003', 3, 3, '2023-11-03', N'COMPLETED', 1199.98),
(N'PO004', 4, 4, '2023-11-04', N'PENDING', 999.98),
(N'PO005', 5, 5, '2023-11-05', N'ACTIVE', 799.98),
(N'PO006', 6, 6, '2023-11-06', N'COMPLETED', 1799.98),
(N'PO007', 7, 7, '2023-11-07', N'PENDING', 1399.98),
(N'PO008', 8, 8, '2023-11-08', N'ACTIVE', 999.98),
(N'PO009', 9, 9, '2023-11-09', N'COMPLETED', 1999.98),
(N'PO010', 10, 10, '2023-11-10', N'PENDING', 799.98);

-- 14. Insert into Purchase_order_lines (10 records)
INSERT INTO Purchase_order_lines (po_id, product_id, unit_price, qty, line_amount) VALUES
(1, 1, 699.99, 2, 1399.98),
(2, 2, 799.99, 2, 1599.98),
(3, 3, 599.99, 2, 1199.98),
(4, 4, 499.99, 2, 999.98),
(5, 5, 399.99, 2, 799.98),
(6, 6, 899.99, 2, 1799.98),
(7, 7, 699.99, 2, 1399.98),
(8, 8, 499.99, 2, 999.98),
(9, 9, 999.99, 2, 1999.98),
(10, 10, 399.99, 2, 799.98);

-- 15. Insert into Stock_receipts (10 records)
INSERT INTO Stock_receipts (receipts_no, supplier_id, created_by, requested_at, status, approved_by, approved_at, note) VALUES
(N'REC001', 1, 1, '2023-11-01', N'PENDING', NULL, NULL, N'Waiting for delivery'),
(N'REC002', 2, 2, '2023-11-02', N'RECEIVED', 1, '2023-11-03', N'Fully received'),
(N'REC003', 3, 3, '2023-11-03', N'PARTIAL', 1, '2023-11-04', N'Partially received'),
(N'REC004', 4, 4, '2023-11-04', N'PENDING', NULL, NULL, N'Pending approval'),
(N'REC005', 5, 5, '2023-11-05', N'RECEIVED', 1, '2023-11-06', N'Fully received'),
(N'REC006', 6, 6, '2023-11-06', N'PENDING', NULL, NULL, N'Waiting for delivery'),
(N'REC007', 7, 7, '2023-11-07', N'RECEIVED', 1, '2023-11-08', N'Fully received'),
(N'REC008', 8, 8, '2023-11-08', N'PARTIAL', 1, '2023-11-09', N'Partially received'),
(N'REC009', 9, 9, '2023-11-09', N'RECEIVED', 1, '2023-11-10', N'Fully received'),
(N'REC010', 10, 10, '2023-11-10', N'PENDING', NULL, NULL, N'Pending approval');

-- 16. Insert into Stock_receipt_lines (10 records)
INSERT INTO Stock_receipt_lines (receipt_id, product_id, qty_expected, qty_received, unit_price, note) VALUES
(1, 1, 2, 0, 699.99, N'Waiting for delivery'),
(2, 2, 2, 2, 799.99, N'Fully received'),
(3, 3, 2, 1, 599.99, N'Partially received'),
(4, 4, 2, 0, 499.99, N'Pending delivery'),
(5, 5, 2, 2, 399.99, N'Fully received'),
(6, 6, 2, 0, 899.99, N'Waiting for delivery'),
(7, 7, 2, 2, 699.99, N'Fully received'),
(8, 8, 2, 1, 499.99, N'Partially received'),
(9, 9, 2, 2, 999.99, N'Fully received'),
(10, 10, 2, 0, 399.99, N'Pending delivery');

-- 1. Insert into Product_images (10 records)
INSERT INTO Product_images (product_id, image_url, alt_text) VALUES
(1, N'https://example.com/images/iphone13_black.jpg', N'iPhone 13 Black'),
(1, N'https://example.com/images/iphone13_side.jpg', N'iPhone 13 Side View'),
(2, N'https://example.com/images/galaxys21_blue.jpg', N'Galaxy S21 Blue'),
(2, N'https://example.com/images/galaxys21_back.jpg', N'Galaxy S21 Back View'),
(3, N'https://example.com/images/mi11_white.jpg', N'Xiaomi Mi 11 White'),
(4, N'https://example.com/images/reno6_red.jpg', N'Oppo Reno 6 Red'),
(5, N'https://example.com/images/v21_green.jpg', N'Vivo V21 Green'),
(6, N'https://example.com/images/xperia5_black.jpg', N'Sony Xperia 5 Black'),
(7, N'https://example.com/images/g8thinq_silver.jpg', N'LG G8 ThinQ Silver'),
(8, N'https://example.com/images/nokia83_blue.jpg', N'Nokia 8.3 5G Blue');

-- 2. Insert into Stock_receipt_units (10 records)
INSERT INTO Stock_receipt_units (line_id, unit_id) VALUES
(1, 1),
(2, 3),
(3, 5),
(4, 7),
(5, 9),
(6, 11),
(7, 13),
(8, 14),
(9, 15),
(10, 10);

-- 3. Insert into Stock_shipments (10 records)
INSERT INTO Stock_shipments (shipment_no, customer, created_by, requested_at, status, approved_by, approved_at, note) VALUES
(N'SHP001', N'Customer A', 1, '2023-11-11', N'PENDING', NULL, NULL, N'Pending approval'),
(N'SHP002', N'Customer B', 2, '2023-11-12', N'PICKED', 1, '2023-11-13', N'Picked and ready to ship'),
(N'SHP003', N'Customer C', 3, '2023-11-13', N'SHIPPED', 1, '2023-11-14', N'Shipped to customer'),
(N'SHP004', N'Customer D', 4, '2023-11-14', N'PENDING', NULL, NULL, N'Waiting for stock'),
(N'SHP005', N'Customer E', 5, '2023-11-15', N'PICKED', 1, '2023-11-16', N'Picked and ready'),
(N'SHP006', N'Customer F', 6, '2023-11-16', N'SHIPPED', 1, '2023-11-17', N'Shipped to customer'),
(N'SHP007', N'Customer G', 7, '2023-11-17', N'PENDING', NULL, NULL, N'Pending approval'),
(N'SHP008', N'Customer H', 8, '2023-11-18', N'PICKED', 1, '2023-11-19', N'Picked and ready'),
(N'SHP009', N'Customer I', 9, '2023-11-19', N'SHIPPED', 1, '2023-11-20', N'Shipped to customer'),
(N'SHP010', N'Customer J', 10, '2023-11-20', N'PENDING', NULL, NULL, N'Pending approval');

-- 4. Insert into Stock_shipment_lines (10 records)
INSERT INTO Stock_shipment_lines (shipment_id, product_id, qty) VALUES
(1, 1, 2),
(2, 2, 1),
(3, 3, 1),
(4, 4, 2),
(5, 5, 2),
(6, 6, 1),
(7, 7, 2),
(8, 8, 1),
(9, 9, 2),
(10, 10, 1);

-- 5. Insert into Stock_shipment_units (10 records)
INSERT INTO Stock_shipment_units (line_id, unit_id) VALUES
(1, 1),
(2, 3),
(3, 5),
(4, 7),
(5, 9),
(6, 11),
(7, 13),
(8, 14),
(9, 15),
(10, 10);

-- 6. Insert into Stock_moves (10 records)
INSERT INTO Stock_moves (move_no, unit_id, product_id, qty, from_location_id, to_location_id, status, created_by, approved_by, created_at, approved_at, note) VALUES
(N'MOV001', 1, 1, 1, 1, 2, N'PENDING', 1, NULL, '2023-11-11', NULL, N'Move to secondary storage'),
(N'MOV002', 3, 2, 1, 2, 3, N'APPROVED', 2, 1, '2023-11-12', '2023-11-13', N'Moved to high capacity storage'),
(N'MOV003', 5, 3, 1, 3, 4, N'COMPLETED', 3, 1, '2023-11-13', '2023-11-14', N'Move completed'),
(N'MOV004', 7, 4, 1, 4, 5, N'PENDING', 4, NULL, '2023-11-14', NULL, N'Pending approval'),
(N'MOV005', 9, 5, 1, 5, 6, N'APPROVED', 5, 1, '2023-11-15', '2023-11-16', N'Moved to mixed storage'),
(N'MOV006', 11, 6, 1, 6, 7, N'COMPLETED', 6, 1, '2023-11-16', '2023-11-17', N'Move completed'),
(N'MOV007', 13, 7, 1, 7, 8, N'PENDING', 7, NULL, '2023-11-17', NULL, N'Pending approval'),
(N'MOV008', 14, 8, 1, 8, 9, N'APPROVED', 8, 1, '2023-11-18', '2023-11-19', N'Moved to bulk storage'),
(N'MOV009', 15, 9, 1, 9, 10, N'COMPLETED', 9, 1, '2023-11-19', '2023-11-20', N'Move completed'),
(N'MOV010', 10, 10, 1, 10, 1, N'PENDING', 10, NULL, '2023-11-20', NULL, N'Pending approval');

-- 7. Insert into Stock_adjustments (10 records)
INSERT INTO Stock_adjustments (adjustment_no, product_id, unit_id, qty_before, qty_after, delta, reason, created_by, created_at) VALUES
(N'ADJ001', 1, 1, 2, 1, -1, N'Damaged item', 1, '2023-11-11'),
(N'ADJ002', 2, 3, 1, 2, 1, N'Found extra item', 2, '2023-11-12'),
(N'ADJ003', 3, 5, 1, 0, -1, N'Lost item', 3, '2023-11-13'),
(N'ADJ004', 4, 7, 2, 1, -1, N'Damaged item', 4, '2023-11-14'),
(N'ADJ005', 5, 9, 2, 3, 1, N'Found extra item', 5, '2023-11-15'),
(N'ADJ006', 6, 11, 1, 0, -1, N'Lost item', 6, '2023-11-16'),
(N'ADJ007', 7, 13, 2, 1, -1, N'Damaged item', 7, '2023-11-17'),
(N'ADJ008', 8, 14, 1, 2, 1, N'Found extra item', 8, '2023-11-18'),
(N'ADJ009', 9, 15, 2, 1, -1, N'Lost item', 9, '2023-11-19'),
(N'ADJ010', 10, 10, 1, 2, 1, N'Found extra item', 10, '2023-11-20');

-- 8. Insert into Stock_audit_logs (10 records)
INSERT INTO Stock_audit_logs (event_time, user_id, event_type, reference_table, reference_id, unit_cost, monetary_value, detail, note) VALUES
('2023-11-11 10:00:00', 1, N'ADJUSTMENT', N'Stock_adjustments', 1, 699.99, -699.99, N'Damaged item detected', N'Adjusted stock'),
('2023-11-12 10:00:00', 2, N'ADJUSTMENT', N'Stock_adjustments', 2, 799.99, 799.99, N'Extra item found', N'Adjusted stock'),
('2023-11-13 10:00:00', 3, N'ADJUSTMENT', N'Stock_adjustments', 3, 599.99, -599.99, N'Lost item reported', N'Adjusted stock'),
('2023-11-14 10:00:00', 4, N'ADJUSTMENT', N'Stock_adjustments', 4, 499.99, -499.99, N'Damaged item detected', N'Adjusted stock'),
('2023-11-15 10:00:00', 5, N'ADJUSTMENT', N'Stock_adjustments', 5, 399.99, 399.99, N'Extra item found', N'Adjusted stock'),
('2023-11-16 10:00:00', 6, N'ADJUSTMENT', N'Stock_adjustments', 6, 899.99, -899.99, N'Lost item reported', N'Adjusted stock'),
('2023-11-17 10:00:00', 7, N'ADJUSTMENT', N'Stock_adjustments', 7, 699.99, -699.99, N'Damaged item detected', N'Adjusted stock'),
('2023-11-18 10:00:00', 8, N'ADJUSTMENT', N'Stock_adjustments', 8, 499.99, 499.99, N'Extra item found', N'Adjusted stock'),
('2023-11-19 10:00:00', 9, N'ADJUSTMENT', N'Stock_adjustments', 9, 999.99, -999.99, N'Lost item reported', N'Adjusted stock'),
('2023-11-20 10:00:00', 10, N'ADJUSTMENT', N'Stock_adjustments', 10, 399.99, 399.99, N'Extra item found', N'Adjusted stock');

-- 9. Insert into Shifts (10 records)
INSERT INTO Shifts (name, start_time, end_time, note) VALUES
(N'Morning Shift', '08:00:00', '16:00:00', N'Morning warehouse operations'),
(N'Afternoon Shift', '12:00:00', '20:00:00', N'Afternoon warehouse operations'),
(N'Night Shift', '20:00:00', '04:00:00', N'Night warehouse operations'),
(N'Early Morning Shift', '06:00:00', '14:00:00', N'Early morning operations'),
(N'Late Afternoon Shift', '14:00:00', '22:00:00', N'Late afternoon operations'),
(N'Overnight Shift', '22:00:00', '06:00:00', N'Overnight operations'),
(N'Weekend Morning', '08:00:00', '16:00:00', N'Weekend morning operations'),
(N'Weekend Afternoon', '12:00:00', '20:00:00', N'Weekend afternoon operations'),
(N'Weekend Night', '20:00:00', '04:00:00', N'Weekend night operations'),
(N'Special Shift', '10:00:00', '18:00:00', N'Special operations shift');

-- 10. Insert into Shift_assignments (10 records)
INSERT INTO Shift_assignments (shift_id, employee_id, assign_date, location_id, role_in_shift) VALUES
(1, 1, '2023-11-11', 1, N'Admin'),
(2, 2, '2023-11-12', 2, N'Warehouse Manager'),
(3, 3, '2023-11-13', 3, N'Inventory Clerk'),
(4, 4, '2023-11-14', 4, N'Sales Representative'),
(5, 5, '2023-11-15', 5, N'Purchasing Officer'),
(6, 6, '2023-11-16', 6, N'Supervisor'),
(7, 7, '2023-11-17', 7, N'Accountant'),
(8, 8, '2023-11-18', 8, N'Customer Support'),
(9, 9, '2023-11-19', 9, N'Technician'),
(10, 10, '2023-11-20', 10, N'Security Guard');

-- 11. Insert into Attendances (10 records)
INSERT INTO Attendances (assign_id, employee_id, check_in, check_out, hours_worked, note) VALUES
(1, 1, '2023-11-11 08:00:00', '2023-11-11 16:00:00', 8.0, N'Full shift'),
(2, 2, '2023-11-12 12:00:00', '2023-11-12 20:00:00', 8.0, N'Full shift'),
(3, 3, '2023-11-13 20:00:00', '2023-11-14 04:00:00', 8.0, N'Night shift'),
(4, 4, '2023-11-14 06:00:00', '2023-11-14 14:00:00', 8.0, N'Full shift'),
(5, 5, '2023-11-15 14:00:00', '2023-11-15 22:00:00', 8.0, N'Full shift'),
(6, 6, '2023-11-16 22:00:00', '2023-11-17 06:00:00', 8.0, N'Overnight shift'),
(7, 7, '2023-11-17 08:00:00', '2023-11-17 16:00:00', 8.0, N'Weekend shift'),
(8, 8, '2023-11-18 12:00:00', '2023-11-18 20:00:00', 8.0, N'Weekend shift'),
(9, 9, '2023-11-19 20:00:00', '2023-11-20 04:00:00', 8.0, N'Weekend night shift'),
(10, 10, '2023-11-20 10:00:00', '2023-11-20 18:00:00', 8.0, N'Special shift');

-- 12. Insert into Payrolls (10 records)
INSERT INTO Payrolls (employee_id, period_start, period_end, gross_amount, net_amount, created_at) VALUES
(1, '2023-11-01', '2023-11-30', 2000.00, 1800.00, '2023-12-01'),
(2, '2023-11-01', '2023-11-30', 1800.00, 1600.00, '2023-12-01'),
(3, '2023-11-01', '2023-11-30', 1500.00, 1350.00, '2023-12-01'),
(4, '2023-11-01', '2023-11-30', 1400.00, 1250.00, '2023-12-01'),
(5, '2023-11-01', '2023-11-30', 1600.00, 1450.00, '2023-12-01'),
(6, '2023-11-01', '2023-11-30', 1700.00, 1550.00, '2023-12-01'),
(7, '2023-11-01', '2023-11-30', 1600.00, 1450.00, '2023-12-01'),
(8, '2023-11-01', '2023-11-30', 1300.00, 1150.00, '2023-12-01'),
(9, '2023-11-01', '2023-11-30', 1400.00, 1250.00, '2023-12-01'),
(10, '2023-11-01', '2023-11-30', 1200.00, 1100.00, '2023-12-01');

-- 13. Insert into Salary_components (10 records)
INSERT INTO Salary_components (payroll_id, comp_type, amount) VALUES
(1, N'Base Salary', 1800.00),
(1, N'Bonus', 200.00),
(2, N'Base Salary', 1600.00),
(2, N'Overtime', 200.00),
(3, N'Base Salary', 1350.00),
(3, N'Bonus', 150.00),
(4, N'Base Salary', 1250.00),
(5, N'Base Salary', 1450.00),
(6, N'Base Salary', 1550.00),
(7, N'Base Salary', 1450.00);

-- 14. Insert into Orders (10 records)
INSERT INTO Orders (user_id, total_amount, status, order_date, receive_date) VALUES
(1, 1399.98, N'PENDING', '2023-11-11', NULL),
(2, 799.99, N'CONFIRMED', '2023-11-12', '2023-11-14'),
(3, 599.99, N'SHIPPED', '2023-11-13', '2023-11-15'),
(4, 999.98, N'PENDING', '2023-11-14', NULL),
(5, 799.98, N'CONFIRMED', '2023-11-15', '2023-11-17'),
(6, 1799.98, N'SHIPPED', '2023-11-16', '2023-11-18'),
(7, 1399.98, N'PENDING', '2023-11-17', NULL),
(8, 999.98, N'CONFIRMED', '2023-11-18', '2023-11-20'),
(9, 1999.98, N'SHIPPED', '2023-11-19', '2023-11-21'),
(10, 799.98, N'PENDING', '2023-11-20', NULL);

-- 15. Insert into Order_details (10 records)
INSERT INTO Order_details (order_id, unit_id, qty, unit_price, line_amount) VALUES
(1, 1, 2, 699.99, 1399.98),
(2, 3, 1, 799.99, 799.99),
(3, 5, 1, 599.99, 599.99),
(4, 7, 2, 499.99, 999.98),
(5, 9, 2, 399.99, 799.98),
(6, 11, 2, 899.99, 1799.98),
(7, 13, 2, 699.99, 1399.98),
(8, 14, 2, 499.99, 999.98),
(9, 15, 2, 999.99, 1999.98),
(10, 10, 2, 399.99, 799.98);

-- 16. Insert into Containers (10 records)
INSERT INTO Containers (container_code, description, status, location_id, created_at) VALUES
(N'CON001', N'Container for iPhone 13', N'SEALED', 1, '2023-11-11'),
(N'CON002', N'Container for Galaxy S21', N'SEALED', 2, '2023-11-12'),
(N'CON003', N'Container for Mi 11', N'SEALED', 3, '2023-11-13'),
(N'CON004', N'Container for Reno 6', N'SEALED', 4, '2023-11-14'),
(N'CON005', N'Container for V21', N'SEALED', 5, '2023-11-15'),
(N'CON006', N'Container for Xperia 5', N'SEALED', 6, '2023-11-16'),
(N'CON007', N'Container for G8 ThinQ', N'SEALED', 7, '2023-11-17'),
(N'CON008', N'Container for Nokia 8.3', N'SEALED', 8, '2023-11-18'),
(N'CON009', N'Container for P40 Pro', N'SEALED', 9, '2023-11-19'),
(N'CON010', N'Container for GT Neo', N'SEALED', 10, '2023-11-20');

-- 17. Insert into Container_units (10 records)
INSERT INTO Container_units (container_id, unit_id) VALUES
(1, 1),
(2, 3),
(3, 5),
(4, 7),
(5, 9),
(6, 11),
(7, 13),
(8, 14),
(9, 15),
(10, 10);

-- 18. Insert into Returns (10 records)
INSERT INTO Returns (return_no, order_id, customer_name, created_by, created_at, status) VALUES
(N'RET001', 1, N'Customer A', 1, '2023-11-11', N'OPEN'),
(N'RET002', 2, N'Customer B', 2, '2023-11-12', N'RECEIVED'),
(N'RET003', 3, N'Customer C', 3, '2023-11-13', N'INSPECTED'),
(N'RET004', 4, N'Customer D', 4, '2023-11-14', N'OPEN'),
(N'RET005', 5, N'Customer E', 5, '2023-11-15', N'RECEIVED'),
(N'RET006', 6, N'Customer F', 6, '2023-11-16', N'INSPECTED'),
(N'RET007', 7, N'Customer G', 7, '2023-11-17', N'OPEN'),
(N'RET008', 8, N'Customer H', 8, '2023-11-18', N'RECEIVED'),
(N'RET009', 9, N'Customer I', 9, '2023-11-19', N'INSPECTED'),
(N'RET010', 10, N'Customer J', 10, '2023-11-20', N'RESOLVED');

-- 19. Insert into Return_lines (10 records)
INSERT INTO Return_lines (return_id, unit_id, qty, reason, created_at) VALUES
(1, 1, 1, N'Defective product', '2023-11-11'),
(2, 3, 1, N'Wrong item shipped', '2023-11-12'),
(3, 5, 1, N'Customer changed mind', '2023-11-13'),
(4, 7, 1, N'Damaged during shipping', '2023-11-14'),
(5, 9, 1, N'Defective product', '2023-11-15'),
(6, 11, 1, N'Wrong item shipped', '2023-11-16'),
(7, 13, 1, N'Customer changed mind', '2023-11-17'),
(8, 14, 1, N'Damaged during shipping', '2023-11-18'),
(9, 15, 1, N'Defective product', '2023-11-19'),
(10, 10, 1, N'Wrong item shipped', '2023-11-20');