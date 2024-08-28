
CREATE TABLE [dbo].[DimCustomers]
(
[CustomerSK] INT IDENTITY(1,1),
[CustomerID] [nchar] (5) NOT NULL,
[CompanyName] [nvarchar] (40) NOT NULL,
[ContactName] [nvarchar] (30) NULL,
[ContactTitle] [nvarchar] (30) NULL,
[Address] [nvarchar] (60) NULL,
[City] [nvarchar] (15) NULL,
[Region] [nvarchar] (15) NULL,
CONSTRAINT PK_DimCustomers_CustomerSK PRIMARY KEY(CustomerSK)
)

GO
CREATE TABLE [dbo].[DimEmployees]
(
[EmployeeSK] INT IDENTITY(1,1),
[EmployeeID] [int] NOT NULL,
[LastName] [nvarchar] (20)NOT NULL,
[FirstName] [nvarchar] (10) NOT NULL,
[Title] [nvarchar] (30) NULL,
[TitleOfCourtesy] [nvarchar] (25) NULL,
[BirthDate] [datetime] NULL,
[HireDate] [datetime] NULL,
[Address] [nvarchar] (60) NULL,
[City] [nvarchar] (15) NULL,
[Region] [nvarchar] (15) NULL,
CONSTRAINT PK_DimEmployees_EmployeeSK PRIMARY KEY(EmployeeSK)
)
GO
CREATE TABLE [dbo].[DimProducts]
(
[ProductSK] INT IDENTITY(1,1) NOT NULL,
[ProductID] [int] NOT NULL,
[ProductName] [nvarchar] (40) NOT NULL,
[SupplierID] [int] NULL,
SupplierName [nvarchar] (40) NULL,
[CategoryName] [nvarchar] (15) NULL,
[QuantityPerUnit] [nvarchar] (20) NULL,
[UnitPrice] [money] NULL CONSTRAINT [DF_Products_UnitPrice] DEFAULT ((0)),
[UnitsInStock] [smallint] NULL CONSTRAINT [DF_Products_UnitsInStock] DEFAULT ((0)),
[UnitsOnOrder] [smallint] NULL CONSTRAINT [DF_Products_UnitsOnOrder] DEFAULT ((0)),
[ReorderLevel] [smallint] NULL CONSTRAINT [DF_Products_ReorderLevel] DEFAULT ((0)),
[Discontinued] [bit] NOT NULL CONSTRAINT [DF_Products_Discontinued] DEFAULT ((0)),
CONSTRAINT PK_DimProducts_ProductSK PRIMARY KEY(ProductSK)
)
GO
CREATE TABLE [dbo].[DimDate]
(
 [DateKey] [int] NOT NULL,
 [FullDate] [date] NOT NULL,
 [DayNumberOfWeek] [tinyint] NOT NULL,
 [DayNameOfWeek] [nvarchar](10) NOT NULL,
 [DayNumberOfMonth] [tinyint] NOT NULL,
 [DayNumberOfYear] [smallint] NOT NULL,
 [WeekNumberOfYear] [tinyint] NOT NULL,
 [MonthName] [nvarchar](10) NOT NULL,
 [MonthNumberOfYear] [tinyint] NOT NULL,
 [CalendarQuarter] [tinyint] NOT NULL,
 [CalendarYear] [smallint] NOT NULL,
 [CalendarSemester] [tinyint] NOT NULL,
 CONSTRAINT [PK_DimDate] PRIMARY KEY(DateKey) 
)
GO 
CREATE TABLE [dbo].[FacOrders]
(
[OrderID] [int] NOT NULL,
[ProductSK] [int] NOT NULL,
[CustomerSK] [int] NULL,
[EmployeeSK] [int] NULL,
[OrderDateKey] [int] NULL,
[RequiredDateKey] [int] NULL,
[ShippedDateKey] [int] NULL,
[ShipVia] [int] NULL,
[Freight] [money] NULL CONSTRAINT [DF_Orders_Freight] DEFAULT ((0)),
[ShipName] [nvarchar] (40) NULL,
[ShipAddress] [nvarchar] (60) NULL,
[ShipCity] [nvarchar] (15) NULL,
[ShipPostalCode] [nvarchar] (10) NULL,
[ShipCountry] [nvarchar] (15) NULL,
[UnitPrice] [money] NOT NULL CONSTRAINT [DF_Orders_UnitPrice] DEFAULT ((0)),
[Quantity] [smallint] NOT NULL CONSTRAINT [DF_Orders_Quantity] DEFAULT ((1)),
[Discount] [real] NOT NULL CONSTRAINT [DF_Orders_Discount] DEFAULT ((0)),
CONSTRAINT PK_Orders_OrderID PRIMARY KEY(OrderID),
CONSTRAINT FK_Orders_ProductSK FOREIGN KEY(ProductSK) REFERENCES dbo.DimProducts(ProductSK),
CONSTRAINT FK_Orders_CustomerSK FOREIGN KEY(CustomerSK) REFERENCES dbo.DimCustomers(CustomerSK),
CONSTRAINT FK_Orders_EmployeeSK FOREIGN KEY(EmployeeSK) REFERENCES dbo.DimEmployees(EmployeeSK),
CONSTRAINT FK_Orders_OrderDateKey FOREIGN KEY(OrderDateKey) REFERENCES dbo.DimDate(DateKey),
CONSTRAINT FK_Orders_RequiredDateKey FOREIGN KEY(RequiredDateKey) REFERENCES dbo.DimDate(DateKey),
CONSTRAINT FK_Orders_ShippedDateKey FOREIGN KEY(ShippedDateKey) REFERENCES dbo.DimDate(DateKey)
)
GO 
CREATE TABLE [dbo].[PackageConfig](
	[PackageID] [int] IDENTITY(1,1) NOT NULL,
	[TableName] [varchar](50) NOT NULL,
	[LastRowVersion] [bigint] NULL,
	CONSTRAINT PK_PackageConfig_PackageID PRIMARY KEY(PackageID)
)

CREATE TABLE [staging].[Customers](
	[CustomerSK] [INT] NOT NULL,
	[CustomerID] [NCHAR](5) NOT NULL,
	[CompanyName] [NVARCHAR](40) NOT NULL,
	[ContactName] [NVARCHAR](30) NULL,
	[ContactTitle] [NVARCHAR](30) NULL,
	[Address] [NVARCHAR](60) NULL,
	[City] [NVARCHAR](15) NULL,
	[Region] [NVARCHAR](15) NULL
) ON [PRIMARY]
GO
CREATE TABLE [staging].[Employees](
	[EmployeeSK] [INT] NOT NULL,
	[EmployeeID] [INT] NOT NULL,
	[LastName] [NVARCHAR](20) NOT NULL,
	[FirstName] [NVARCHAR](10) NOT NULL,
	[Title] [NVARCHAR](30) NULL,
	[TitleOfCourtesy] [NVARCHAR](25) NULL,
	[BirthDate] [DATETIME] NULL,
	[HireDate] [DATETIME] NULL,
	[Address] [NVARCHAR](60) NULL,
	[City] [NVARCHAR](15) NULL,
	[Region] [NVARCHAR](15) NULL
) ON [PRIMARY]
GO
CREATE TABLE [staging].[Orders](
	[OrderID] [INT] NOT NULL,
	[ProductSK] [INT] NOT NULL,
	[CustomerSK] [INT] NULL,
	[EmployeeSK] [INT] NULL,
	[OrderDateKey] [INT] NULL,
	[RequiredDateKey] [INT] NULL,
	[ShippedDateKey] [INT] NULL,
	[ShipVia] [INT] NULL,
	[Freight] [MONEY] NULL,
	[ShipName] [NVARCHAR](40) NULL,
	[ShipAddress] [NVARCHAR](60) NULL,
	[ShipCity] [NVARCHAR](15) NULL,
	[ShipPostalCode] [NVARCHAR](10) NULL,
	[ShipCountry] [NVARCHAR](15) NULL,
	[UnitPrice] [MONEY] NOT NULL,
	[Quantity] [SMALLINT] NOT NULL,
	[Discount] [REAL] NOT NULL
) ON [PRIMARY]
GO
CREATE TABLE [staging].[Products](
	[ProductSK] [INT] NOT NULL,
	[ProductID] [INT] NOT NULL,
	[ProductName] [NVARCHAR](40) NOT NULL,
	[SupplierID] [INT] NULL,
	[SupplierName] [NVARCHAR](40) NULL,
	[CategoryName] [NVARCHAR](15) NULL,
	[QuantityPerUnit] [NVARCHAR](20) NULL,
	[UnitPrice] [MONEY] NULL,
	[UnitsInStock] [SMALLINT] NULL,
	[UnitsOnOrder] [SMALLINT] NULL,
	[ReorderLevel] [SMALLINT] NULL,
	[Discontinued] [BIT] NOT NULL
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [dbo].[DW_MergeDimCustomer]
AS
BEGIN

	UPDATE dc
	SET [CustomerID]   = sc.CustomerID
	   ,CompanyName    = sc.CompanyName
	   ,ContactName    = sc.ContactName
	   ,ContactTitle   = sc.ContactTitle
	   ,Address        = sc.Address
	   ,City           = sc.City
	   ,Region         = sc.Region
	FROM [dbo].[DimCustomers] dc
	INNER JOIN staging.Customers  sc ON (dc.[CustomerSK]=sc.[CustomerSK])
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [dbo].[DW_MergeDimEmployees]
AS
BEGIN

	UPDATE de
	SET EmployeeID       = sc.EmployeeID
	   ,LastName         = sc.LastName
	   ,FirstName        = sc.FirstName
	   ,Title            = sc.Title
	   ,TitleOfCourtesy  = sc.TitleOfCourtesy
	   ,BirthDate        = sc.BirthDate
	   ,HireDate         = sc.HireDate
	   ,Address          = sc.Address
	   ,City             = sc.City
	   ,Region           = sc.Region
	FROM [dbo].[DimEmployees] de
	INNER JOIN staging.Employees  sc ON (de.EmployeeSK= sc.EmployeeSK)
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [dbo].[DW_MergeDimProducts]
AS
BEGIN

	UPDATE dp
	SET ProductID		= sp.ProductID
	   ,ProductName		= sp.ProductName
	   ,SupplierID      = sp.SupplierID
	   ,SupplierName    = sp.SupplierName
	   ,CategoryName    = sp.CategoryName
	   ,QuantityPerUnit = sp.QuantityPerUnit
	   ,UnitPrice       = sp.UnitPrice
	   ,UnitsInStock    = sp.UnitsInStock
	   ,UnitsOnOrder    = sp.UnitsOnOrder
	   ,ReorderLevel    = sp.ReorderLevel
	   ,Discontinued    = sp.Discontinued
	FROM [dbo].DimProducts dp
	INNER JOIN staging.Products  sp ON (dp.ProductSK=sp.ProductSK)
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [dbo].[DW_MergeFacOrders]
AS
BEGIN

	UPDATE fo
	SET OrderID			= so.OrderID
	   ,ProductSK		= so.ProductSK
	   ,CustomerSK      = so.CustomerSK
	   ,EmployeeSK      = so.EmployeeSK
	   ,OrderDateKey    = so.OrderDateKey
	   ,RequiredDateKey = so.RequiredDateKey
	   ,ShippedDateKey  = so.ShippedDateKey
	   ,ShipVia         = so.ShipVia
	   ,Freight         = so.Freight
	   ,ShipName        = so.ShipName
	   ,ShipAddress     = so.ShipAddress
	   ,ShipCity        = so.ShipCity
	   ,ShipPostalCode  = so.ShipPostalCode
	   ,ShipCountry     = so.ShipCountry
	   ,UnitPrice       = so.UnitPrice
	   ,Quantity        = so.Quantity
	   ,Discount        = so.Discount
	FROM [dbo].FacOrders fo
	INNER JOIN staging.Orders  so ON (fo.OrderID=so.OrderID)
END
GO

