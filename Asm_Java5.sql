create database Asm_Java5;
use Asm_Java5;
drop database Asm_Java5;


-- Bảng Products
CREATE TABLE Products (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(255) NOT NULL,
    Image NVARCHAR(255),
    Price DECIMAL(18,2) CHECK (Price >= 0),
    create_date DATETIME DEFAULT GETDATE(),
    Quantity INT CHECK (Quantity >= 0),
    category_id INT NOT NULL,
    is_delete BIT DEFAULT 0,
    CONSTRAINT FK_Products_Category FOREIGN KEY (category_id) REFERENCES Categories(Id)
);

-- thêm cột mô tả
ALTER TABLE Products
ADD Description NVARCHAR(500) NULL; -- Thêm cột mô tả, cho phép giá trị NULL

-- thêm 4 cột image1,2,3,4
ALTER TABLE Products
ADD 
	
    image1 NVARCHAR(255) NULL, -- Đường dẫn hình ảnh phụ 1
    image2 NVARCHAR(255) NULL, -- Đường dẫn hình ảnh phụ 2
    image3 NVARCHAR(255) NULL, -- Đường dẫn hình ảnh phụ 3
    image4 NVARCHAR(255) NULL; -- Đường dẫn hình ảnh phụ 4
-- xóa image
ALTER TABLE Products
DROP COLUMN Image;

select * from Products;


-- Bảng Order_Details
CREATE TABLE Order_Details (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    Price DECIMAL(18,2) CHECK (Price >= 0),
    Quantity INT CHECK (Quantity > 0),
    CONSTRAINT FK_OrderDetails_Orders FOREIGN KEY (order_id) REFERENCES Orders(Id),
    CONSTRAINT FK_OrderDetails_Products FOREIGN KEY (product_id) REFERENCES Products(Id)
);
 
-- Bảng Orders
CREATE TABLE Orders (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(255) NOT NULL,
    create_date DATETIME NOT NULL,
    Address NVARCHAR(255) NOT NULL,
    total DECIMAL(18,2) CHECK (total >= 0),
    status TINYINT NOT NULL CHECK (status IN (0, 1, 2)),
    CONSTRAINT FK_Orders_Accounts FOREIGN KEY (Username) REFERENCES Accounts(Username)
);

-- Bảng Categories
CREATE TABLE Categories (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    is_delete BIT NOT NULL DEFAULT 0
);

-- Bảng Accounts
CREATE TABLE Accounts (
    Username NVARCHAR(255) PRIMARY KEY,
    Password NVARCHAR(255) NOT NULL,
    Fullname NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    Photo NVARCHAR(255),
    Activated BIT NOT NULL DEFAULT 1,
    Admin BIT NOT NULL DEFAULT 0
);

-- Bảng Carts (Lưu tạm)
CREATE TABLE Carts (
    Username NVARCHAR(255) NOT NULL,
    Product_id INT NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    PRIMARY KEY (Username, Product_id),
    CONSTRAINT FK_Carts_Accounts FOREIGN KEY (Username) REFERENCES Accounts(Username),
    CONSTRAINT FK_Carts_Products FOREIGN KEY (Product_id) REFERENCES Products(Id)
);



		drop table Products;
		drop table Categories;

