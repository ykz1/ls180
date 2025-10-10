EXPLAIN ANALYZE
SELECT MAX(bid_counts.count) FROM
  (SELECT COUNT(bidder_id) FROM bids GROUP BY bidder_id) AS bid_counts;

EXPLAIN ANALYZE
SELECT COUNT(bidder_id) AS max_bid FROM bids
  GROUP BY bidder_id
  ORDER BY max_bid DESC
  LIMIT 1;


-- Further Exploration

/*
Notes:
- The total cost for the scalar subqery is much higher than the join equivalent: 25455 vs 68.44
- This is because SQL sees 880 rows, and with a scalar subquery, the subquery is evaluated for every row processed in the outer select. So the top end of the cost range that SQL estimates is 880 x subquery cost
- In contrast, the cost estimate for the join statement is much lower at 68.44
- However, in actual execution, the scalar subquery only executes 6 times for 6 rows, and as a result we see a total query time of 0.229
- In contrast, the actual query time for the join statement is 0.418. This is because there is a lot of overhead in setting up the hash table that's needed when we join in the bids table on the right. 
- To summarize, the scalar subquery has very little setup cost and potentially very high execution cost because it could theoretically loop through all rows identified—880 of them. But in actuality only 6 loops were required in this query, and so only 6 iterations of the very fast subquery was performed. In contrast, the join query has lower theoretical max execution cost, but a much higher setup cost due to the need to create a hash table to store the table we are joining in.

=======================
Scalar subquery:

auction=# EXPLAIN ANALYZE SELECT name,
(SELECT COUNT(item_id) FROM bids WHERE item_id = items.id)
FROM items;
                                                 QUERY PLAN                                                  
-------------------------------------------------------------------------------------------------------------
 Seq Scan on items  (cost=0.00..25455.20 rows=880 width=40) (actual time=0.038..0.064 rows=6 loops=1)
   SubPlan 1
     ->  Aggregate  (cost=28.89..28.91 rows=1 width=8) (actual time=0.006..0.006 rows=1 loops=6)
           ->  Seq Scan on bids  (cost=0.00..28.88 rows=8 width=4) (actual time=0.003..0.004 rows=4 loops=6)
                 Filter: (item_id = items.id)
                 Rows Removed by Filter: 22
 Planning Time: 0.128 ms
 Execution Time: 0.101 ms
(8 rows)


=======================
Join:

auction=# EXPLAIN ANALYZE SELECT        items.name, COUNT(items.name)
FROM          items
LEFT JOIN     bids ON bids.item_id = items.id
GROUP BY      items.name;
                                                     QUERY PLAN                                                      
---------------------------------------------------------------------------------------------------------------------
 HashAggregate  (cost=66.44..68.44 rows=200 width=40) (actual time=0.120..0.123 rows=6 loops=1)
   Group Key: items.name
   Batches: 1  Memory Usage: 40kB
   ->  Hash Right Join  (cost=29.80..58.89 rows=1510 width=32) (actual time=0.095..0.107 rows=27 loops=1)
         Hash Cond: (bids.item_id = items.id)
         ->  Seq Scan on bids  (cost=0.00..25.10 rows=1510 width=4) (actual time=0.004..0.006 rows=26 loops=1)
         ->  Hash  (cost=18.80..18.80 rows=880 width=36) (actual time=0.058..0.059 rows=6 loops=1)
               Buckets: 1024  Batches: 1  Memory Usage: 9kB
               ->  Seq Scan on items  (cost=0.00..18.80 rows=880 width=36) (actual time=0.024..0.025 rows=6 loops=1)
 Planning Time: 0.231 ms
 Execution Time: 0.187 ms
(11 rows)

*/