SELECT      name
FROM        bidders
WHERE       EXISTS (
  SELECT    1
  FROM      bids
  WHERE     bids.bidder_id = bidders.id
);

-- Further exploration:

SELECT      DISTINCT name
FROM        bidders
JOIN        bids ON bids.bidder_id = bidders.id;