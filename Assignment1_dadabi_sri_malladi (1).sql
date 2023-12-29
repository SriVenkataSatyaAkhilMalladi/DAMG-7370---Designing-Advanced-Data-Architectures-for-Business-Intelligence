ALTER TABLE `default`.`SalesLT. CustomerCredentials` DROP FOREIGN KEY `fk_ CustomerCredentials_ CustomerCredentials_1`;
ALTER TABLE `default`.`SalesLT. SeasonalDiscounts` DROP FOREIGN KEY `fk_ SeasonalDiscounts_ SeasonalDiscounts_1`;
ALTER TABLE `default`.`SalesLT.CustomerAddress` DROP FOREIGN KEY `FK_CustomerAddress_Address_AddressID`;
ALTER TABLE `default`.`SalesLT.CustomerAddress` DROP FOREIGN KEY `FK_CustomerAddress_Customer_CustomerID`;
ALTER TABLE `default`.`SalesLT.Product` DROP FOREIGN KEY `FK_Product_ProductCategory_ProductCategoryID`;
ALTER TABLE `default`.`SalesLT.Product` DROP FOREIGN KEY `FK_Product_ProductModel_ProductModelID`;
ALTER TABLE `default`.`SalesLT.ProductCategory` DROP FOREIGN KEY `FK_ProductCategory_ProductCategory_ParentProductCategoryID_ProductCategoryID`;
ALTER TABLE `default`.`SalesLT.ProductModelProductDescription` DROP FOREIGN KEY `FK_ProductModelProductDescription_ProductDescription_ProductDescriptionID`;
ALTER TABLE `default`.`SalesLT.ProductModelProductDescription` DROP FOREIGN KEY `FK_ProductModelProductDescription_ProductModel_ProductModelID`;
ALTER TABLE `default`.`SalesLT.SalesOrderDetail` DROP FOREIGN KEY `FK_SalesOrderDetail_Product_ProductID`;
ALTER TABLE `default`.`SalesLT.SalesOrderDetail` DROP FOREIGN KEY `FK_SalesOrderDetail_SalesOrderHeader_SalesOrderID`;
ALTER TABLE `default`.`SalesLT.SalesOrderHeader` DROP FOREIGN KEY `FK_SalesOrderHeader_Address_BillTo_AddressID`;
ALTER TABLE `default`.`SalesLT.SalesOrderHeader` DROP FOREIGN KEY `FK_SalesOrderHeader_Address_ShipTo_AddressID`;
ALTER TABLE `default`.`SalesLT.SalesOrderHeader` DROP FOREIGN KEY `FK_SalesOrderHeader_Customer_CustomerID`;

ALTER TABLE `default`.`SalesLT.Address` DROP INDEX `IX_Address_AddressLine1_AddressLine2_City_StateProvince_PostalCode_CountryRegion`;
ALTER TABLE `default`.`SalesLT.Address` DROP INDEX `IX_Address_StateProvince`;
ALTER TABLE `default`.`SalesLT.Customer` DROP INDEX `IX_Customer_EmailAddress`;
ALTER TABLE `default`.`SalesLT.ProductModel` DROP INDEX `PXML_ProductModel_CatalogDescription`;
ALTER TABLE `default`.`SalesLT.SalesOrderDetail` DROP INDEX `IX_SalesOrderDetail_ProductID`;
ALTER TABLE `default`.`SalesLT.SalesOrderHeader` DROP INDEX `IX_SalesOrderHeader_CustomerID`;

ALTER TABLE `default`.`SalesLT.Address` DROP PRIMARY KEY;
ALTER TABLE `default`.`SalesLT.Customer` DROP PRIMARY KEY;
ALTER TABLE `default`.`SalesLT.CustomerAddress` DROP PRIMARY KEY;
ALTER TABLE `default`.`SalesLT.Product` DROP PRIMARY KEY;
ALTER TABLE `default`.`SalesLT.ProductCategory` DROP PRIMARY KEY;
ALTER TABLE `default`.`SalesLT.ProductDescription` DROP PRIMARY KEY;
ALTER TABLE `default`.`SalesLT.ProductModel` DROP PRIMARY KEY;
ALTER TABLE `default`.`SalesLT.ProductModelProductDescription` DROP PRIMARY KEY;
ALTER TABLE `default`.`SalesLT.SalesOrderDetail` DROP PRIMARY KEY;
ALTER TABLE `default`.`SalesLT.SalesOrderHeader` DROP PRIMARY KEY;

DROP TABLE IF EXISTS `default`.`SalesLT. CustomerCredentials`;
DROP TABLE IF EXISTS `default`.`SalesLT. SeasonalDiscounts`;
DROP TABLE IF EXISTS `default`.`SalesLT.Address`;
DROP TABLE IF EXISTS `default`.`SalesLT.Customer`;
DROP TABLE IF EXISTS `default`.`SalesLT.CustomerAddress`;
DROP TABLE IF EXISTS `default`.`SalesLT.Product`;
DROP TABLE IF EXISTS `default`.`SalesLT.ProductCategory`;
DROP TABLE IF EXISTS `default`.`SalesLT.ProductDescription`;
DROP TABLE IF EXISTS `default`.`SalesLT.ProductModel`;
DROP TABLE IF EXISTS `default`.`SalesLT.ProductModelProductDescription`;
DROP TABLE IF EXISTS `default`.`SalesLT.SalesOrderDetail`;
DROP TABLE IF EXISTS `default`.`SalesLT.SalesOrderHeader`;
DROP TABLE IF EXISTS `default`.`SalesLT.vGetAllCategories`;
DROP TABLE IF EXISTS `default`.`SalesLT.vProductAndDescription`;
DROP TABLE IF EXISTS `default`.`SalesLT.vProductModelCatalogDescription`;

CREATE TABLE `default`.`SalesLT. CustomerCredentials`  (
  `CustomerCredentialsID` int NOT NULL,
  `CustomerID` int NOT NULL,
  `CreatedDate` datetime NOT NULL,
  `ModifiedDate` datetime NOT NULL,
  `PasswordSalt` varchar(10) NOT NULL,
  `PasswordHash` varchar(128) NOT NULL,
  PRIMARY KEY (`CustomerCredentialsID`)
);

CREATE TABLE `default`.`SalesLT. SeasonalDiscounts`  (
  `SeasonalDiscountsID` int NOT NULL,
  `SeasonName` varchar(50) NOT NULL,
  `DiscountPercent` decimal(0, 0) NOT NULL,
  `CreatedDate` date NOT NULL,
  `ModifiedDate` date NOT NULL,
  PRIMARY KEY (`SeasonalDiscountsID`)
);

CREATE TABLE `default`.`SalesLT.Address`  (
  `AddressID` int NOT NULL COMMENT 'Primary key for Address records.',
  `AddressLine1` varchar(60) NOT NULL COMMENT 'First street address line.',
  `AddressLine2` varchar(60) NULL COMMENT 'Second street address line.',
  `City` varchar(30) NOT NULL COMMENT 'Name of the city.',
  `StateProvince` longtext NOT NULL COMMENT 'Name of state or province.',
  `CountryRegion` longtext NOT NULL,
  `PostalCode` varchar(15) NOT NULL COMMENT 'Postal code for the street address.',
  `rowguid` char(36) NOT NULL COMMENT 'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.',
  `ModifiedDate` datetime NOT NULL COMMENT 'Date and time the record was last updated.',
  PRIMARY KEY (`AddressID`),
  UNIQUE INDEX `IX_Address_AddressLine1_AddressLine2_City_StateProvince_PostalCode_CountryRegion`(`AddressLine1`, `AddressLine2`, `City`, `StateProvince`, `PostalCode`, `CountryRegion`) COMMENT 'Nonclustered index.',
  UNIQUE INDEX `IX_Address_StateProvince`(`StateProvince`) COMMENT 'Nonclustered index.'
) COMMENT = 'Street address information for customers.';

CREATE TABLE `default`.`SalesLT.Customer`  (
  `CustomerID` int NOT NULL COMMENT 'Primary key for Customer records.',
  `NameStyle` longtext NOT NULL COMMENT '0 = The data in FirstName and LastName are stored in western style (first name, last name) order.  1 = Eastern style (last name, first name) order.',
  `Title` varchar(8) NULL COMMENT 'A courtesy title. For example, Mr. or Ms.',
  `FirstName` longtext NOT NULL COMMENT 'First name of the person.',
  `MiddleName` longtext NULL COMMENT 'Middle name or middle initial of the person.',
  `LastName` longtext NOT NULL COMMENT 'Last name of the person.',
  `Suffix` varchar(10) NULL COMMENT 'Surname suffix. For example, Sr. or Jr.',
  `CompanyName` varchar(128) NULL COMMENT 'The customer\'s organization.',
  `SalesPerson` text NULL COMMENT 'The customer\'s sales person, an employee of AdventureWorks Cycles.',
  `EmailAddress` varchar(50) NULL COMMENT 'E-mail address for the person.',
  `Phone` longtext NULL COMMENT 'Phone number associated with the person.',
  `rowguid` char(36) NOT NULL COMMENT 'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.',
  `ModifiedDate` datetime NOT NULL COMMENT 'Date and time the record was last updated.',
  PRIMARY KEY (`CustomerID`),
  UNIQUE INDEX `IX_Customer_EmailAddress`(`EmailAddress`) COMMENT 'Nonclustered index.'
) COMMENT = 'Customer information.';

CREATE TABLE `default`.`SalesLT.CustomerAddress`  (
  `CustomerID` int NOT NULL COMMENT 'Primary key. Foreign key to Customer.CustomerID.',
  `AddressID` int NOT NULL COMMENT 'Primary key. Foreign key to Address.AddressID.',
  `AddressType` longtext NOT NULL COMMENT 'The kind of Address. One of: Archive, Billing, Home, Main Office, Primary, Shipping',
  `rowguid` char(36) NOT NULL COMMENT 'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.',
  `ModifiedDate` datetime NOT NULL COMMENT 'Date and time the record was last updated.',
  PRIMARY KEY (`CustomerID`, `AddressID`)
) COMMENT = 'Cross-reference table mapping customers to their address(es).';

CREATE TABLE `default`.`SalesLT.Product`  (
  `ProductID` int NOT NULL COMMENT 'Primary key for Product records.',
  `Name` longtext NOT NULL COMMENT 'Name of the product.',
  `ProductNumber` varchar(25) NOT NULL COMMENT 'Unique product identification number.',
  `Color` varchar(15) NULL COMMENT 'Product color.',
  `StandardCost` decimal(19, 4) NOT NULL COMMENT 'Standard cost of the product.',
  `ListPrice` decimal(19, 4) NOT NULL COMMENT 'Selling price.',
  `Size` varchar(5) NULL COMMENT 'Product size.',
  `Weight` decimal(8, 2) NULL COMMENT 'Product weight.',
  `ProductCategoryID` int NULL COMMENT 'Product is a member of this product category. Foreign key to ProductCategory.ProductCategoryID. ',
  `ProductModelID` int NULL COMMENT 'Product is a member of this product model. Foreign key to ProductModel.ProductModelID.',
  `SellStartDate` datetime NOT NULL COMMENT 'Date the product was available for sale.',
  `SellEndDate` datetime NULL COMMENT 'Date the product was no longer available for sale.',
  `DiscontinuedDate` datetime NULL COMMENT 'Date the product was discontinued.',
  `ThumbNailPhoto` longblob NULL COMMENT 'Small image of the product.',
  `ThumbnailPhotoFileName` varchar(50) NULL COMMENT 'Small image file name.',
  `rowguid` char(36) NOT NULL COMMENT 'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.',
  `ModifiedDate` datetime NOT NULL COMMENT 'Date and time the record was last updated.',
  PRIMARY KEY (`ProductID`)
) COMMENT = 'Products sold or used in the manfacturing of sold products.';

CREATE TABLE `default`.`SalesLT.ProductCategory`  (
  `ProductCategoryID` int NOT NULL COMMENT 'Primary key for ProductCategory records.',
  `ParentProductCategoryID` int NULL COMMENT 'Product category identification number of immediate ancestor category. Foreign key to ProductCategory.ProductCategoryID.',
  `Name` longtext NOT NULL COMMENT 'Category description.',
  `rowguid` char(36) NOT NULL COMMENT 'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.',
  `ModifiedDate` datetime NOT NULL COMMENT 'Date and time the record was last updated.',
  PRIMARY KEY (`ProductCategoryID`)
) COMMENT = 'High-level product categorization.';

CREATE TABLE `default`.`SalesLT.ProductDescription`  (
  `ProductDescriptionID` int NOT NULL COMMENT 'Primary key for ProductDescription records.',
  `Description` text NOT NULL COMMENT 'Description of the product.',
  `rowguid` char(36) NOT NULL COMMENT 'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.',
  `ModifiedDate` datetime NOT NULL COMMENT 'Date and time the record was last updated.',
  PRIMARY KEY (`ProductDescriptionID`)
) COMMENT = 'Product descriptions in several languages.';

CREATE TABLE `default`.`SalesLT.ProductModel`  (
  `ProductModelID` int NOT NULL,
  `Name` longtext NOT NULL,
  `CatalogDescription` text NULL,
  `rowguid` char(36) NOT NULL,
  `ModifiedDate` datetime NOT NULL,
  PRIMARY KEY (`ProductModelID`),
  UNIQUE INDEX `PXML_ProductModel_CatalogDescription`(`CatalogDescription`)
);

CREATE TABLE `default`.`SalesLT.ProductModelProductDescription`  (
  `ProductModelID` int NOT NULL COMMENT 'Primary key. Foreign key to ProductModel.ProductModelID.',
  `ProductDescriptionID` int NOT NULL COMMENT 'Primary key. Foreign key to ProductDescription.ProductDescriptionID.',
  `Culture` char(6) NOT NULL COMMENT 'The culture for which the description is written',
  `rowguid` char(36) NOT NULL,
  `ModifiedDate` datetime NOT NULL COMMENT 'Date and time the record was last updated.',
  PRIMARY KEY (`ProductModelID`, `ProductDescriptionID`, `Culture`)
) COMMENT = 'Cross-reference table mapping product descriptions and the language the description is written in.';

CREATE TABLE `default`.`SalesLT.SalesOrderDetail`  (
  `SalesOrderID` int NOT NULL COMMENT 'Primary key. Foreign key to SalesOrderHeader.SalesOrderID.',
  `SalesOrderDetailID` int NOT NULL COMMENT 'Primary key. One incremental unique number per product sold.',
  `OrderQty` smallint NOT NULL COMMENT 'Quantity ordered per product.',
  `ProductID` int NOT NULL COMMENT 'Product sold to customer. Foreign key to Product.ProductID.',
  `UnitPrice` decimal(19, 4) NOT NULL COMMENT 'Selling price of a single product.',
  `LineTotal` decimal(0, 0) NOT NULL COMMENT 'Per product subtotal. Computed as UnitPrice * (1 - UnitPriceDiscount) * OrderQty.',
  `rowguid` char(36) NOT NULL COMMENT 'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.',
  `ModifiedDate` datetime NOT NULL COMMENT 'Date and time the record was last updated.',
  `SeasonalDiscountID` int NULL,
  `MemberShipType` varchar(50) NULL,
  PRIMARY KEY (`SalesOrderID`, `SalesOrderDetailID`),
  UNIQUE INDEX `IX_SalesOrderDetail_ProductID`(`ProductID`) COMMENT 'Nonclustered index.'
) COMMENT = 'Individual products associated with a specific sales order. See SalesOrderHeader.';

CREATE TABLE `default`.`SalesLT.SalesOrderHeader`  (
  `SalesOrderID` int NOT NULL COMMENT 'Primary key.',
  `RevisionNumber` tinyint NOT NULL COMMENT 'Incremental number to track changes to the sales order over time.',
  `OrderDate` datetime NOT NULL COMMENT 'Dates the sales order was created.',
  `DueDate` datetime NOT NULL COMMENT 'Date the order is due to the customer.',
  `ShipDate` datetime NULL COMMENT 'Date the order was shipped to the customer.',
  `Status` tinyint NOT NULL COMMENT 'Order current status. 1 = In process; 2 = Approved; 3 = Backordered; 4 = Rejected; 5 = Shipped; 6 = Cancelled',
  `OnlineOrderFlag` longtext NOT NULL COMMENT '0 = Order placed by sales person. 1 = Order placed online by customer.',
  `SalesOrderNumber` varchar NOT NULL COMMENT 'Unique sales order identification number.',
  `PurchaseOrderNumber` longtext NULL COMMENT 'Customer purchase order number reference. ',
  `AccountNumber` longtext NULL COMMENT 'Financial accounting number reference.',
  `CustomerID` int NOT NULL COMMENT 'Customer identification number. Foreign key to Customer.CustomerID.',
  `ShipToAddressID` int NULL COMMENT 'The ID of the location to send goods.  Foreign key to the Address table.',
  `BillToAddressID` int NULL COMMENT 'The ID of the location to send invoices.  Foreign key to the Address table.',
  `ShipMethod` varchar(50) NOT NULL COMMENT 'Shipping method. Foreign key to ShipMethod.ShipMethodID.',
  `CreditCardApprovalCode` varchar(15) NULL COMMENT 'Approval code provided by the credit card company.',
  `SubTotal` decimal(19, 4) NOT NULL COMMENT 'Sales subtotal. Computed as SUM(SalesOrderDetail.LineTotal)for the appropriate SalesOrderID.',
  `TaxAmt` decimal(19, 4) NOT NULL COMMENT 'Tax amount.',
  `Freight` decimal(19, 4) NOT NULL COMMENT 'Shipping cost.',
  `TotalDue` decimal(19, 4) NOT NULL COMMENT 'Total due from customer. Computed as Subtotal + TaxAmt + Freight.',
  `Comment` text NULL COMMENT 'Sales representative comments.',
  `rowguid` char(36) NOT NULL COMMENT 'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.',
  `ModifiedDate` datetime NOT NULL COMMENT 'Date and time the record was last updated.',
  PRIMARY KEY (`SalesOrderID`),
  UNIQUE INDEX `IX_SalesOrderHeader_CustomerID`(`CustomerID`) COMMENT 'Nonclustered index.'
) COMMENT = 'General sales order information.';

CREATE TABLE `default`.`SalesLT.vGetAllCategories`  ();

CREATE TABLE `default`.`SalesLT.vProductAndDescription`  (
  `ProductID` longtext NULL,
  `Name` longtext NULL,
  `ProductModel` longtext NULL,
  `Culture` longtext NULL,
  `Description` longtext NULL
);

CREATE TABLE `default`.`SalesLT.vProductModelCatalogDescription`  (
  `ProductModelID` longtext NULL,
  `Name` longtext NULL,
  `Summary` longtext NULL,
  `Manufacturer` longtext NULL,
  `Copyright` longtext NULL,
  `ProductURL` longtext NULL,
  `WarrantyPeriod` longtext NULL,
  `WarrantyDescription` longtext NULL,
  `NoOfYears` longtext NULL,
  `MaintenanceDescription` longtext NULL,
  `Wheel` longtext NULL,
  `Saddle` longtext NULL,
  `Pedal` longtext NULL,
  `BikeFrame` longtext NULL,
  `Crankset` longtext NULL,
  `PictureAngle` longtext NULL,
  `PictureSize` longtext NULL,
  `ProductPhotoID` longtext NULL,
  `Material` longtext NULL,
  `Color` longtext NULL,
  `ProductLine` longtext NULL,
  `Style` longtext NULL,
  `RiderExperience` longtext NULL,
  `rowguid` longtext NULL,
  `ModifiedDate` longtext NULL
);

ALTER TABLE `default`.`SalesLT. CustomerCredentials` ADD CONSTRAINT `fk_ CustomerCredentials_ CustomerCredentials_1` FOREIGN KEY (`CustomerID`) REFERENCES `default`.`SalesLT.Customer` (`CustomerID`);
ALTER TABLE `default`.`SalesLT. SeasonalDiscounts` ADD CONSTRAINT `fk_ SeasonalDiscounts_ SeasonalDiscounts_1` FOREIGN KEY (`SeasonalDiscountsID`) REFERENCES `default`.`SalesLT.SalesOrderDetail` (`SeasonalDiscountsID`);
ALTER TABLE `default`.`SalesLT.CustomerAddress` ADD CONSTRAINT `FK_CustomerAddress_Address_AddressID` FOREIGN KEY (`AddressID`) REFERENCES `default`.`SalesLT.Address` (`AddressID`);
ALTER TABLE `default`.`SalesLT.CustomerAddress` ADD CONSTRAINT `FK_CustomerAddress_Customer_CustomerID` FOREIGN KEY (`CustomerID`) REFERENCES `default`.`SalesLT.Customer` (`CustomerID`);
ALTER TABLE `default`.`SalesLT.Product` ADD CONSTRAINT `FK_Product_ProductCategory_ProductCategoryID` FOREIGN KEY (`ProductCategoryID`) REFERENCES `default`.`SalesLT.ProductCategory` (`ProductCategoryID`);
ALTER TABLE `default`.`SalesLT.Product` ADD CONSTRAINT `FK_Product_ProductModel_ProductModelID` FOREIGN KEY (`ProductModelID`) REFERENCES `default`.`SalesLT.ProductModel` (`ProductModelID`);
ALTER TABLE `default`.`SalesLT.ProductCategory` ADD CONSTRAINT `FK_ProductCategory_ProductCategory_ParentProductCategoryID_ProductCategoryID` FOREIGN KEY (`ParentProductCategoryID`) REFERENCES `default`.`SalesLT.ProductCategory` (`ProductCategoryID`);
ALTER TABLE `default`.`SalesLT.ProductModelProductDescription` ADD CONSTRAINT `FK_ProductModelProductDescription_ProductDescription_ProductDescriptionID` FOREIGN KEY (`ProductDescriptionID`) REFERENCES `default`.`SalesLT.ProductDescription` (`ProductDescriptionID`);
ALTER TABLE `default`.`SalesLT.ProductModelProductDescription` ADD CONSTRAINT `FK_ProductModelProductDescription_ProductModel_ProductModelID` FOREIGN KEY (`ProductModelID`) REFERENCES `default`.`SalesLT.ProductModel` (`ProductModelID`);
ALTER TABLE `default`.`SalesLT.SalesOrderDetail` ADD CONSTRAINT `FK_SalesOrderDetail_Product_ProductID` FOREIGN KEY (`ProductID`) REFERENCES `default`.`SalesLT.Product` (`ProductID`);
ALTER TABLE `default`.`SalesLT.SalesOrderDetail` ADD CONSTRAINT `FK_SalesOrderDetail_SalesOrderHeader_SalesOrderID` FOREIGN KEY (`SalesOrderID`) REFERENCES `default`.`SalesLT.SalesOrderHeader` (`SalesOrderID`);
ALTER TABLE `default`.`SalesLT.SalesOrderHeader` ADD CONSTRAINT `FK_SalesOrderHeader_Address_BillTo_AddressID` FOREIGN KEY (`BillToAddressID`) REFERENCES `default`.`SalesLT.Address` (`AddressID`);
ALTER TABLE `default`.`SalesLT.SalesOrderHeader` ADD CONSTRAINT `FK_SalesOrderHeader_Address_ShipTo_AddressID` FOREIGN KEY (`ShipToAddressID`) REFERENCES `default`.`SalesLT.Address` (`AddressID`);
ALTER TABLE `default`.`SalesLT.SalesOrderHeader` ADD CONSTRAINT `FK_SalesOrderHeader_Customer_CustomerID` FOREIGN KEY (`CustomerID`) REFERENCES `default`.`SalesLT.Customer` (`CustomerID`);

