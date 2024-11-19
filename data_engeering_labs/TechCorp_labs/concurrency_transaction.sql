show databases;
use techcorp;
select *from products;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

-- Transaction 1 (Alex's Order)
START TRANSACTION;

UPDATE products
SET StockQuantity = StockQuantity - 5
WHERE ProductID = 101 ;

COMMIT;
select * from products;
-- Transaction 2 (Taylor's Order)
START TRANSACTION;

UPDATE products
SET StockQuantity = StockQuantity - 5
WHERE ProductID = 101;

COMMIT;
select * from products;

START TRANSACTION;

UPDATE products
SET StockQuantity = StockQuantity - 5
WHERE ProductID = 103;

COMMIT;
select * from products;

