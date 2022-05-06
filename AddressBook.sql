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

