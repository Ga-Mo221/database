-- xem du lieu trong table
select * from customers;

-- xem du lieu o dieu kien loc
select * from customers
where state = "CA" and city = "San Francisco";


select * from payments
where amount > 32000 and year(paymentDate) = '2003' and month(paymentDate) = '01';