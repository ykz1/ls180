SELECT    DISTINCT name AS "Bid On Items"
FROM      items
WHERE     id IN (
  SELECT  item_id
  FROM    bids
);

-- Above returns same results and has similar execution cost as:
SELECT    DISTINCT name AS "Bid On Items"
FROM      items
JOIN      bids ON items.id = bids.item_id;