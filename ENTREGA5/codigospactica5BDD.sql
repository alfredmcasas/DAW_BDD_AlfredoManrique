
-- Ej.2
INSERT INTO payments
(`customerNumber`,
`checkNumber`,
`paymentDate`,
`amount`)
VALUES
(124,"H123","2024-02-06",845.00),
(151,"H124","2024-02-07",70.00),
(112,"H125","2024-02-05",1024.00);


-- Ej. 4

SET SQL_SAFE_UPDATES = 0;
UPDATE orders
SET status = 'Cancelled',
    shippedDate = CURRENT_DATE(),
    comments = 'Order cancelled due to delay'
WHERE orderDate = '2003-09-28';

-- ej 5
UPDATE products
SET productName = CONCAT(productName, ' (', productCode, ')')
WHERE productLine = 'Trains';

-- Ej 6
UPDATE products
SET buyPrice = buyPrice * 1.0002,
    MSRP = MSRP * 1.0002
WHERE quantityInStock > 500;

-- Ej 7
DELETE FROM payments
WHERE customerNumber IN (
    SELECT customerNumber
    FROM customers
    WHERE salesRepEmployeeNumber IN (
        SELECT employeeNumber
        FROM employees
        WHERE lastName = 'Patterson'
    )
);

-- EJ 8
DELETE FROM customers
WHERE city = 'Lisboa'
AND customerNumber NOT IN (
    SELECT customerNumber
    FROM payments
);

-- EJ 9
INSERT INTO employees 
(employeeNumber, lastName, firstName, extension, email, officeCode, jobTitle)
SELECT 
customerNumber + 2000,
contactLastName,
contactFirstName,
'x0000',
'new@company.com',
'1',
'Sales Rep'
FROM customers;

-- EJ 10
UPDATE orders
SET status = 'Cancelled',
    shippedDate = CURRENT_DATE(),
    comments = 'Order cancelled by management'
WHERE customerNumber IN (
    SELECT customerNumber
    FROM customers
    WHERE TRIM(contactFirstName) = 'Elizabeth'
      AND TRIM(contactLastName) = 'Lincoln'
);



