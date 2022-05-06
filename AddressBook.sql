-- UC1 create database
CREATE DATABASE Address_Book_Service;
USE Address_Book_Service;

-- UC2 Adding Attributes to Table
CREATE TABLE AddressBookTable
(
firstName VARCHAR(15) NOT NULL,
lastName VARCHAR(20),
address VARCHAR(50) NOT NULL,
city VARCHAR(15) NOT NULL,
state VARCHAR(15) NOT NULL,
zip INT NOT NULL,
phoneNo BIGINT NOT NULL,
email VARCHAR(30) NOT NULL
);
SELECT * FROM AddressBookTable;

-- UC3 Inserting Values into the Table
INSERT INTO AddressBookTable(firstName,lastName,address,city,state,zip,phoneNo,email)
VALUES
('JON','SNOW','North,WestCordRoad','Bangalore','Karnataka',560023,8889998989,'jonsnow@gmail.com'),
('NED','STARK','North,WestCordRoad','Bangalore','Karnataka',560023,9992223456,'kingofnorth@gmail.com'),
('JAMIE','FOX','North,WestCordRoad','Bangalore','Karnataka',560023,6667859032,'whosthis@gmail.com');

INSERT INTO AddressBookTable(FirstName,LastName,Address,City,State,Zip,PhoneNo,Email)
VALUES
('DWAYNE','JONSON','South,regional','Mandya','Karnataka',560042,8882232098,'dwaynebald@gmail.com'),
('BRAN','BROKEN','North,DollarsColony','Mysore','Karnataka',500012,7048829322,'branbroken@gmail.com');

-- UC4 Updating or Editing Records by Name
UPDATE AddressBookTable SET Zip = 520004 WHERE FirstName = 'JAMIE';
UPDATE AddressBookTable SET City = 'Hassan' WHERE FirstName = 'JAMIE';
UPDATE AddressBookTable SET email = 'jamieFox@gmail.com' WHERE FirstName = 'JAMIE';
SELECT * FROM AddressBookTable;

SET SQL_SAFE_UPDATES = 0; -- turns off safe update mode

-- UC5 Deleting a Person Contact using Name
DELETE FROM AddressBookTable WHERE firstName = 'JAMIE';

-- UC6 Retrieving Person Details from His state or City Name
SELECT * FROM AddressBookTable WHERE city = 'Bangalore' OR state = 'Karnataka';

-- UC7 Size Of AddressBook By City & State
SELECT COUNT(*) AS CityCount,city FROM AddressBookTable GROUP BY city;

SELECT COUNT(*) AS StateCount,state FROM AddressBookTable GROUP BY state;

-- UC8 Retrive Entries Sorted Alphabatically by Person's Name For Given City
SELECT * FROM AddressBookTable WHERE city = 'Bangalore' ORDER BY firstName;

-- UC9 Ability to Identify Contacts by Type & AddressBookName
ALTER TABLE AddressBookTable
ADD type VARCHAR(15);
ALTER TABLE AddressBookTable
ADD addressBookName VARCHAR(30);

UPDATE AddressBookTable SET type = 'Friends' WHERE City = 'Bangalore';
UPDATE AddressBookTable SET type = 'Family' WHERE NOT City  = 'Bangalore';
UPDATE AddressBookTable SET type = 'Profession' WHERE FirstName  = 'BRAN';
UPDATE AddressBookTable SET AddressBookName = 'Addbook1' WHERE FirstName  = 'NED';
UPDATE AddressBookTable SET AddressBookName = 'Addbook1' WHERE FirstName  = 'JON';
UPDATE AddressBookTable SET AddressBookName = 'Addbook2' WHERE FirstName  = 'DWAYNE';
UPDATE AddressBookTable SET AddressBookName = 'Addbook2' WHERE FirstName  = 'BRAN';
SELECT * FROM AddressBookTable;

-- UC10 Ability to get Number Of Contact Persons by Count By Type
SELECT Type,COUNT(Type) AS NumberOfContactPersons FROM AddressBookTable GROUP BY Type;

-- UC11 Ability to Add Person to both Friend & Family
INSERT INTO AddressBookTable(FirstName,LastName,Address,City,State,Zip,PhoneNo,Email,Type)
VALUES
('JON','SNOW','North,WestCordRoad','Bangalore','Karnataka',560023,8889998989,'jonsnow@gmail.com','Family');

-- UC12 Drawing ER Diagrams after identifying Entities using Normalization
-- Creating Entities of AddressBookName, ConactDetails, TypeDetais & Type Manager

DROP TABLE AddressBookTable;

CREATE TABLE AddressBookNameTable
(
AddressBookId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
AddressBookName VARCHAR(50)
);
SELECT * FROM AddressBookNameTable;
INSERT INTO AddressBookNameTable
VALUES(1,'Addbook1'),(2,'Addbook2');

CREATE TABLE PersonContactsTable
(
PersonID INT NOT NULL auto_increment PRIMARY KEY,
FirstName VARCHAR(30),
LastName VARCHAR(50),
AddressDetails VARCHAR(150),
City VARCHAR(50),
StateName VARCHAR (50),
Zip INT,
PhoneNo BIGINT,
Email VARCHAR(60),
AddressBookSelect INT,
FOREIGN KEY (AddressBookSelect) REFERENCES AddressBookNameTable(AddressBookId)
);

SELECT * FROM PersonContactsTable;

INSERT INTO PersonContactsTable
VALUES
(1,'NED','STARK','North,WestCordRoad','Ongole','UttarPradesh',523241,8889998989,'starkhead@gmail.com',1),
(2,'ROB','STARK','North,WestCordRoad','Ongole','AndhraPradesh',523241,9992223456,'robstark@gmail.com',1),
(3,'BRAN','STARK','South,regional','Turuvallur','Chennai',135001,8882232098,'brandied@gmail.com',2),
(4,'ARYA','STARK','North,DollarsColony','Rohtak','Hyderabad',124001,7048829322,'aryastark@gmail.com',2),
(5,'JON','SNOW','Richmond Town','Mysore','Karnataka',140001,8889998989,'jonnyt@gmail.com',1);

CREATE TABLE TypeEntityTable
(
TypeID INT NOT NULL auto_increment PRIMARY KEY,
TypeName VARCHAR(30)
);
SELECT * FROM TypeEntityTable;

INSERT INTO TypeEntityTable
VALUES ('Friend'),('Professional'),('Family'),('BusinessMan'),('College');


CREATE TABLE TypeHandler
(
TypeSelect INT,
PersonSelect INT,
FOREIGN KEY (TypeSelect) REFERENCES TypeEntityTable(TypeID),
FOREIGN KEY (PersonSelect) REFERENCES PersonContactsTable(PersonID)
);

INSERT INTO TypeHandler
VALUES (1,1),(3,1),(1,2),(3,2),(2,3),(4,4),(1,5),(3,5),(5,5);
SELECT * FROM TypeHandler;

SELECT PersonID,AddressBookName,FirstName,LastName,AddressDetails,City,StateName,Zip,PhoneNo,Email,TypeName FROM AddressBookNameTable
INNER JOIN PersonContactsTable ON AddressBookNameTable.AddressBookId = PersonContactsTable.AddressBookSelect
INNER JOIN TypeHandler ON PersonContactsTable.PersonID = TypeHandler.PersonSelect
INNER JOIN TypeEntityTable ON TypeHandler.TypeSelect = TypeEntityTable.TypeID;

-- UC13 Retrieving All data as  Prevoius UC's

-- Retrieving Person Details from A Particular City or State
SELECT PersonID,AddressBookName,FirstName,LastName,AddressDetails,City,StateName,Zip,PhoneNo,Email,TypeName FROM AddressBookNameTable
INNER JOIN PersonContactsTable ON AddressBookNameTable.AddressBookId = PersonContactsTable.AddressBookSelect AND City = 'Rohtak'
INNER JOIN TypeHandler ON PersonContactsTable.PersonID = TypeHandler.PersonSelect
INNER JOIN TypeEntityTable ON TypeHandler.TypeSelect = TypeEntityTable.TypeID;

SELECT PersonID,AddressBookName,FirstName,LastName,AddressDetails,City,StateName,Zip,PhoneNo,Email FROM AddressBookNameTable
INNER JOIN PersonContactsTable ON AddressBookNameTable.AddressBookId = PersonContactsTable.AddressBookSelect AND (City = 'Rohtak' AND StateName = 'Hyderabad');

SELECT PersonID,AddressBookName,CONCAT(FirstName,' ',LastName) AS FullName,CONCAT(AddressDetails,',',City,',',StateName,',',Zip) AS FullAddress,PhoneNo,Email FROM AddressBookNameTable
INNER JOIN PersonContactsTable ON AddressBookNameTable.AddressBookId = PersonContactsTable.AddressBookSelect AND (City = 'Rohtak' AND StateName = 'Hyderabad');

SELECT COUNT(*),City FROM PersonContactsTable 
GROUP BY City;

SELECT COUNT(*),City,StateName FROM PersonContactsTable 
GROUP BY City,StateName;

-- Sorting Alphabatically by First Name
SELECT PersonID,AddressBookName,CONCAT(FirstName,' ',LastName) AS FullName,CONCAT(AddressDetails,',',City,',',StateName,',',Zip) AS FullAddress,PhoneNo,Email,TypeName FROM PersonContactsTable
INNER JOIN AddressBookNameTable ON AddressBookNameTable.AddressBookId = PersonContactsTable.AddressBookSelect
INNER JOIN TypeHandler ON PersonContactsTable.PersonID = TypeHandler.PersonSelect
INNER JOIN TypeEntityTable ON TypeHandler.TypeSelect = TypeEntityTable.TypeID
ORDER BY FirstName;

SELECT COUNT(*) AS NoOfContacts,TypeName FROM PersonContactsTable
INNER JOIN AddressBookNameTable ON AddressBookNameTable.AddressBookId = PersonContactsTable.AddressBookSelect
INNER JOIN TypeHandler ON PersonContactsTable.PersonID = TypeHandler.PersonSelect
INNER JOIN TypeEntityTable ON TypeHandler.TypeSelect = TypeEntityTable.TypeID
GROUP BY TypeName;


