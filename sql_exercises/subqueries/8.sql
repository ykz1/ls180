EXPLAIN
SELECT name FROM bidders
WHERE EXISTS (SELECT 1 FROM bids WHERE bids.bidder_id = bidders.id);

/*
                                QUERY PLAN                                
--------------------------------------------------------------------------
 Hash Join  (cost=33.38..66.47 rows=635 width=32)
   Hash Cond: (bidders.id = bids.bidder_id)
   ->  Seq Scan on bidders  (cost=0.00..22.70 rows=1270 width=36)
   ->  Hash  (cost=30.88..30.88 rows=200 width=4)
         ->  HashAggregate  (cost=28.88..30.88 rows=200 width=4)
               Group Key: bids.bidder_id
               ->  Seq Scan on bids  (cost=0.00..25.10 rows=1510 width=4)
(7 rows)
*/

EXPLAIN ANALYZE
SELECT name FROM bidders
WHERE EXISTS (SELECT 1 FROM bids WHERE bids.bidder_id = bidders.id);

/*
                                                     QUERY PLAN                                                      
---------------------------------------------------------------------------------------------------------------------
 Hash Join  (cost=33.38..66.47 rows=635 width=32) (actual time=0.106..0.110 rows=6 loops=1)
   Hash Cond: (bidders.id = bids.bidder_id)
   ->  Seq Scan on bidders  (cost=0.00..22.70 rows=1270 width=36) (actual time=0.033..0.034 rows=7 loops=1)
   ->  Hash  (cost=30.88..30.88 rows=200 width=4) (actual time=0.054..0.055 rows=6 loops=1)
         Buckets: 1024  Batches: 1  Memory Usage: 9kB
         ->  HashAggregate  (cost=28.88..30.88 rows=200 width=4) (actual time=0.032..0.034 rows=6 loops=1)
               Group Key: bids.bidder_id
               Batches: 1  Memory Usage: 40kB
               ->  Seq Scan on bids  (cost=0.00..25.10 rows=1510 width=4) (actual time=0.015..0.018 rows=26 loops=1)
 Planning Time: 0.140 ms
 Execution Time: 0.175 ms
(11 rows)
*/

-- With just EXPLAIN, we see the query plan that SQL constructs, but the query is not actually run. With EXPLAIN ANALYZE, ANALYZE will actually execute the query and pass the results back to EXPLAIN which provides the output we see. On top of the query plan, with ANALYZE we see the actual time for the query, split between planning time and execution time.