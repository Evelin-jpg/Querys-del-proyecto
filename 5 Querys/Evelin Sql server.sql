USE master;
GO
IF DB_ID(N'SchoolServicesEve')IS NOT NULL
DROP DATABASE SchoolServicesEve;
GO
CREATE DATABASE SchoolServicesEve
ON
(NAME = SchoolServicesEve_dat,
FILENAME= 'C:\BaseDatos\SchoolServicesEve.mdf',
SIZE = 10,
MAXSIZE = 50,
FILEGROWTH = 5)
LOG ON 
(NAME =PEMEX_log,
FILENAME = 'C:\BaseDatos\SchoolServicesEve.ldf',
SIZE = 5MB,
MAXSIZE = 25MB,
FILEGROWTH = 5MB);
GO
USE SchoolServicesEve;
GO

-- Use
CREATE TABLE [dbo].[Use] (
    idUser INT IDENTITY(1,1) PRIMARY KEY,
    userName NVARCHAR(50) UNIQUE NOT NULL,
    name NVARCHAR(50) NOT NULL,
    password NVARCHAR(10) NOT NULL,
    email NVARCHAR(100) NOT NULL,
    status BIT NOT NULL DEFAULT 1,
    idUserCreate INT,
    creationDate DATETIME,
    idUserModify INT,
    modifiedDate DATETIME
);

-- EmployeeType
CREATE TABLE [dbo].[EmployeeType] (
    EmployeeTypeID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(50) NOT NULL,
    BaseSalary DECIMAL(10, 2) NOT NULL,
    Hours INT NOT NULL,
    Status INT DEFAULT 1 NOT NULL,
    idUserCreate INT NOT NULL,
    creationDate DATETIME NOT NULL,
    idUserModify INT,
    modifiedDate DATETIME
);

-- Employee
CREATE TABLE [dbo].[Employee] (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    MiddleName NVARCHAR(50) NOT NULL,
    PhoneNumber NVARCHAR(15) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    Gender CHAR(1) NOT NULL,
    Position NVARCHAR(50) NOT NULL,
    Salary DECIMAL(10, 2) NOT NULL,
    DateOfBirth DATETIME NOT NULL,
    Address NVARCHAR(100) NOT NULL,
    ZipCode NVARCHAR(10) NOT NULL,
    RFC NVARCHAR(13) NOT NULL,
    SocialSecurity NVARCHAR(15) NOT NULL,
    EmployeeTypeID INT NOT NULL,
    Status INT DEFAULT 1 NOT NULL,
    idUserCreate INT NOT NULL,
    creationDate DATETIME NOT NULL,
    idUserModify INT,
    modifiedDate DATETIME
);

-- Career
CREATE TABLE [dbo].[Career] (
    CareerID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(50) NOT NULL,
    Description NVARCHAR(100) NOT NULL,
    Status INT DEFAULT 1 NOT NULL,
    idUserCreate INT NOT NULL,
    creationDate DATETIME NOT NULL,
    idUserModify INT,
    modifiedDate DATETIME
);

-- DocumentType
CREATE TABLE [dbo].[DocumentType] (
    DocumentTypeID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(50) NOT NULL,
    Description NVARCHAR(100) NOT NULL,
    Status INT DEFAULT 1 NOT NULL,
    idUserCreate INT NOT NULL,
    creationDate DATETIME NOT NULL,
    idUserModify INT,
    modifiedDate DATETIME
);

-- DocumentRequest
CREATE TABLE [dbo].[DocumentRequest] (
    DocumentRequestID INT IDENTITY(1,1) PRIMARY KEY,
    StudentID INT NOT NULL,
    DocumentTypeID INT NOT NULL,
    EmployeeID INT NOT NULL,
    RequestDate DATETIME NOT NULL,
    idUserCreate INT NOT NULL,
    creationDate DATETIME NOT NULL,
    idUserModify INT,
    modifiedDate DATETIME
);

-- Foreign Keys
-- Employee
ALTER TABLE [dbo].[Employee]
ADD CONSTRAINT FK_EmployeeEmployeeType FOREIGN KEY (EmployeeTypeID) REFERENCES [dbo].[EmployeeType] (EmployeeTypeID);

ALTER TABLE [dbo].[Employee]
ADD CONSTRAINT FK_Employeecreate FOREIGN KEY (idUserCreate) REFERENCES [dbo].[Use] (idUser);

ALTER TABLE [dbo].[Employee]
ADD CONSTRAINT FK_Employeemodify FOREIGN KEY (idUserModify) REFERENCES [dbo].[Use] (idUser);

-- EmployeeType
ALTER TABLE [dbo].[EmployeeType]
ADD CONSTRAINT FK_Employeetypecreate FOREIGN KEY (idUserCreate) REFERENCES [dbo].[Use] (idUser);

ALTER TABLE [dbo].[EmployeeType]
ADD CONSTRAINT FK_Employeetypemodify FOREIGN KEY (idUserModify) REFERENCES [dbo].[Use] (idUser);

-- DocumentRequest
ALTER TABLE [dbo].[DocumentRequest]
ADD CONSTRAINT FK_DocumentRequestDocumentType FOREIGN KEY (DocumentTypeID) REFERENCES [dbo].[DocumentType] (DocumentTypeID);

ALTER TABLE [dbo].[DocumentRequest]
ADD CONSTRAINT FK_DocumentRequestEmployee FOREIGN KEY (EmployeeID) REFERENCES [dbo].[Employee] (EmployeeID);

ALTER TABLE [dbo].[DocumentRequest]
ADD CONSTRAINT FK_DocumentRequestcreate FOREIGN KEY (idUserCreate) REFERENCES [dbo].[Use] (idUser);

ALTER TABLE [dbo].[DocumentRequest]
ADD CONSTRAINT FK_DocumentRequestmodify FOREIGN KEY (idUserModify) REFERENCES [dbo].[Use] (idUser);

-- DocumentType
ALTER TABLE [dbo].[DocumentType]
ADD CONSTRAINT FK_DocumentTypecreate FOREIGN KEY (idUserCreate) REFERENCES [dbo].[Use] (idUser);

ALTER TABLE [dbo].[DocumentType]
ADD CONSTRAINT FK_DocumentTypemodify FOREIGN KEY (idUserModify) REFERENCES [dbo].[Use] (idUser);

-- Career
ALTER TABLE [dbo].[Career]
ADD CONSTRAINT FK_Careercreate FOREIGN KEY (idUserCreate) REFERENCES [dbo].[Use] (idUser);

ALTER TABLE [dbo].[Career]
ADD CONSTRAINT FK_Careermodify FOREIGN KEY (idUserModify) REFERENCES [dbo].[Use] (idUser);

-- Índices
CREATE INDEX IX_Employee ON [dbo].[Employee] (EmployeeID);
CREATE INDEX IX_EmployeeType ON [dbo].[EmployeeType] (EmployeeTypeID);
CREATE INDEX IX_Career ON [dbo].[Career] (CareerID);
CREATE INDEX IX_DocumentRequest ON [dbo].[DocumentRequest] (DocumentRequestID);
CREATE INDEX IX_DocumentType ON [dbo].[DocumentType] (DocumentTypeID);

-- Insert
INSERT INTO [dbo].[Use] (UserName, name, password, email, idUserCreate, creationDate)
VALUES ('sa', 'Super Admin', 'AdM1nPaSsW', 'superadmin@example.com', NULL, NULL),
       ('Evelin', 'Evelin Barrera', 'Us3rPwd!23', 'yael_r3y@example.com', 1, '2023-12-08');

INSERT INTO [dbo].[EmployeeType] (Name, BaseSalary, Hours, idUserCreate, creationDate)
VALUES ('Full-Time', 50000.00, 40, 1, '2023-12-12');

-- ... (resto de las inserciones)

INSERT INTO EmployeeType (Name, BaseSalary, Hours, idUserCreate, creationDate)
VALUES ('Full-Time', 50000.00, 40, 1, '2023-12-12');

INSERT INTO EmployeeType (Name, BaseSalary, Hours, idUserCreate, creationDate)
VALUES ('Part-Time', 25000.00, 20, 1, '2023-12-12');

INSERT INTO EmployeeType (Name, BaseSalary, Hours, idUserCreate, creationDate)
VALUES ('Contract', 35000.00, 30, 1, '2023-12-12');

INSERT INTO Employee (FirstName, LastName, MiddleName, PhoneNumber, Email, Gender, Position, Salary, DateOfBirth, Address, ZipCode, RFC, SocialSecurity, EmployeeTypeID, idUserCreate, creationDate)
VALUES ('John', 'Doe', 'A', '123-456-7890', 'john.doe@email.com', 'M', 'Manager', 60000.00, '1990-05-15', '123 Main St', '12345', 'ABC123456DEF', '123-45-6789', 1, 1, '2023-12-12');

INSERT INTO Employee (FirstName, LastName, MiddleName, PhoneNumber, Email, Gender, Position, Salary, DateOfBirth, Address, ZipCode, RFC, SocialSecurity, EmployeeTypeID, idUserCreate, creationDate)
VALUES ('Jane', 'Smith', 'B', '987-654-3210', 'jane.smith@email.com', 'F', 'Assistant', 40000.00, '1995-09-20', '456 Elm St', '54321', 'XYZ987654ABC', '987-65-4321', 2, 1, '2023-12-12');

INSERT INTO Employee (FirstName, LastName, MiddleName, PhoneNumber, Email, Gender, Position, Salary, DateOfBirth, Address, ZipCode, RFC, SocialSecurity, EmployeeTypeID, idUserCreate, creationDate)
VALUES ('David', 'Williams', 'C', '555-123-9876', 'david.williams@email.com', 'M', 'Developer', 55000.00, '1988-03-10', '789 Oak St', '67890', 'PQR555123XYZ', '555-12-3987', 1, 1, '2023-12-12');

INSERT INTO Career (Name, Description, Status, idUserCreate, creationDate)
VALUES ('Computer Science', 'Programs for the computer science field.', 1, 1, '2023-12-12');

INSERT INTO Career (Name, Description, Status, idUserCreate, creationDate)
VALUES ('Business Administration', 'Programs for business management.', 1, 1, '2023-12-12');

INSERT INTO Career (Name, Description, Status, idUserCreate, creationDate)
VALUES ('Mechanical Engineering', 'Programs for mechanical engineering.', 1, 1, '2023-12-12');

INSERT INTO DocumentType (Name, Description, Status, idUserCreate, creationDate)
VALUES ('Transcript', 'Academic transcript document.', 1, 1, '2023-12-12');

INSERT INTO DocumentType (Name, Description, Status, idUserCreate, creationDate)
VALUES ('Diploma', 'Certificate of completion.', 1, 1, '2023-12-12');

INSERT INTO DocumentType (Name, Description, Status, idUserCreate, creationDate)
VALUES ('Recommendation Letter', 'Letter of recommendation.', 1, 1, '2023-12-12');

INSERT INTO DocumentRequest (StudentID, DocumentTypeID, EmployeeID, RequestDate, idUserCreate, creationDate)
VALUES (1, 1, 1, '2023-10-15', 1, '2023-12-12');

INSERT INTO DocumentRequest (StudentID, DocumentTypeID, EmployeeID, RequestDate, idUserCreate, creationDate)
VALUES (2, 2, 2, '2023-10-16', 1, '2023-12-12');

INSERT INTO DocumentRequest (StudentID, DocumentTypeID, EmployeeID, RequestDate, idUserCreate, creationDate)
VALUES (3, 3, 3, '2023-10-17', 1, '2023-12-12');
