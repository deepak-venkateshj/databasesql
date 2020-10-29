
--Name:Deepak Venkatesh J
--Student id:C0765163
--Project name:Slow cookers
--Project 3: Database Build Project
--Project 4: Database SQL Query Project

DROP TABLE tp_cooker;
DROP TABLE tp_order;
DROP TABLE tp_cooker_order;
DROP TABLE tp_customer;
DROP TABLE tp_customer_cooker;
DROP TABLE tp_warehouse;
DROP TABLE tp_cooker_warehouse;
DROP TABLE tp_associate;

CREATE TABLE tp_cooker(
brand_id INTEGER,
product_serialnumber VARCHAR(30),
family_color VARCHAR(20),
cooker_type VARCHAR(40),
capacity VARCHAR(20),
price DECIMAL(10)
);

ALTER TABLE tp_cooker
ADD CONSTRAINT tp_cooker_brand_id_pk
PRIMARY KEY(brand_id);

--Constraint Testing 1 for Primary key

--INSERT INTO tp_cooker
--values('202','AB201','SILVER','MANUAL','3L',200.50),
 --     ('202','AB202','SILVER','DIGITAL','4L',201.50);
    
--Query execution failed
--Reason:
--SQL Error [23505]: [SQL0803] Duplicate key value specified.   

--Creating unique key constraints
ALTER TABLE TP_COOKER
ADD CONSTRAINT TP_customer_product_serialnumber_uk
UNIQUE(product_serialnumber);


--Assigning a default value before actual value is updated
ALTER TABLE TP_COOKER
ALTER price SET DEFAULT 00000;

--Assigning a default value before actual value is updated
ALTER TABLE TP_COOKER
ALTER PRODUCT_SERIALNUMBER SET DEFAULT 'AB000';

--Adding Check constraints
ALTER TABLE TP_COOKER
ADD CONSTRAINT TP_COOKER_cooker_type_CK
CHECK(cooker_type IN('MANUAL','DIGITAL','ANALOG'));

--Constriant Testing 6 on Check constriants
--INSERT INTO tp_cooker
--values('201','AB201','SILVER','ABCDER','3L',200.50);
      
--SQL Error [23513]: [SQL0545] INSERT, UPDATE, or MERGE not allowed by CHECK constraint.

ALTER TABLE TP_COOKER
ADD CONSTRAINT TP_COOKER_PRICE_CK
CHECK(PRICE BETWEEN 1 AND 1000);

--Constriant Testing 7 on Check constriants
--INSERT INTO tp_cooker
--values('210','AB210','GREEN','ANALOG','6L',4305.50);

--Boundary Value testing:
--INSERT INTO tp_cooker
--values('201','AB201','SILVER','MANUAL','3L',0);

--SQL Error [23513]: [SQL0545] INSERT, UPDATE, or MERGE not allowed by CHECK constraint.

INSERT INTO tp_cooker
values('201','AB201','SILVER','MANUAL','3L',200.50),
      ('202','AB202','SILVER','DIGITAL','4L',201.50),
      ('203','AB203','GREY','MANUAL','2L',220.50),
      ('204','AB204','RED','MANUAL','6L',230.50),
      ('205','AB205','SILVER','DIGITAL','6L',240.50),
      ('206','AB206','RED','MANUAL','5L',225.50),
      ('207','AB207','MAROON','DIGITAL','6L',230.50),
      ('208','AB208','RED','ANALOG','5L',350.50),
      ('209','AB209','WHITE','DIGITAL','6.5L',280.50),
      ('210','AB210','GREEN','ANALOG','6L',430.50);
            
-- Creating Default values for tp_cooker


CREATE TABLE tp_order(
order_id INTEGER NOT NULL,
order_date date,
brand_id INTEGER NOT NULL
  );

--Creating Primary key constraints
ALTER TABLE tp_order
ADD CONSTRAINT tp_order_order_id_pk
PRIMARY KEY(order_id);

--Creating Foreign key constraints
ALTER TABLE tp_order
ADD CONSTRAINT tp_order_brand_id_fk
FOREIGN KEY(brand_id)
REFERENCES tp_cooker(brand_id);

--Constraint Testing 2 for foreign key
--INSERT INTO tp_order
--VALUES('5001','2018-03-05','250'),
--      ('5002','2018-04-05','201');

--Query execution failed

--Reason:
--SQL Error [23503]: [SQL0530] Operation not allowed by referential constraint TP_ORDER_BRAND_ID_FK in IBM7916.

--Adding Check constraints
ALTER TABLE TP_ORDER
ADD CONSTRAINT TP_ORDER_ORDER_ID_CK
CHECK(ORDER_ID BETWEEN 1000 AND 99999);

--Constriant Testing 8 on Check constriants
--INSERT INTO tp_order
--VALUES('999','2018-03-05','201');

--INSERT INTO tp_order
--VALUES('100000','2018-03-05','202');

--SQL Error [23513]: [SQL0545] INSERT, UPDATE, or MERGE not allowed by CHECK constraint.

INSERT INTO tp_order
VALUES('5001','2018-03-05','201'),
      ('5002','2018-04-05','202'),
      ('5003','2018-05-05','203'),
      ('5004','2018-06-05','204'),
      ('5005','2018-07-05','205'),
      ('5006','2018-08-05','201'),
      ('5007','2018-09-05','205'),
      ('5008','2018-10-05','208'),
      ('5009','2018-11-05','204'),
      ('5010','2018-12-05','209');   


CREATE TABLE tp_cooker_order(
order_id INTEGER NOT NULL,
brand_id INTEGER NOT NULL
);

--Creating Primary key constraint
ALTER TABLE tp_cooker_order
ADD CONSTRAINT tp_cooker_order_order_id_brand_id_pk
PRIMARY KEY(order_id,brand_id);

--Creating Foreign key constraints
ALTER TABLE tp_cooker_order
ADD CONSTRAINT tp_cooker_order_order_id_fk
FOREIGN KEY(order_id)
REFERENCES tp_order(order_id);

--Creating Foreign key constraints
ALTER TABLE tp_cooker_order
ADD CONSTRAINT tp_cooker_order_brand_id_fk
FOREIGN KEY(brand_id)
REFERENCES tp_cooker(brand_id);

INSERT INTO tp_cooker_order
VALUES('5001','201'),
 ('5002','203'),
 ('5001','204'),
 ('5003','204'),
 ('5002','205'),
 ('5002','210'),
 ('5003','206'),
 ('5004','207'),
 ('5004','205'),
 ('5005','203'),
 ('5006','201'),
 ('5006','208'),
 ('5007','201'),
 ('5007','202'),
 ('5008','206'),
 ('5008','210'),
 ('5009','209'),
 ('5009','208'),
 ('5010','209'),
 ('5010','202');

CREATE TABLE tp_customer(
customer_id INTEGER NOT NULL,
customer_name VARCHAR(20),
phone_number VARCHAR(20),
customer_email VARCHAR(40),
sin_no DECIMAL(15,0),
brand_id INTEGER NOT NULL,
NUM_ORDERS INTEGER,
order_id INTEGER NOT NULL
 );

 --Creating primary key constraints
ALTER TABLE tp_customer
ADD CONSTRAINT tp_customer_customer_id_pk
PRIMARY KEY(customer_id);

--Constraint Testing 3 for primary key
--INSERT INTO tp_customer
--values('1001','Shane','2643541356','shane264@gmail.com','74395849584','201','5001'),
--      ('1001','Ben Morphet','2654441356','ben264@gmail.com','743958545484','204','5003');

--SQL Error [23503]: [SQL0530] Operation not allowed by referential constraint TP_ORDER_BRAND_ID_FK in IBM7916.

--Creating Foreign key constraints
ALTER TABLE tp_customer
ADD CONSTRAINT tp_customer_brand_id_FK
FOREIGN KEY(brand_id)
REFERENCES tp_cooker(brand_id);

--Creating Foreign key constraints
ALTER TABLE tp_customer
ADD CONSTRAINT tp_customer_order_id_FK
FOREIGN KEY(order_id)
REFERENCES tp_order(order_id);

--Creating unique key constraints

ALTER TABLE TP_CUSTOMER
ADD CONSTRAINT TP_CUSTOMER_sin_no_uk
UNIQUE(sin_no);

--Adding Check constraints
ALTER TABLE TP_CUSTOMER
ADD CONSTRAINT TP_CUSTOMER_PHONE_NUMBER_CK
CHECK(PHONE_NUMBER BETWEEN 1111111111 AND 9999999999);

--Constraint Testing 09:
--INSERT INTO tp_customer
--values('1001','Shane','123456789','shane264@gmail.com','74395849584','201','5001');

--INSERT INTO tp_customer
--values('1001','Shane','99999999991','shane264@gmail.com','74395849584','201','5001');

--SQL Error [23513]: [SQL0545] INSERT, UPDATE, or MERGE not allowed by CHECK constraint.

ALTER TABLE TP_CUSTOMER
ADD CONSTRAINT TP_CUSTOMER_CUSTOMER_ID_NO_CK
CHECK(customer_id BETWEEN 1000 AND 10000);

--Constraint Testing 10:

--INSERT INTO tp_customer
--values('999','Shane','2643541356','shane264@gmail.com','74395849584','201','5001');

--INSERT INTO tp_customer
--values('10001','Shane','2643541356','shane264@gmail.com','74395849584','201','5001');

--SQL Error [23513]: [SQL0545] INSERT, UPDATE, or MERGE not allowed by CHECK constraint.

INSERT INTO tp_customer
values('1001','Shane','2643541356','shane264@gmail.com','74395849584','201','12','5001'),
('1002','Ben Morphet','2654441356','ben264@gmail.com','743958545484','204','07','5003'),
('1003','Hurricane','4345541356','hurricane264@gmail.com','8433459584','208','03','5006'),
('1004','Roger','4783541356','roger264@gmail.com','98795849584','208','01','5009'),
('1005','Mendes','5643541356','mentes264@gmail.com','54395849584','203','04','5005');


CREATE TABLE tp_customer_cooker(
customer_id INTEGER NOT NULL,
brand_id INTEGER NOT NULL
);

--Creating primary key constraints
ALTER TABLE tp_customer_cooker
ADD CONSTRAINT tp_customer_cooker_customer_id_brand_id_pk
PRIMARY key(customer_id,brand_id);

--Creating Foreign key constraints
ALTER TABLE tp_customer_cooker
ADD CONSTRAINT tp_customer_cooker_customer_id_FK
FOREIGN KEY(customer_id)
REFERENCES tp_customer(customer_id);

--Creating Foreign key constraints
ALTER TABLE tp_customer_cooker
ADD CONSTRAINT tp_customer_cooker_brand_id_FK
FOREIGN KEY(brand_id)
REFERENCES tp_cooker(brand_id);



INSERT INTO tp_customer_cooker
values('1001','201'),
('1002','202'),
('1003','203'),
('1001','204'),
('1004','205'),
('1005','210');

CREATE TABLE tp_warehouse(
warehouse_id   INTEGER NOT NULL,
region_id VARCHAR(30),
country VARCHAR(30)
);

--Creating primary key constraints
ALTER TABLE tp_warehouse
ADD CONSTRAINT tp_warehouse_warehouse_id__pk
PRIMARY key(warehouse_id);

--Assigning a default value before actual value is updated
ALTER TABLE TP_WAREHOUSE
ALTER region_id SET DEFAULT 'C001';

--Assigning a default value before actual value is updated
ALTER TABLE TP_WAREHOUSE
ALTER country SET DEFAULT 'CANADA';

--Constraint Testing 11:
--INSERT INTO tp_warehouse(warehouse_id)
--VALUES('10001');


INSERT INTO tp_warehouse
values('10001','C001','CANADA'),
('10002','A001','CANADA'),
('10003','D002','CANADA'),
('10004','Z001','UNITED KINGDOM'),
('10007','S746','SINGAPORE');


CREATE TABLE tp_cooker_warehouse(
brand_id INTEGER NOT NULL,
warehouse_id   INTEGER NOT NULL,
pending_stocks integer NOT NULL
);

--Creating primary key constraints

ALTER TABLE tp_cooker_warehouse
ADD CONSTRAINT tp_cooker_warehouse_brand_id_warehouse_id_pk
PRIMARY key(brand_id,warehouse_id);

--Creating foreign key constraints
ALTER TABLE tp_cooker_warehouse
ADD CONSTRAINT tp_cooker_warehouse_brand_id_FK
FOREIGN KEY(brand_id)
REFERENCES tp_cooker(brand_id);

--Creating foreign key constraints
ALTER TABLE tp_cooker_warehouse
ADD CONSTRAINT tp_cooker_warehouse_warehouse_id_FK
FOREIGN KEY(warehouse_id)
REFERENCES tp_warehouse(warehouse_id);

INSERT INTO TP_COOKER_WAREHOUSE
VALUES('201','10001','278'),
('202','10001','534'),
('203','10003','876'),
('204','10007','130'),
('209','10002','45'),
('208','10004','224'),
('208','10003','651');


CREATE TABLE tp_associate(
associate_id INTEGER NOT NULL,
associate_name VARCHAR(30),
phone_number DECIMAL(10,0),
Email_id VARCHAR(30),
sin_no INTEGER,
warehouse_id   INTEGER NOT NULL
);

--Creating primary key constraints
ALTER TABLE tp_associate
ADD CONSTRAINT tp_associate_associate_id_pk
PRIMARY key(associate_id);

--Creating foreign key constraints
ALTER TABLE tp_associate
ADD CONSTRAINT tp_associate_warehouse_id_FK
FOREIGN KEY(warehouse_id)
REFERENCES tp_warehouse(warehouse_id);

--Constraint Testing 4 for foreign key
--INSERT INTO TP_ASSOCIATE
--VALUES('50001','Eva Mendes','6439010434','eva6487@gmail.com','346854945','10010'),
--('50002','Dawn Johson','6445001434','dwan6487@gmail.com','346834945','10002');

--SQL Error [23503]: [SQL0530] Operation not allowed by referential constraint TP_ASSOCIATE_WAREHOUSE_ID_FK in IBM7916.

--Creating unique key constraints
ALTER TABLE TP_ASSOCIATE
ADD CONSTRAINT TP_ASSOCIATE_sin_no_uk
UNIQUE(sin_no);

--Constraint Testing 5 for unique key

--INSERT INTO TP_ASSOCIATE
--VALUES('50001','Eva Mendes','6439010434','eva6487@gmail.com','1234567891','10001'),
--('50002','Dawn Johson','6445001434','dwan6487@gmail.com','1234567891','10002');

--Adding Check constraints
ALTER TABLE TP_ASSOCIATE
ADD CONSTRAINT TP_ASSOCIATE_PHONE_NUMBER_CK
CHECK(PHONE_NUMBER BETWEEN 1111111111 AND 9999999999);


--Constraint Testing 12:

--INSERT INTO TP_ASSOCIATE
--VALUES('50001','Eva Mendes','123456789','eva6487@gmail.com','346854945','10001');

--SQL Error [23513]: [SQL0545] INSERT, UPDATE, or MERGE not allowed by CHECK constraint.
--INSERT INTO TP_ASSOCIATE
--VALUES('50001','Eva Mendes','99999999990','eva6487@gmail.com','346854945','10001');

--SQL Error [22023]: [SQL0406] Conversion error on assignment to column PHONE_NUMBER.




INSERT INTO TP_ASSOCIATE
VALUES('50001','Eva Mendes','6439010434','eva6487@gmail.com','346854945','10001'),
('50002','Dawn Johson','6445001434','dwan6487@gmail.com','346834945','10002'),
('50003','Stuart Broad','7849410434','stuart6487@gmail.com','156854945','10003'),
('50004','Care Johnston','7899110434','care6487@gmail.com','154854945','10004'),
('50005','Ellis Johath','2339010434','ellisjohat@gmail.com','123854945','10001'),
('50006','David','7561910434','david6487@gmail.com','784554945','10002');


--P4 SQL Query 1


CREATE OR replace VIEW prodv1 AS 
SELECT brand_id,cooker_type ||' '||'Cooker'||' '||capacity AS description,pending_stocks AS Stocks_Onhand,price
FROM TP_COOKER
JOIN TP_COOKER_WAREHOUSE using(brand_id);

SELECT * FROM PRODV1;

--P4 SQL Query 2
CREATE OR replace VIEW prodv2 AS 
SELECT cus.customer_name,odr.order_date,odr.order_id,odr.brand_id,ckr.cooker_type ||' '||'Cooker'||' '||ckr.capacity AS description,cus.num_orders AS quantity_orderd,ckr.PRICE
FROM tp_customer cus
JOIN TP_ORDER odr
ON cus.BRAND_ID=odr.BRAND_ID
JOIN TP_COOKER ckr
ON ckr.BRAND_ID=odr.BRAND_ID;


SELECT * FROM prodv2;


SELECT * FROM TP_COOKER;
SELECT * FROM TP_ORDER;
SELECT * FROM TP_COOKER_ORDER;
SELECT * FROM TP_CUSTOMER;
SELECT * FROM TP_CUSTOMER_COOKER;
SELECT * FROM TP_WAREHOUSE;
SELECT * FROM TP_COOKER;
SELECT * FROM TP_COOKER_WAREHOUSE;
SELECT * FROM TP_ASSOCIATE;

