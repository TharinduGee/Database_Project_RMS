/*Schema Creation*/

CREATE DATABASE Restaurant_Management_System;

USE Restaurant_Management_System;

/*Table Definition*/

CREATE TABLE SUPPLIER(
	Supplier_ID VARCHAR(5) NOT NULL,
    First_Name VARCHAR(15)  NOT NULL,
    Last_Name VARCHAR(15) NOT NULL,
    Phone_No CHAR(10) NOT NULL,
    PRIMARY KEY(Supplier_ID)
);

CREATE TABLE RESTAURANT(
	Res_ID VARCHAR(5) NOT NULL,
    Name VARCHAR(15)  NOT NULL,
    Address VARCHAR(25) ,
    Phone_No CHAR(10) NOT NULL,
    Supplier_ID VARCHAR(5) ,
    PRIMARY KEY(Res_ID),
    CONSTRAINT FK_Supplier_ID FOREIGN KEY(Supplier_ID) REFERENCES SUPPLIER(Supplier_ID)
    ON DELETE SET NULL
    ON UPDATE CASCADE
);


CREATE TABLE _TABLE_(
	Table_ID INT NOT NULL,
    Capacity INT  DEFAULT 4,
    Status BOOLEAN DEFAULT TRUE ,
    Res_ID VARCHAR(5),
    PRIMARY KEY(Table_ID),
    CONSTRAINT FK_Res_ID FOREIGN KEY(Res_ID) REFERENCES RESTAURANT(Res_ID)
    ON DELETE SET NULL
    ON UPDATE CASCADE
);

CREATE TABLE EMPLOYEE(
	Emp_ID INT NOT NULL,
    First_Name VARCHAR(15)  NOT NULL,
    Middle_Name VARCHAR(15)  ,
    Last_Name VARCHAR(15)  ,
    NIC_No CHAR(10) NOT NULL UNIQUE,
    Salary INT DEFAULT 25000,
    Phone_No CHAR(10) NOT NULL,
    Job_ID VARCHAR(5),
    Job_Name VARCHAR(15),
    Recruited_Date DATE ,
    Pay_Day INT GENERATED ALWAYS AS (DAY(Recruited_Date)),
    Res_ID VARCHAR(5) ,
    Manager_ID INT,
    PRIMARY KEY(Emp_ID),
    CONSTRAINT FK_Res_ID_EMPLOYEE FOREIGN KEY(Res_ID) REFERENCES RESTAURANT(Res_ID)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
    CONSTRAINT FK_Manager_ID FOREIGN KEY(Manager_ID) REFERENCES EMPLOYEE(Emp_ID)
    ON DELETE SET NULL
    ON UPDATE CASCADE
);


CREATE TABLE CUSTOMER(
	Cus_ID INT NOT NULL,
    Cus_Name VARCHAR(10),
    Cus_Email VARCHAR(30),
    Phone_No CHAR(10),
    PRIMARY KEY(Cus_ID)
);

CREATE TABLE _ORDER_(
	Order_ID VARCHAR(10) NOT NULL,
    Order_DateTime DATETIME DEFAULT CURRENT_TIMESTAMP,
    Total INT,
    Cus_ID INT,
    Table_ID INT,
    Emp_ID INT,
    PRIMARY KEY(Order_ID),
    CONSTRAINT FK_Cus FOREIGN KEY(Cus_ID) REFERENCES CUSTOMER(Cus_ID)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
    CONSTRAINT FK_Table FOREIGN KEY(Table_ID) REFERENCES _TABLE_(Table_ID)
    ON DELETE SET  NULL
    ON UPDATE CASCADE,
    CONSTRAINT FK_Emp FOREIGN KEY(Emp_ID) REFERENCES EMPLOYEE(Emp_ID)
    ON DELETE SET NULL
    ON UPDATE CASCADE
    
);

CREATE TABLE FOOD_ITEM(
	Item_Name VARCHAR(20) NOT NULL,
    Description VARCHAR(40) ,
	Price INT NOT NULL,
    Order_ID  VARCHAR(10),
    PRIMARY KEY(Item_Name , Order_ID),
    CONSTRAINT FK_STRONG_ORDER FOREIGN KEY(Order_ID) REFERENCES _ORDER_(Order_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE BILL(
	Payment_Time DATETIME DEFAULT CURRENT_TIMESTAMP,
    Payment_Method VARCHAR(10) DEFAULT 'CASH',
    Status VARCHAR(10) DEFAULT 'PENDING',
    Grand_Total INT ,
    Cus_ID INT,
    PRIMARY KEY(Payment_Time , Cus_ID),
    CONSTRAINT FK_STRONG_CUS FOREIGN KEY(Cus_ID) REFERENCES CUSTOMER(Cus_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE SUPPLY_ITEMS(	
	Supplier_ID VARCHAR(5) NOT NULL,
    Supplying_Item VARCHAR(15) ,
    PRIMARY KEY(Supplier_ID , Supplying_Item),
    CONSTRAINT FK_Supplier FOREIGN KEY(Supplier_ID) REFERENCES SUPPLIER(Supplier_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);


/*Insertion*/


INSERT INTO SUPPLIER (Supplier_ID, First_Name, Last_Name, Phone_No) VALUES
('S1', 'John', 'Doe', '1234567890'),
('S2', 'Tharindu', 'Geethanjan', '9876543210'),
('S3', 'Sahan', 'Gawesh', '5555555555'),
('S4', 'Hiruna', 'Fernando', '8888888888'),
('S5', 'Nuwan', 'Pradeep', '9994359999'),
('S6', 'David', 'Miller', '7777777777');

INSERT INTO RESTAURANT (Res_ID, Name, Address, Phone_No, Supplier_ID) VALUES
('R1', 'Orchid', ' 123A Main St Colombo', '0781234567', 'S1'),
('R2', 'Chill', ' 789 Kandy Rd Kandy', '0772345678', 'S2'),
('R3', 'Paprika', '456 Galle Rd Galle', '0783456789', 'S3'),
('R4', 'Boat House', '101 Negombo Rd Negombo', '0774567890', 'S4'),
('R5', 'Kings Kitchen', '567 Passara Rd Badulla', '0785678901', 'S5'),
('R6', 'Aroma', '234 Jaffna Rd Jaffna', '0776789012', 'S6');

INSERT INTO _TABLE_ (Table_ID, Capacity, Status, Res_ID) VALUES
(1, 4, FALSE, 'R1'),
(2, 6, FALSE, 'R1'),
(3, 4, TRUE, 'R2'),
(4, 8, FALSE, 'R2'),
(5, 4, TRUE, 'R3'),
(6, 6, FALSE, 'R3');

INSERT INTO EMPLOYEE (Emp_ID, First_Name, Middle_Name, Last_Name, NIC_No, Salary, Phone_No, Job_ID, Job_Name, Recruited_Date, Res_ID, Manager_ID) VALUES
(1, 'Nadun', NULL, 'Jayasighe', 'ABC123456', 100000, '0772345678', 'J1', 'Manager', '2023-01-15', 'R1', NULL),
(2, 'Supun', NULL, 'Sirisena', 'DEF789012', 25000, '0781234567', 'J2', 'Cleaner', '2023-02-10', 'R1', 1),
(4, 'Shehan', 'D.', NULL, 'JKL987654', 60000, '0774567890', 'J4', 'Waiter', '2023-04-05', 'R2', NULL),
(3, 'Isuru', NULL, NULL, 'GHI456789', 30000, '0783456789', 'J3', 'Receptionist', '2023-03-20', 'R2', 4),
(5, 'Tharindu', 'E.', 'Geethanjan', 'MNO123789', 80000, '0776789012', 'J5', 'Head Chef', '2023-05-10', 'R3', NULL),
(6, 'Hasika', NULL, 'Fernando', 'PQR789123', 27000, '0781234567', 'J5', 'Chef', '2023-06-15', 'R3', NULL);


INSERT INTO CUSTOMER (Cus_ID, Cus_Name, Cus_Email, Phone_No) VALUES
(1, 'Nimal', 'nimal@gmail.com', '0781234567'),
(2, 'Kamal', 'kamal@gmail.com', '0772345678'),
(3, 'Amal', 'amal@gmail.com', '0783456789'),
(4, 'Hiruni', 'hiruni@gmail.com', '0774567890'),
(5, 'Chathumi', 'chathumi@gmail.com', '0776789012'),
(6, 'Pabasara', 'pabasara@gmail.com', '0785678901');

INSERT INTO _ORDER_ (Order_ID, Total, Cus_ID, Table_ID, Emp_ID) VALUES
('O1', 3500, 1, 1, 1),
('O2', 2000, 2, 2, 2),
('O3', 3800, 3, 3, 3),
('O4', 3000, 4, 4, 4),
('O5', 1300, 5, 5, 5),
('O6', 500, 6, 6, 6);


INSERT INTO FOOD_ITEM (Item_Name, Description, Price, Order_ID) VALUES
('Burger', 'Medium burger', 1000, 'O1'),
('Chicken Pizza', 'Chicken pizza(thin crust)', 1500, 'O1'),
('Salad', 'Vegetable salad', 800, 'O2'),
('Pasta', 'Spaghetti pasta', 1200, 'O2'),
('Steak', 'Beef steak', 2000, 'O3'),
('Sushi', 'Stuffed sushi', 1800, 'O3'),
('Grilled chicken', 'Grilled chicken with pepper', 1400, 'O4'),
('Chicken Kottu', 'Chicken Kottu with onion rings', 1600, 'O4'),
('Ice Cream', 'Vanilla ice cream with topings', 500, 'O5'),
('Cake', 'Chocolate cake', 800, 'O5'),
('Coffee', 'Black coffee', 300, 'O6'),
('Tea', 'Green tea', 200, 'O6');


INSERT INTO BILL (Grand_Total, Cus_ID) VALUES
(3500, 1),
(2000, 2),
(3800, 3),
(3000, 4),
(1300, 5),
(500, 6);



INSERT INTO SUPPLY_ITEMS (Supplier_ID, Supplying_Item) VALUES
('S1', 'Cake'),
('S2', 'Vegetables'),
('S3', 'Fish'),
('S4', 'Treacle'),
('S5', 'Cake'),
('S6', 'Coffee');



/*Update*/

UPDATE SUPPLIER 
SET First_Name='Isuru' WHERE Supplier_ID='S2';
UPDATE SUPPLIER 
SET Phone_No='0785773534' WHERE Supplier_ID='S6';

UPDATE RESTAURANT 
SET Name='Cafe Chill' WHERE Supplier_ID='S2';
UPDATE RESTAURANT
SET Supplier_ID='S5' WHERE Res_ID='R6';

UPDATE _TABLE_ 
SET Status=TRUE WHERE Res_ID='R1';
UPDATE _TABLE_ 
SET Capacity=2 WHERE Table_ID='3';

UPDATE EMPLOYEE
SET Middle_Name=TRUE WHERE Emp_ID=1;
UPDATE EMPLOYEE
SET Manager_ID=5 WHERE Emp_ID=6;

UPDATE CUSTOMER
SET Cus_Email='pabasaraluzifer@gmail.com' WHERE Cus_ID=6;
UPDATE CUSTOMER
SET Cus_Name='Dilshan' WHERE Cus_ID=3;

UPDATE _ORDER_
SET Cus_ID='4' WHERE Order_ID='O3';
UPDATE _ORDER_
SET Total=400 WHERE Order_ID='O6';

UPDATE FOOD_ITEM
SET Item_Name='Medium Ham Bueger' WHERE Order_ID='O1' AND Price = 1000;
UPDATE FOOD_ITEM
SET Price=100  WHERE Order_ID='O6' AND Item_Name='Green tea';

UPDATE BILL
SET Grand_Total=400 WHERE Cus_ID = 6 ;
UPDATE BILL
SET Payment_Method='VOUCHER' WHERE Cus_ID = 2 ;

UPDATE SUPPLY_ITEMS
SET Supplying_Item='Chocalate Cake' WHERE Supplier_ID ='S2';
UPDATE SUPPLY_ITEMS
SET Supplying_Item='Tuna' WHERE Supplier_ID ='S3';


/*Deletion*/

DELETE FROM SUPPLIER WHERE Supplier_ID = 'S6' ;

DELETE FROM RESTAURANT WHERE Res_ID = 'R6' ;

DELETE FROM _TABLE_ WHERE Table_ID = '06' ;

DELETE FROM EMPLOYEE WHERE Emp_ID = 6 ;

DELETE FROM CUSTOMER WHERE Cus_ID = 6;

DELETE FROM _ORDER_ WHERE Order_ID = 'O6';

DELETE FROM FOOD_ITEM WHERE Order_ID='O6' AND Item_Name='Green tea';

DELETE FROM BILL WHERE Cus_ID = 5;

DELETE FROM SUPPLY_ITEMS WHERE Supplier_ID='S5';

/*Data Retrieval - Simple queries(Get the screenshots of the results)*/

SELECT * FROM EMPLOYEE WHERE Res_ID = 'R2'; 

SELECT Grand_Total FROM BILL WHERE Cus_ID = 4;

SELECT * FROM _TABLE_ CROSS JOIN RESTAURANT;

CREATE VIEW UV1 AS  SELECT Table_ID , Order_DateTime , Total FROM _ORDER_ ORDER BY Total; 
SELECT * FROM UV1;

SELECT Item_Name AS Food_Name , DESCRIPTION AS Additional_Instructions FROM FOOD_ITEM;

SELECT SUM(PRICE) AS Total FROM FOOD_ITEM WHERE Order_ID = 'O3';

SELECT Emp_ID , First_Name , Salary FROM EMPLOYEE WHERE  Job_Name LIKE '%chef';

/*Data Retrieval - Complex queries (Get the screenshots of the results)*/

(SELECT E.First_Name   FROM EMPLOYEE AS E )
UNION
(SELECT C.Cus_Name   FROM CUSTOMER AS C );

SELECT R.Res_ID   , R.Name , T.Table_ID , T.Capacity FROM RESTAURANT AS R 
NATURAL JOIN
_TABLE_ AS T 
WHERE CAPACITY > 4 ;

-- SELECT F.Item_Name , F.Price , F.Order_ID FROM FOOD_ITEM AS F 
-- WHERE O.Order_ID NOT IN(
-- 	SELECT O.Order_ID FROM _ORDER_ AS O WHERE O.Total > 3000
-- );

SELECT C.Cus_Name FROM CUSTOMER AS C
WHERE C.Cus_ID NOT IN (
    SELECT  O.Cus_ID FROM _ORDER_ AS O
);

-- division


SELECT O.Order_ID
FROM _ORDER_ AS O
WHERE NOT EXISTS (
    SELECT E.Emp_ID
    FROM EMPLOYEE AS E
    WHERE NOT EXISTS (
        SELECT O2.Order_ID
        FROM _ORDER_ O2
        WHERE O2.Emp_ID = E.Emp_ID
        AND O2.Order_ID = O.Order_ID
    )
);


-- InnerJoin
CREATE VIEW UV_InnerJoin AS
SELECT C.Cus_Name, O.Order_ID
FROM CUSTOMER AS C
INNER JOIN _ORDER_ AS O ON C.Cus_ID = O.Cus_ID;

SELECT * FROM UV_InnerJoin;

-- NaturalJoin

CREATE VIEW UV_NaturalJoin AS 
SELECT  E.First_Name, E.Last_Name , O.Order_ID , O.Total
FROM EMPLOYEE AS E 
NATURAL JOIN _order_ AS O ;

SELECT * FROM UV_NaturalJoin;

-- Left Outer Join
CREATE VIEW UV_LeftOuterJoin AS 
SELECT  R.Res_ID , R.Name, E.Emp_ID , E.First_Name , E.Salary  FROM RESTAURANT AS R 
LEFT OUTER JOIN 
EMPLOYEE AS E
ON R.Res_ID = E.Res_ID ;

SELECT * FROM UV_LeftOuterJoin;


-- Right Outer Join

CREATE VIEW UV_RightOuterJoin AS 
SELECT    B.Payment_Time , B.Grand_Total ,C.Cus_ID ,  C.Cus_Name   FROM BILL AS B
RIGHT OUTER JOIN 
CUSTOMER AS C ON B.Cus_ID = C.Cus_ID;

SELECT * FROM UV_RightOuterJoin;

-- Full Outer Join

CREATE VIEW UV_LEFTOuterJoin1 AS 
SELECT E.Emp_ID , E.First_Name  , R.Name FROM EMPLOYEE AS E 
LEFT OUTER JOIN 
RESTAURANT AS R ON E.Res_ID = R.Res_ID; 

SELECT * FROM UV_LEFTOuterJoin1;

CREATE VIEW UV_RIGHTOuterJoin1 AS 
SELECT E.Emp_ID , E.First_Name , R.Name FROM EMPLOYEE AS E 
RIGHT OUTER JOIN 
RESTAURANT AS R ON E.Res_ID = R.Res_ID; 

SELECT * FROM UV_RIGHTOuterJoin1;

(SELECT * FROM UV_LEFTOuterJoin1) 	UNION (SELECT * FROM UV_RIGHTOuterJoin1) ;


-- Outer Union
CREATE VIEW UV_Outer_Union AS 
(SELECT E.First_Name , E.Phone_No  FROM EMPLOYEE AS E )
UNION ALL
(SELECT C.Cus_Name , C.Phone_No  FROM CUSTOMER AS C );

SELECT * FROM UV_Outer_Union;

-- Nested Queries

SELECT F.Item_Name , F.Description, F.Price FROM FOOD_ITEM AS F WHERE F.Price > 1500
AND  F.Order_ID IN
	(SELECT O.Order_ID FROM _ORDER_ AS O WHERE O.Total > 3000 );
    

SELECT E.Emp_ID , E.First_Name , E.Salary , E.Pay_Day ,E.Phone_No FROM EMPLOYEE AS E WHERE SALARY > 
ALL
	(SELECT E.Salary FROM EMPLOYEE AS E WHERE Emp_ID in ( 2,3)) 
ORDER BY  SALARY DESC ;

SELECT E.Emp_ID , E.First_Name, E.Manager_ID FROM EMPLOYEE AS E where E.Manager_ID
IN
	(SELECT E.Manager_ID  FROM EMPLOYEE AS E) ;







