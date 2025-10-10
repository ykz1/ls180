SELECT      MAX(count)
FROM        (
  SELECT    bidder_id, COUNT(bidder_id)
  FROM      bids
  GROUP BY  bidder_id
) AS max;