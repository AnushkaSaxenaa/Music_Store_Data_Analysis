-- Q.1: Who is the senior most employee based on job title?

SELECT first_name || ' ' || last_name AS employee_name, levels FROM employee
ORDER BY levels desc
limit 1;

-- Q.2 Which countries have the most Invoices?

SELECT COUNT(*) AS co, billing_country FROM invoice
GROUP BY billing_country
ORDER BY co desc;

--Q.3 What are top 3 values of total invoices?

SELECT total FROM invoice
ORDER BY total desc
limit 3;

-- Q.4 Which city has the best cutsomers? We would like to throw a promotional Music Festival in the city we made the most money. Write a query that returns one city that has the highest sum of invoice totals. Return both the city name & sum of all invoice totals.  

SELECT SUM(total) as Invoice_total, billing_city 
FROM invoice
GROUP BY billing_city
ORDER BY Invoice_total DESC;

-- Q.5 Who is the best customer? The customer who has spent the most money will be declared the best customer. Write a query that returns the person who has spent the most money.

SELECT cu.customer_id, cu.first_name, cu.last_name, SUM(inv.total) AS total
FROM customer as cu
INNER JOIN invoice as inv
ON cu.customer_id=inv.customer_id
GROUP BY cu.customer_id
ORDER BY total DESC
LIMIT 1;

-- Q.6 Write query to return the email, first name, last name, & Genre of all Rock Music listners. Return your list ordered alphabetically by email starting with A. 

WITH cte_genre AS (
	SELECT track_id from track AS tr
	JOIN genre AS ge ON tr.genre_id=ge.genre_id
	WHERE ge.name LIKE 'Rock')
SELECT DISTINCT email, first_name, last_name
FROM customer AS cu
JOIN invoice AS inv ON inv.customer_id=cu.customer_id
JOIN invoice_line AS invl ON invl.invoice_id=inv.invoice_id
ORDER BY email;

-- Q.7 Let's invite the artists who have written the most rock music in our dataset. Write a query that returns the Artist name and total track count of the top 10 rock bands.

SELECT ar.name, ar.artist_id, COUNT( ar.artist_id) AS total_songs
FROM track as tr
JOIN album AS al ON al.album_id=tr.album_id
JOIN artist AS ar ON ar.artist_id=al.artist_id
JOIN  genre AS ge ON ge.genre_id=tr.genre_id
WHERE ge.name Like 'Rock'
GROUP BY  ar.artist_id
ORDER BY total_songs DESC
LIMIT  10;

-- Q.8 Return all the track names that have a song length longer than the average song length. Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first.


SELECT name, milliseconds
FROM track 
WHERE milliseconds > (
	SELECT  AVG(milliseconds) AS avg_track_length
	FROM track)
ORDER BY milliseconds DESC;


-- Q.9 Find how much amount spent by each customer on artists? Write a query to return customer name, artist name, and total spent. 

WITH best_selling_artist AS(
    SELECT artist.artist_id AS artist_id, artist.name AS artist_name,
	SUM(invoice_line.unit_price*invoice_line.quantity) AS total_sales
	FROM invoice_line 
	JOIN track  ON track.track_id=invoice_line.track_id
	JOIN album  ON album.album_id=track.album_id
	JOIN artist  ON artist.artist_id=album.artist_id
	GROUP BY 1
	ORDER BY 3 DESC
	LIMIT 1
)

SELECT cu.customer_id, cu.first_name, cu.last_name, bsa.artist_name, SUM(invl.unit_price*invl.quantity) AS amount_spent
FROM invoice AS i
JOIN customer AS cu ON cu.customer_id=i.customer_id
JOIN invoice_line AS invl ON invl.invoice_id=i.invoice_id
JOIN track AS tr ON tr.track_id=invl.track_id
JOIN album AS al ON al.album_id=tr.album_id
JOIN best_selling_artist AS bsa ON bsa.artist_id=al.artist_id
GROUP BY cu.customer_id, cu.first_name, cu.last_name, bsa.artist_name
ORDER BY amount_spent DESC;

-- Q.10 We want to find out the most popular music Genre for each country. We determine the most popular genre as the genre with the highest amount of purchases. Write aquery that returns each country along with the top Genre. For countries where the maximum number of purchases is shared return all Genres.

WITH popular_genre AS(
  SELECT COUNT(invoice_line.quantity) AS purchases, customer.country, genre.name, genre.genre_id,
	ROW_NUMBER() OVER(PARTITION BY customer.country ORDER BY COUNT(invoice_line.quantity) DESC) AS RowNO
  FROM invoice_line
  JOIN invoice ON invoice.invoice_id =  invoice_line.invoice_id 
  JOIN customer ON customer.customer_id = invoice.customer_id
  JOIN track ON track.track_id =  invoice_line.track_id
  JOIN genre ON genre.genre_id = track.genre_id
  GROUP BY 2,3,4
  ORDER BY 2 ASC, 1 DESC 
)
SELECT * FROM popular_genre 
	WHERE RowNo <= 1;


-- Q.11 Write a query that determines the customer that has spent the most on music for each country. Write a query that returns the country along with the top customer and how much they soent. For countries where the top amount soent is shared, provide all customers who spent this amount.
/* Method 1: using CTE */

WITH Customter_with_country AS (
		SELECT customer.customer_id,first_name,last_name,billing_country,SUM(total) AS total_spending,
	    ROW_NUMBER() OVER(PARTITION BY billing_country ORDER BY SUM(total) DESC) AS RowNo 
		FROM invoice
		JOIN customer ON customer.customer_id = invoice.customer_id
		GROUP BY 1,2,3,4
		ORDER BY 4 ASC,5 DESC)
SELECT * FROM Customter_with_country WHERE RowNo <= 1


/* Method 2: Using Recursive */

WITH RECURSIVE 
      customer_with_country AS(
	    SELECT customer.customer_id,first_name,last_name,billing_country,SUM(total) AS total_spending
		FROM invoice
		JOIN customer ON customer.customer_id = invoice.customer_id
		GROUP BY 1,2,3,4
	    ORDER BY 1, 5 DESC ),
		
	  customer_max_spending AS(
	    SELECT billing_country, MAX(total_spending) AS max_spending
	    FROM customer_with_country
	    GROUP BY billing_country)

SELECT cc.billing_country, cc.total_spending, cc.first_name, cc.last_name
FROM customer_with_country AS cc
JOIN customer_max_spending AS ms
ON  cc.billing_country = ms.billing_country
WHERE cc.total_spending = ms.max_spending
ORDER BY 1;



