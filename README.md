
# 🔅 MUSIC STORE DATA ANALYSIS

## INTRODUCTION
Music store data analysis delves into a store's sales and customer data to extract valuable insights. By analyzing this information, we can answer Business and Growth related insights like:

1. Best Sellers: Identify the most popular instruments, albums, and genres.
2. Customer Buying Habits: Understand who your customers are, what they buy, and how much they spend.
3. Marketing Optimization: Gain insights into customer demographics and product preferences to refine your marketing strategies.
4. Inventory Efficiency: Analyze sales trends to optimize stock levels and avoid overstocking or understocking.





#### This data-driven approach can significantly benefit music stores by boosting sales, improving customer targeting, and informing strategic decisions on inventory management and marketing efforts. 
## Database and Tools
 * PostgreSQL
 * PgAdmin4
## DATASETS
All datasets exist within the Music database schema - be sure to include this reference within your SQL scripts as you start exploring the data and answering the case study questions.

## Case Study Questions and Solutions
Each of the following case study questions can be answered using  SQL statements

 Q.1 Who is the senior most employee based on job title?

```SQL 
SELECT first_name || ' ' || last_name AS employee_name, levels FROM employee
ORDER BY levels desc
limit 1;
```
Output:

|employee_name|levels|
|-------------|------|
|Mohan Madan  |L7    |

Q.2 Which countries have the most Invoices?

```SQL
SELECT COUNT(*) AS co, billing_country FROM invoice
GROUP BY billing_country
ORDER BY co desc;
```
Output:
 
|co|billing_country|
|--|---------------|
131	|USA
76  |Canada
61	|Brazil
50	|France
41	|Germany
30	|Czech Republic
29	|Portugal
28	|United Kingdom
21	|India
13	|Chile
13	|Ireland
11	|Spain
11	|Finland
10	|Australia
10	|Netherlands
10	|Sweden
10	|Poland
10	|Hungary
10	|Denmark
9	|Austria
9	|Norway
9	|Italy
7	|Belgium
5	|Argentina

Q.3 What are top 3 values of total invoices?

```SQL
SELECT total FROM invoice
ORDER BY total desc
limit 3;
```
Output:

|total|
|-----|
23.759999999999998
19.8
19.8

 Q.4 Which city has the best cutsomers? We would like to throw a promotional Music Festival in the city we made the most money. Write a query that returns one city that has the highest sum of invoice totals. Return both the city name & sum of all invoice totals.  

```SQL
SELECT SUM(total) as Invoice_total, billing_city 
FROM invoice
GROUP BY billing_city
ORDER BY Invoice_total DESC;
```
Output:

|invoice_total|billing_city|
|-------------|------------|
273.24000000000007	|Prague
169.29	|Mountain View
166.32	|London
158.4	|Berlin
151.47	|Paris
129.69	|São Paulo
114.83999999999997	|Dublin
111.86999999999999	|Delhi
108.89999999999998	|São José dos Campos
106.91999999999999	|Brasília
102.96000000000001	|Lisbon
99.99	|Bordeaux
99.99	|Montréal
98.01	|Madrid
98.01	|Redmond
97.02000000000001	|Santiago
94.05000000000001	|Frankfurt
92.07000000000001	|Orlando
91.08000000000001	|Reno
91.08	|Ottawa
86.13000000000002	|Fort Worth
84.14999999999999	|Tucson
82.17	|Stuttgart
82.17	|Rio de Janeiro
82.17	|Porto
81.18	|Sidney
79.2	|New York
79.2	|Edinburgh 
79.2	|Helsinki
78.21	|Budapest
76.23	|Madison
76.22999999999999	|Warsaw
75.24000000000001	|Yellowknife
75.24	|Stockholm
73.25999999999999	|Dijon
72.27000000000001	|Oslo
72.27	|Salt Lake City
71.28	|Chicago
71.28	|Bangalore
70.28999999999999	|Winnipeg
69.3	|Vienne
66.33	|Vancouver
66.33	|Boston
65.34	|Amsterdam
64.35	|Lyon
62.370000000000005	|Halifax
60.38999999999999	|Brussels
54.449999999999996	|Cupertino
50.49	|Rome
40.59	|Toronto
39.6	|Buenos Aires
37.61999999999999	|Copenhagen
29.699999999999996	|Edmonton

 Q.5 Who is the best customer? The customer who has spent the most money will be declared the best customer. Write a query that returns the person who has spent the most money.

```SQL
SELECT cu.customer_id, cu.first_name, cu.last_name, SUM(inv.total) AS total
FROM customer as cu
INNER JOIN invoice as inv
ON cu.customer_id=inv.customer_id
GROUP BY cu.customer_id
ORDER BY total DESC
LIMIT 1;
```
Output:

|customer_id|first_name|last_name|total|
|-----------|----------|---------|-----|
5	|R |	Madhav  |144.54000000000002

 Q.6 Write query to return the email, first name, last name, & Genre of all Rock Music listners. Return your list ordered alphabetically by email starting with A. 

```SQL
WITH cte_genre AS (
	SELECT track_id from track AS tr
	JOIN genre AS ge ON tr.genre_id=ge.genre_id
	WHERE ge.name LIKE 'Rock')
SELECT DISTINCT email, first_name, last_name
FROM customer AS cu
JOIN invoice AS inv ON inv.customer_id=cu.customer_id
JOIN invoice_line AS invl ON invl.invoice_id=inv.invoice_id
ORDER BY email;
```
Output:

|email|first_name|last_name|
|-----|----------|---------|
aaronmitchell@yahoo.ca|	Aaron|                Mitchell                                         
alero@uol.com.br|	Alexandre|                                         Rocha                                             
astrid.gruber@apple.at|	Astrid     |                                       	Gruber                                            
bjorn.hansen@yahoo.no|	Bjørn    |                                         Hansen                                            
camille.bernard@yahoo.fr|	Camille     |                                      	Bernard                                           
daan_peeters@apple.be|	Daan                  |                           	Peeters                                           
diego.gutierrez@yahoo.ar|	Diego                    |                        Gutiérrez                                         
dmiller@comcast.com|	Dan                 |                              	Miller                                            
dominiquelefebvre@gmail.com	|Dominique     |                                    	Lefebvre                                          
edfrancis@yachoo.ca	|Edward    |                                        	Francis                                           
eduardo@woodstock.com.br	|Eduardo               |                            	Martins                                           
ellie.sullivan@shaw.ca|	Ellie        |                                     	Sullivan                                          
emma_jones@hotmail.com|	Emma                   |                           	Jones                                             
enrique_munoz@yahoo.es|Enrique                                           |	Muñoz                                             
fernadaramos4@uol.com.br|	Fernanda                 |                         	Ramos                                             
fharris@google.com|Frank       |                                      	Harris                                            
fralston@gmail.com|Frank              |                               	Ralston                                           
ftremblay@gmail.com|	François            |                              	Tremblay                                          
fzimmermann@yahoo.de|	Fynn                                              	Zimmermann                                        
hannah.schneider@yahoo.de|	Hannah                    |                        	Schneider                                         
hholy@gmail.com|	Helena          |                                  	Holý                                              
hleacock@gmail.com|	Heather            |                               	Leacock                                           
hughoreilly@apple.ie|	Hugh                 |                             	O'Reilly                                          
isabelle_mercier@apple.fr|	Isabelle                  |                        	Mercier                                           
jacksmith@microsoft.com|	Jack                    |                          	Smith                                             
jenniferp@rogers.ca|	Jennifer            |                              	Peterson                                          
jfernandes@yahoo.pt|	João                |                              Fernandes                                         
joakim.johansson@yahoo.se|	Joakim                    |                        	Johansson                                         
johavanderberg@yahoo.nl|	Johannes                |                          	Van der erg                                      
johngordon22@yahoo.com|	John                                              |Gordon                                            
jubarnett@gmail.com|	Julia               |                              	Barnett                                           
kachase@hotmail.com|	Kathy               |                              	Chase                                             
kara.nielsen@jubii.dk|	Kara                  |                            	Nielsen                                           
ladislav_kovacs@apple.hu|	Ladislav                 |                         	Kovács                                            
leonekohler@surfeu.de|	Leonie                |                            	Köhler                                            
lucas.mancini@yahoo.it|Lucas                |                             	Mancini                                           
luisg@embraer.com.br|	Luís                 |                             	Gonçalves                                         
luisrojas@yahoo.cl|Luis                |                              	Rojas                                             
manoj.pareek@rediff.com|	Manoj                   |                         	Pareek                                            
marc.dubois@hotmail.com	|Marc                                             	|Dubois                                            
mark.taylor@yahoo.au|	Mark                 |                             	Taylor                                            
marthasilk@gmail.com|	Martha             |                               	Silk                                              
masampaio@sapo.pt|	Madalena          |                                	Sampaio                                           
michelleb@aol.com|	Michelle          |                                	Brooks                                            
mphilips12@shaw.ca|	Mark               |                               	Philips                                           
nschroder@surfeu.de|	Niklas              |                              	Schröder                                          
patrick.gray@aol.com|	Patrick              |                             	Gray                                              
phil.hughes@gmail.com|	Phil         |                                    	Hughes                                            
puja_srivastava@yahoo.in|	Puja                     |                         	Srivastava                                        
r.madhav@jetbrains.com|	R                      |                           	Madhav                                            
ricunningham@hotmail.com|	Richard                  |                         	Cunningham                                        
robbrown@shaw.ca|	Robert           |                                 	Brown                                             
roberto.almeida@riotur.gov.br|	Roberto                       |                    	Almeida                                           
stanislaw.wojcik@wp.pl|Stanisław        |                                 	Wójcik                                            
steve.murray@yahoo.uk|	Steve                 |                            	Murray                                            
terhi.hamalainen@apple.fi|	Terhi                     |                        Hämäläinen                                        
tgoyer@apple.com|	Tim              |                                 	Goyer                                             
vstevens@yahoo.com|Victor                                            	|Stevens                                           
wyatt.girard@yahoo.fr|	Wyatt                 |                            	Girard                                       

Q.7 Let's invite the artists who have written the most rock music in our dataset. Write a query that returns the Artist name and total track count of the top 10 rock bands.


```SQL
SELECT ar.name, ar.artist_id, COUNT( ar.artist_id) AS total_songs
FROM track as tr
JOIN album AS al ON al.album_id=tr.album_id
JOIN artist AS ar ON ar.artist_id=al.artist_id
JOIN  genre AS ge ON ge.genre_id=tr.genre_id
WHERE ge.name Like 'Rock'
GROUP BY  ar.artist_id
ORDER BY total_songs DESC
LIMIT  10;
```
Output:

|name|artist_id|total_songs|
|----|---------|-----------|
Led Zeppelin	|22|	114
U2 |150|	112
Deep Purple	|58|	92
Iron Maiden	|90|	81
Pearl Jam||118|	54
Van Halen|152|52
Queen|51|	45
The Rolling Stones|142|41
Creedence Clearwater Revival|76|	40
Kiss|52|	35

Q.8 Return all the track names that have a song length longer than the average song length. Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first.

```SQL
SELECT name, milliseconds
FROM track 
WHERE milliseconds > (
	SELECT  AVG(milliseconds) AS avg_track_length
	FROM track)
ORDER BY milliseconds DESC;
```
Output:

* The output will return 150 records, but I'm only writing only top 10 records in this.


|name|milliseconds|
|----|------------|
Occupation Precipice|	5286953
Through a Looking Glass|	5088838
Greetings from Earth, Pt. 1|	2960293
The Man With Nine Lives|2956998
Battlestar Galactica, Pt. 2|	2956081
Battlestar Galactica, Pt. 1|	2952702
Murder On the Rising Star|	2935894
Battlestar Galactica, Pt. 3|	2927802
Take the Celestra|	2927677
Fire In Space|	2926593

Q.9 Find how much amount spent by each customer on artists? Write a query to return customer name, artist name, and total spent. 

```SQL
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
```
Output:

 * The output will return 43 records, but I'm only writing only top 10 records in this.

 |customer_id|first_name|last_name|artist_name|amount_spent|
 |-----------|----------|---------|-----------|------------|
46	|Hugh    |	O'Reilly  |   Queen|	27.719999999999985
38	|Niklas    |Schröder  |                                        Queen|	18.81
3	|François                                          	|Tremblay                                          |	Queen|17.82
34|	João   |                                           	Fernandes                                         |	Queen|	16.830000000000002
41	|Marc|                                              	Dubois |                                           	Queen|	11.88
53|	Phil  |                                            Hughes  |                                          	Queen|	11.88
33|	Ellie|                                             	Sullivan                 |                         	Queen|	10.89
47|	Lucas                                 |            Mancini                                           	|Queen|	10.89
20|	Dan|                                               	Miller |                                           	Queen	|3.96
5	|R                          |                       	Madhav                                            	|Queen|	3.96



Q.10  We want to find out the most popular music Genre for each country. We determine the most popular genre as the genre with the highest amount of purchases. Write aquery that returns each country along with the top Genre. For countries where the maximum number of purchases is shared return all Genres.

```SQL
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
```
Output:

|purchases|country|name|genre_id|rowno|
|---------|-------|----|--------|-----|
17	|Argentina |Alternative & Punk|	4|	1
34	|Australia |Rock	|1	|1
40	|Austria	|Rock| 1	|1
26	|Belgium|Rock	|1|	1
205	|Brazil|Rock|1|	1
333|	Canada|Rock|1|	1
61 |Chile|Rock|1|	1
143	|Czech Republic|Rock|1|	1
24	|Denmark|Rock	|1|	1
46	|Finland|Rock|1|	1
211	|France|Rock|1|	1
194	|Germany|Rock|1|	1
44	|Hungary|Rock|1|	1
102	|India|Rock	|1|	1
72	|Ireland|Rock|1|	1
35	|Italy|Rock|1|	1
33	|Netherlands|Rock	|1|	1
40	|Norway|Rock|1|	1
40	|Poland|Rock|1|	1
108	|Portugal|Rock|1|	1
46	|Spain|Rock|1|1
60	|Sweden|Rock|1|	1
166	|United Kingdom|Rock	|1|1
561	|USA|Rock|1|	1

Q.11 Write a query that determines the customer that has spent the most on music for each country. Write a query that returns the country along with the top customer and how much they soent. For countries where the top amount soent is shared, provide all customers who spent this amount.

* Method 1: using CTE 

```SQL
WITH Customter_with_country AS (
		SELECT customer.customer_id,first_name,last_name,billing_country,SUM(total) AS total_spending,
	    ROW_NUMBER() OVER(PARTITION BY billing_country ORDER BY SUM(total) DESC) AS RowNo 
		FROM invoice
		JOIN customer ON customer.customer_id = invoice.customer_id
		GROUP BY 1,2,3,4
		ORDER BY 4 ASC,5 DESC)
SELECT * FROM Customter_with_country WHERE RowNo <= 1
```

* Method 2: Using Recursive 

```SQL
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
```
Output:

|customer_id|first_name|last_name|billing_country|total_spending|rowno|
|-----------|----------|---------|---------------|--------------|-----|
56	|Diego      |                        Gutiérrez     |                                    	Argentina|	39.6	|1
55|	Mark   |                                           	Taylor    |                                        Australia	|81.18|	1
7	|Astrid  |                                          	Gruber   |      Austria	|69.3|	1
8	|Daan |Peeters   |Belgium|60.38999999999999|	1
1	|Luís|  Gonçalves  |Brazil|108.89999999999998	|1
3	|François|    Tremblay   |  Canada|99.99|	1
57	|Luis |Rojas   | Chile|	97.02000000000001|	1
5	|R |Madhav|  Czech Republic|	144.54000000000002|	1
9	|Kara | 	Nielsen |   Denmark	|37.61999999999999	|1
44	|Terhi   |     	Hämäläinen    | Finland	|79.2	|1
42	|Wyatt  |Girard  | France	|99.99	|1
37	|Fynn    |Zimmermann  | Germany	|94.05000000000001|	1
45	|Ladislav |Kovács |Hungary|	78.21	|1
58	|Manoj |Pareek |India|	111.86999999999999	|1
46	|Hugh|O'Reilly| Ireland|	114.83999999999997|	1
47	|Lucas |Mancini |Italy	|50.49	|1
48	|Johannes |Van der Berg |Netherlands	|65.34	|1
4	|Bjørn |Hansen| Norway|	72.27000000000001	|1
49	|Stanisław |Wójcik  |  Poland|	76.22999999999999	|1
34	|João  |                                            	Fernandes        | Portugal|	102.96000000000001|	1
50	|Enrique                                           	|Muñoz       |     Spain	|98.01	|1
51| Joakim|                                            	Johansson  |                                       	Sweden|	75.24|	1
53	|Phil |Hughes|United Kingdom|	98.01	|1
17	|Jack	|Smith| USA|	98.01|	1



