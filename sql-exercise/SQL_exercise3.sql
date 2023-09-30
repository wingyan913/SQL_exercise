USE sys;
CREATE DATABASE exercise3;
USE exercise3;

-- Question 1a: create tables, with PK and FK specified
CREATE TABLE product (
	id INTEGER PRIMARY KEY,
    sku VARCHAR(32),
    product_name VARCHAR(128),
    product_description TEXT,
    current_price DECIMAL(8, 2),
    quantity_in_stock INTEGER
    );
    
CREATE TABLE customer (
	id INTEGER PRIMARY KEY,
    customer_name VARCHAR(255),
    city_id INTEGER, -- skipped to set as a foreign key
    customer_address VARCHAR(255),
    contact_person VARCHAR(255),
    email VARCHAR(128),
    phone VARCHAR(128)
    );
    
CREATE TABLE invoice (
	id INTEGER PRIMARY KEY,
    invoice_number VARCHAR(255),
    customer_id INTEGER,
    user_account_id INTEGER,
    total_price DECIMAL(8, 2),
    time_issued VARCHAR(25),
    time_due VARCHAR(25),
    time_paid VARCHAR(25),
    time_canceled VARCHAR(25),
    time_refunded VARCHAR(25),
    FOREIGN KEY(customer_id) REFERENCES customer(id)
);

CREATE TABLE invoice_item (
	id INTEGER PRIMARY KEY,
    invoice_id INTEGER,
    product_id INTEGER,
    quantity INTEGER,
    price DECIMAL(8, 2),
    line_total_price DECIMAL(8, 2),
    FOREIGN KEY(invoice_id) REFERENCES invoice(id),
    FOREIGN KEY(product_id) REFERENCES product(id)
);

-- Question 1b: insert sample data to all of the created tables
INSERT INTO CUSTOMER 
	(ID, CUSTOMER_NAME, CITY_ID, CUSTOMER_ADDRESS, CONTACT_PERSON, EMAIL, PHONE) VALUES
	(1, 'Drogerie Wien', 1, 'Deckergasse 15A', 'Emil Steinbach', 'emil@drogeriewien.com', '094234234'),
    (2, 'Cosmetics Store', 4, 'Watling Street 347', 'Jeremy Corbyn', 'jeremy@c-store.org', '093923923'),
    (3, 'Kosmetikstudio', 3, 'Rothenbaumachaussee 53', 'Willy Brandt', 'willy@kosmetikstudio.com', '0941562222'),
    (4, 'Neue Kosmetik', 1, 'Karlsplatz 2', NULL, 'info@neuekosmetik.com', '094109253'),
    (5, 'Bio Kosmetik', 2, 'MotzstraBe 23', 'Clara Zetkin', 'clara@biokosmetik.org', '093825825'),
    (6, 'K-Wien', 1, 'Karntner StraBe 204', 'Maria Rauch-Kallat', 'maria@kwien.org', '093427002'),
    (7, 'Natural Cosmetics', 4, 'Clerkenwell Road 14B', 'Glenda Jackson', 'giena.j@natural-cosmetics.com', '093555123'),
    (8, 'Kosmetik Plus', 2, 'Unter den Linden 1', 'Angela Merkel', 'angela@k-plus.com', '094727727'),
    (9, 'New Line Cosmetics', 4, 'Devonshire Street 92', 'Oliver Cromwell', 'oliver@nic.org', '093202404');

INSERT INTO PRODUCT
	(ID, SKU, PRODUCT_NAME, PRODUCT_DESCRIPTION, CURRENT_PRICE, QUANTITY_IN_STOCK) VALUES
    (1, '330120', 'Game Of Thrones - URBAN DECAY', 'Grame Of Thrones Eyeshadow Palette', 65.00, 122),
    (2, '330121', 'Advanced Night Repair-ESTEE LAUDER', 'Advanced Night Repair Synchronized Recovery Complex II', 98.00, 51),
    (3, '330122', 'Rose Deep Hydration - FRESH', 'Rose Deep Hydration Facial Toner', 45.00, 34),
    (4, '330123', 'Pore-Perfecting Moisturizer - TATCHA', 'Pore-Perfecting Moisturizer & Cleanser Duo', 25.00, 393),
    (5, '330124', 'Capture Youth - DIOR', 'Capture Youth Serum Collection', 95.00, 74),
    (6, '330125', 'Slice of Glow - GLOW RECIPE', 'Slice of Glow Set', 45.00, 40), 
    (7, '330126', 'Healthy Skin - KIEHL S SINCE 1851', 'Healthy Skin Squad', 68.00, 154),
    (8, '330127', 'Power Pair! - IT COSMETIC', 'IT is Your Skincare Power Pair! Best-Selling Moisturizer & Eye Cream Duo', 80.00, 0),
    (9, '330128', 'Dewy Skin Mist - TATCHA', 'Limited Edition Dewy Skin Mist Mini', 20.00, 281),
    (10, '330129', 'Slik Pillowcase - SLIP', 'Silk Pillowcase Duo + Scrunchies Kit', 170.00, 0);

INSERT INTO INVOICE
	(ID, INVOICE_NUMBER, CUSTOMER_ID, USER_ACCOUNT_ID, TOTAL_PRICE, TIME_ISSUED, TIME_DUE, TIME_PAID, TIME_CANCELED, TIME_REFUNDED) VALUES
    (1, 'in_25181b07ba800c8d2fc967fe991807d9', 7, 4, 1436.00, '7/20/2019 3:05:07 PM', '7/27/2019 3:05:07 PM', '7/25/2019 9:24:12 AM', NULL, NULL),
    (2, 'in_25181b07ba800c8d2fc967fe991807d9', 9, 2, 1000.00, '7/20/2019 3:07:11 PM', '7/27/2019 3:07:11 PM', '7/20/2019 3:10:32 PM', NULL, NULL),
    (3, 'in_25181b07ba800c8d2fc967fe991807d9', 3, 2, 360.00, '7/20/2019 3:06:15 PM', '7/27/2019 3:06:15 PM', '7/31/2019 9:22:11 PM', NULL, NULL),
    (4, 'in_25181b07ba800c8d2fc967fe991807d9', 5, 2, 1675.00, '7/20/2019 3:05:34 PM', '7/27/2019 3:05:34 PM', NULL, NULL, NULL),
    (5, 'in_25181b07ba800c8d2fc967fe991807d9', 6, 2, 9500.00, '7/20/2019 3:05:42 PM', '7/27/2019 3:05:42 PM', NULL, '7/22/2019 11:17:02 AM', NULL),
    (6, 'in_25181b07ba800c8d2fc967fe991807d9', 4, 2, 150.00, '7/20/2019 3:08:15 PM', '7/27/2019 3:08:15 PM', '7/27/2019 3:08:15 PM', NULL, '7/27/2019 2:11:20 PM');

INSERT INTO INVOICE_ITEM
	(ID, INVOICE_ID, PRODUCT_ID, QUANTITY, PRICE, LINE_TOTAL_PRICE) VALUES
    (1, 1, 1, 20, 65.00, 1300.00),
    (2, 1, 7, 2, 68.00, 136.00),
    (3, 1, 5, 10, 100.00, 1000.00),
    (4, 3, 10, 2, 180.00, 360.00),
    (5, 4, 1, 5, 65.00, 325.00),
    (6, 4, 2, 10, 95.00, 950.00),
    (7, 4, 5, 4, 100.00, 400.00),
    (8, 5, 10, 100, 95.00, 9500.00),
    (9, 6, 4, 6, 25.00, 150.00);

-- Question 1c: List Customer and Product Without Sale
with NOTSOLD as (
	select id, product_name
	from product
	where quantity_in_stock <> 0
),
NOINVOICE as (
select c.id, c.customer_name
from customer c
where not exists (
    select *
    from invoice i
    where c.id = i.customer_id
))
select id, customer_name as name from NOINVOICE
union
select id, product_name as name from NOTSOLD;

select * from CUSTOMER;
select * from PRODUCT;
select * from INVOICE;
select * from INVOICE_ITEM;

-- Question 2
CREATE TABLE EMPLOYEE (
	ID INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    EMPLOYEE_NAME VARCHAR(30) NOT NULL,
    SALARY NUMERIC(8,2),
	PHONE NUMERIC(15),
	EMAIL VARCHAR(50),
	DEPT_ID INTEGER NOT NULL
);

CREATE TABLE DEPARTMENT (
	ID INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    DEPT_CODE VARCHAR(3) NOT NULL,
    DEPT_NAME VARCHAR(200) NOT NULL
);

DELETE FROM EMPLOYEE;
INSERT INTO EMPLOYEE VALUES (1, 'JOHN', 20000, 90234567, 'JOHN@GMAIL.COM', 1);
INSERT INTO EMPLOYEE VALUES (2, 'MARY', 10000, 90234561, 'MARY@GMAIL.COM', 1);
INSERT INTO EMPLOYEE VALUES (3, 'STEVE', 30000, 90234562, 'STEVE@GMAIL.COM', 3);
INSERT INTO EMPLOYEE VALUES (4, 'SUNNY', 40000, 90234563, 'SUNNY@GMAIL.COM', 4);

DELETE FROM DEPARTMENT;
INSERT INTO DEPARTMENT VALUES (1, 'HR', 'HUMAN RESOURCES');
INSERT INTO DEPARTMENT VALUES (2, '9UP', '9UP DEPARTMENT');
INSERT INTO DEPARTMENT VALUES (3, 'SA', 'SALES DEPARTMENT');
INSERT INTO DEPARTMENT VALUES (4, 'IT', 'INFORMATION TECHNOLOGY DEPARTMENT');

SELECT d.DEPT_CODE, COUNT(e.ID) AS COUNT
FROM DEPARTMENT d LEFT JOIN EMPLOYEE e
ON e.DEPT_ID = d.ID
GROUP BY d.DEPT_CODE
ORDER BY COUNT DESC
;

