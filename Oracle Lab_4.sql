
DROP TABLE salesman CASCADE CONSTRAINTS;
DROP TABLE customer CASCADE CONSTRAINTS;
DROP TABLE orders CASCADE CONSTRAINTS;

CREATE TABLE salesman (
    salesman_id number(20),
    salesman_name varchar(20),
    city varchar(30),
    commission number(5,2),
    PRIMARY KEY (salesman_id)
);

CREATE TABLE customer (
    customer_id number(20),
    customer_name varchar(50),
    city varchar(30),
    grade number(1),
    salesman_id number(20),
    PRIMARY KEY (customer_id)
);

CREATE TABLE orders (
    order_id number(20),
    order_date date,
    customer_id number(20),
    purchase_amt number(12,2),
    salesman_id number(20),
    PRIMARY KEY (order_id),
    FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

INSERT INTO salesman VALUES (2021001, 'Amity', 'Gurgaon', 50.00);
INSERT INTO salesman VALUES (2021002, 'ZONATH', 'Gurgaon', 68.89);
INSERT INTO salesman VALUES (2021003, 'PSB', 'Paris', 10.11);
INSERT INTO salesman VALUES (2021004, 'SYMBI', 'Delhi', 70.11);
INSERT INTO salesman VALUES (2021005, 'Tookivi', 'Warsaw', 0.01);
INSERT INTO salesman VALUES (2021006, 'Tookivi_2', 'Warsaw', 12);

INSERT INTO customer VALUES (001, 'Ridheesh', 'Gurgaon', 2, 2021001);
INSERT INTO customer VALUES (002, 'Aryan', 'Delhi', 3, 2021003);
INSERT INTO customer VALUES (003, 'Prithvi', 'Haryana', 3, 2021002);
INSERT INTO customer VALUES (004, 'Aryaman', 'Haryana', 3, 2021004);
INSERT INTO customer VALUES (005, 'CoCo', 'Lucknow', 1, 2021005);
INSERT INTO customer VALUES (006, 'Tokivi', 'Lucknow', 1, 2021005);


INSERT INTO orders VALUES (20210101, '1/JAN/2021', 001, 1000.00, 2021001);
INSERT INTO orders VALUES (20210102, '2/JAN/2021', 002, 1200.00, 2021003);
INSERT INTO orders VALUES (202101003, '10/JAN/2021', 001, 982.93, 2021004);
INSERT INTO orders VALUES (202101004, '10/JAN/2021', 003, 1110.10, 2021002);
INSERT INTO orders VALUES (202101005, '12/JAN/2021', 003, 10230.90, 2021005);
INSERT INTO orders VALUES (202101006, '13/JAN/2021', 001, 10231.90, 2021005);

SELECT * FROM salesman;
SELECT * FROM customer;
SELECT * FROM orders;

/* Q1 */
SELECT * FROM orders WHERE purchase_amt >
    (SELECT  AVG(purchase_amt) FROM orders WHERE order_date ='10/JAN/2021');
 
/* Q2 */    
SELECT * FROM orders WHERE salesman_id =
    (SELECT DISTINCT salesman_id FROM orders WHERE customer_id = 002);
     
/* Q3 */    
SELECT a.customer_name FROM customer a, orders b WHERE a.customer_id = b.Customer_id AND b.order_date = '10/JAN/2021'; 

/* Q4 */
SELECT salesman_id, salesman_name  FROM salesman a WHERE 1 < 
    (SELECT COUNT(*) FROM customer WHERE salesman_id = a.salesman_id);

/* Q5 */
SELECT order_id  FROM orders a WHERE purchase_amt > 
    (SELECT AVG(purchase_amt) FROM orders WHERE customer_id = a.customer_id);

/* Q6 */
SELECT order_date, SUM (purchase_amt) FROM orders a GROUP BY order_date HAVING SUM (purchase_amt) >
    (SELECT 100 + MAX(purchase_amt) FROM orders b WHERE a.order_date = b.order_date);

/* Q7 */
SELECT * FROM customer WHERE EXISTS
   (SELECT * FROM customer WHERE city = 'Haryana');

/* Q8 */
SELECT * FROM salesman WHERE city = ANY
    (SELECT city FROM customer);

/* Q9 */
SELECT * FROM salesman a WHERE EXISTS
   (SELECT * FROM CUSTOMER b WHERE  a.salesman_name  < b.customer_name);

/* Q10 */
SELECT * FROM customer WHERE grade > ALL
   (SELECT grade FROM customer WHERE city = 'Gurgaon');

/* Q11 */
SELECT a.order_id, a.purchase_amt, b.customer_name, b.city FROM orders a,customer b WHERE 
    a.customer_id = b.customer_id AND a.purchase_amt BETWEEN 500 AND 2000;

/* Q13 */
SELECT a.customer_name, a.city, b.order_id, b.order_date, b.purchase_amt AS "Order Amount" 
FROM customer a LEFT OUTER JOIN orders b ON a.customer_id=b.customer_id ORDER BY b.order_date;

/* Q14 */
SELECT * FROM salesman a CROSS JOIN customer b;

/* Q15 */
SELECT * FROM orders ORDER BY order_date, purchase_amt DESC;
