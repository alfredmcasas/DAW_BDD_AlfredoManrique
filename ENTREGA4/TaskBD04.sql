SELECT productName, buyPrice, quantityInStock
FROM products
ORDER BY buyPrice desc
Limit 1;

SELECT customerName
FROM customers
WHERE 
(addressLine1 LIKE "%Lane%" OR addressLine1 LIKE "%Ln.%") 
AND creditLimit > 80000;


SELECT p.productCode, productName, quantityOrdered
FROM products p
JOIN orderdetails od on p.productCode = od.productCode
WHERE quantityOrdered > 50
ORDER BY quantityOrdered desc;


SELECT customerName,c.customerNumber,amount
FROM customers c 
JOIN payments p on c.customerNumber = p.customerNumber
WHERE YEAR(paymentDate) = 2005 AND amount > 100000;


SELECT customerName, paymentDate
FROM customers c 
JOIN payments p on c.customerNumber = p.customerNumber
JOIN employees e on c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices o on e.officeCode = o.officeCode
WHERE o.city = "San Francisco";


SELECT customerName, c.customerNumber
FROM customers c 
JOIN payments p on c.customerNumber = p.customerNumber
where paymentDate = "2004-11-15"  
OR paymentDate = "2004-11-17" ;


SELECT *
FROM products p
JOIN productlines pl on p.productLine = pl.productLine
WHERE p.productDescription LIKE "%tires%"
AND pl.textDescription LIKE "%Vintage%";



SELECT o.addressLine1 as department, firstName, employeeNumber
FROM employees e
JOIN offices o on e.officeCode = o.officeCode
WHERE employeeNumber NOT IN (SELECT salesRepEmployeeNumber from customers where salesRepEmployeeNumber IS NOT NULL)
AND o.country = "Japan";

SELECT e.*
FROM employees e
JOIN offices o ON o.officeCode = e.officeCode
WHERE o.officeCode = 6
AND NOT EXISTS (
  SELECT *
  FROM customers c
  JOIN payments p ON p.customerNumber = c.customerNumber
  WHERE c.salesRepEmployeeNumber = e.employeeNumber
);

SELECT o.officeCode as department, COUNT(*) as n_employees
FROM offices o
LEFT JOIN employees e on o.officeCode = e.officeCode
GROUP BY o.officeCode
Order by n_employees desc;

SELECT MONTH(requiredDate) as _month,COUNT(*) as n_orders
from orders
group by MONTH(requiredDate);

SELECT DISTINCT employeeNumber, firstName, lastName
FROM employees e
JOIN customers c on e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments p on c.customerNumber = p.customerNumber
WHERE amount > 100000
order by employeeNumber desc;

SELECT e.*
FROM employees e
JOIN offices o 
    ON e.officeCode = o.officeCode
WHERE o.country = 'USA'
AND NOT EXISTS (
    SELECT 1
    FROM customers c
    WHERE c.salesRepEmployeeNumber = e.employeeNumber
);

SELECT orderNumber,customerNumber,
TIMESTAMPDIFF(YEAR, orderDate, CURDATE()) AS antiquity
FROM orders;

SELECT count(*) as n_payments, max(amount) as max_payment, min(amount) as min_payment
from payments;

SELECT employeeNumber,firstName,lastName, COUNT( DISTINCT c.customerNumber) as n_customers_under_3000
FROM employees e 
JOIN customers c on e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments p on c.customerNumber = p.customerNumber
WHERE amount < 3000
GROUP BY e.employeeNumber, e.firstName, e.lastName;

SELECT checkNumber,amount, CASE
WHEN amount < 15000 THEN "Low Payment"
WHEN amount <= 50000 THEN "Medium Payment"
ELSE "Very high payment"
END as classification
FROM payments p
JOIN customers c on p.customerNumber = c.customerNumber
JOIN employees e on c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices o on o.officeCode = e.officeCode
WHERE o.city = "NYC";

SELECT city as branch_name, firstName, lastName
FROM employees e
JOIN offices o on e.officeCode = o.officeCode
order by branch_name, lastName;

SELECT DISTINCT o.city AS office_name
FROM offices o
JOIN employees e ON o.officeCode = e.officeCode
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders ord  ON c.customerNumber = ord.customerNumber
WHERE c.customerName = 'Atelier graphique';

SELECT e.firstName,e.lastName,e.jobTitle,
CONCAT(b.firstName, ' ', b.lastName) AS boss_name
FROM employees e
LEFT JOIN employees b ON e.reportsTo = b.employeeNumber
WHERE e.jobTitle <> 'Sales Rep';

SELECT o.city AS office_name,
COALESCE(SUM(od.quantityOrdered * od.priceEach), 0) AS total_order_amount
FROM offices o
LEFT JOIN employees e ON e.officeCode = o.officeCode
LEFT JOIN customers c ON c.salesRepEmployeeNumber = e.employeeNumber
LEFT JOIN orders ord ON ord.customerNumber = c.customerNumber
LEFT JOIN orderdetails od ON od.orderNumber = ord.orderNumber
GROUP BY o.officeCode, o.city
ORDER BY total_order_amount DESC;

SELECT DISTINCT c.customerName,e.firstName AS employeeFirstName,
e.lastName  AS employeeLastName
FROM customers c
JOIN employees e ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders o ON o.customerNumber = c.customerNumber
JOIN orderdetails od ON od.orderNumber = o.orderNumber
JOIN products p ON p.productCode = od.productCode
WHERE c.country = 'Japan'
AND p.productLine = 'Classic Cars'
ORDER BY c.customerName, e.lastName, e.firstName;

SELECT DISTINCT o.city AS office_city
FROM offices o
JOIN employees e ON e.officeCode = o.officeCode
WHERE e.employeeNumber IN (
    SELECT salesRepEmployeeNumber
    FROM customers
    GROUP BY salesRepEmployeeNumber
    HAVING COUNT(*) >= 5
);


SELECT o.city AS office_city,ord.status,
COUNT(DISTINCT c.customerNumber) AS n_customers
FROM offices o
JOIN employees e ON e.officeCode = o.officeCode
JOIN customers c ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN orders ord ON ord.customerNumber = c.customerNumber
GROUP BY o.city, ord.status
ORDER BY o.city, ord.status;




















