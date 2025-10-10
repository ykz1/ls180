SELECT        items.name, 
              (SELECT COUNT(bids.item_id) FROM bids WHERE items.id = bids.item_id)
FROM          items;

-- Equivalent output using JOIn

SELECT        items.name, COUNT(items.name)
FROM          items
LEFT JOIN     bids ON bids.item_id = items.id
GROUP BY      items.name;