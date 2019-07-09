--1
select productid, name, city, ROW_NUMBER () OVER (ORDER BY city) as rn
from Products;


--2
select productid, name, city, ROW_NUMBER () OVER (PARTITION BY city ORDER BY city) as rn
from Products;


--3
SELECT *
FROM 
(
select productid, name, city, ROW_NUMBER () OVER (PARTITION BY city ORDER BY city) as rn
from Products
) as p
WHERE rn = 1;


--4
select productid, detailid, quantity, 
       sum(quantity) over (partition by productid) as all_quantity_product, 
       sum(quantity) over (partition by detailid) as all_quantity_detail
from Supplies
order by productid, detailid ;

--5
SELECT *
FROM (
select supplierid, productid, detailid,  
       ROW_NUMBER () OVER (ORDER BY supplierid) as rn,
	   count(*) OVER () as total_rows
from Supplies
) s
WHERE rn between 10 and 15;


--6
SELECT *
FROM 
(
select supplierid, detailid,  productid, quantity,
       avg(quantity) over (partition by supplierid order by supplierid) as avg_sup        
from Supplies
) s
WHERE quantity < avg_sup;