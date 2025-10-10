SELECT      SUM(price)
FROM        customers_services
JOIN        services ON services.id = customers_services.service_id
WHERE       price > 100;


SELECT      SUM(price)
FROM        customers
CROSS JOIN  services
WHERE       price > 100;

/* 
Further exploration: CROSS JOINs provide all possible combinations of records between two tables as a starting point, and could be helpful in situations where we have two tables where the records were alike, or potentially in CROSS JOINING a table with itself. For example, if we had a table of addresses, and we wanted to plot out the time it would take to go from each address to every other address, we could use CROSS JOIN as a starting point and filter out situations where the same address is both the starting point and the destination.
*/