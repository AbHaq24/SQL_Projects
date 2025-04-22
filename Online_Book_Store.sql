CREATE DATABASE OnlineBookStore;

USE OnlineBookStore;


-- Creating Tables
DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
Book_ID	SERIAL	PRIMARY KEY,
Title	VARCHAR(100),	
Author	VARCHAR(100),	
Genre	VARCHAR(50),	
Published_Year	INT,	
Price	NUMERIC(10,2),	
Stock	INT
);


DROP TABLE IF EXISTS Customers;
CREATE TABLE Customers (
	Customer_ID	SERIAL	PRIMARY KEY,
Name	VARCHAR(100),	
Email	VARCHAR(100),	
Phone	VARCHAR(20),	
City	VARCHAR(50),	
Country	VARCHAR(50)
);	


DROP TABLE IF EXISTS orders;
CREATE TABLE Orders (
	Order_ID SERIAL primary KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Books_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
    );
    
SELECT * FROM orders;
SELECT * FROM customers;
select * FROM Books;

-- 1) Retrive all books in Fiction Genre

Select * FROM Books Where Genre ='Fiction';



-- 2) Finding books which are published after 1950

Select * from books where Published_Year > 1950
order by Published_Year asc;


-- 3) List all customers from country Canada

select * from customers where Country = 'Canada';


-- 4) Show orders placed in november 2023

SELECT * FROM Orders 
WHERE order_date between '2023-11-01' and '2023-11-30';


-- 5) Retrive the total stock of books available

SELECT SUM(Stock) AS Total_Stock 
FROM books;


-- 6) Find details of most expensive book

SELECT * FROM Books 
ORDER BY Price DESC 
LIMIT 1;

-- 7) show all the customers who ordered more than 1 book

SELECT * FROM orders 
WHERE Quantity > 1;


-- 8) Retrive all orders where total amount is more than $20

SELECT order_id, customer_id, quantity, total_amount FROM orders 
WHERE Total_Amount > '20';


-- 9) List all Genres available in books table

Select distinct(genre) from books; 

-- 10) Finding the book having lowest stock

select book_id, Title, Stock from books
order by stock limit 10; 

-- 11) Calculate total revenue generated from all orders
SELECT SUM(Total_Amount) AS Revenue 
FROM orders;


-- 12) Retrive the total number of books sold of each genre

SELECT * FROM orders;
SELECT * FROM books;
SELECT * FROM customers;

SELECT b.Genre, SUM(o.Quantity) AS Total_Sales 
FROM Orders o 
JOIN Books b ON o.books_id = b.book_id
group by b.genre;


-- 13) Finding average price of books in Fantasy genre
SELECT AVG(price) as average_price from books 
where genre='Fantasy';

-- 14) Make a list of customers who have placed minimum 2 orders

SELECT o.Customer_ID,c.name, COUNT(o.Order_ID) as order_count
FROM orders o
JOIN customers c ON c.Customer_ID = O.Customer_ID 
group by o.Customer_ID, c.Name
having count(o.Order_ID) >=2;


-- 15) Which is the most frequently ordered book

SELECT o.Books_ID, b.Title,COUNT(o.order_id) as order_count
FROM orders o
JOIN books b ON o.Books_ID = b.Book_ID
group by Books_ID, b.Title
order by order_count desc limit 10;


-- 16) Show top 3 most expensive books of Fantasy genre

SELECT Book_ID, Title, Price, Genre from books
where Genre = 'Fantasy'
order by Price desc limit 3;


-- 17) Retrive the total quantity of books sold by each author

select sum(o.quantity) as total_books_sold, b.Author 
from orders o
join books b ON o.Books_ID = b.Book_ID
group by Author
order by total_books_sold desc;

-- 18) List the cities where customers spent over $30 

SELECT c.Customer_ID,c.city, o.Total_Amount 
FROM customers c 
JOIN orders o ON c.Customer_ID = o.Customer_ID 
where Total_Amount> 30 
order by Total_Amount desc;

--  19) Find the customer who spent most on orders

SELECT c.customer_ID, c.name, sum(o.Total_Amount) AS Total_spend
FROM customers c
Join orders o ON c.Customer_ID = o.Customer_ID
group by c.Customer_ID, c.Name 
ORDER BY Total_spend DESC 
LIMIT 1;

-- 20) Calculate the remaining stock after fulfilling all orders
SELECT b.book_id,b.title, b.stock
from books b
LEFT JOIN  orders o ON b.Book_ID = o.Books_ID
GROUP BY b.Book_ID;

