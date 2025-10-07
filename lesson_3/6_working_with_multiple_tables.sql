-- 2

SELECT COUNT(id) FROM tickets;

-- 3

SELECT COUNT(DISTINCT customer_id) FROM tickets;

-- 4

-- Option 1:
SELECT ROUND(
  (SELECT COUNT(DISTINCT customer_id) FROM tickets) * 100.0
  /
  (SELECT COUNT(DISTINCT id) FROM customers), 2
);

-- Option 2:
SELECT            ROUND(
                    COUNT(DISTINCT t.customer_id) * 100.0
                    /
                    COUNT(DISTINCT c.id)
                    , 2
                  )
FROM              customers AS c
LEFT OUTER JOIN   tickets AS t
  ON              t.customer_id = c.id;

-- 5
SELECT            e.name AS name,
                  COUNT(t.event_id) AS popularity
FROM              events AS e
LEFT OUTER JOIN   tickets AS t
  ON              e.id = t.event_id
GROUP BY          name
ORDER BY          popularity DESC;

-- 6

SELECT            c.id AS id,
                  c.email AS email,
                  COUNT(DISTINCT t.event_id) AS count
FROM              customers AS c
JOIN              tickets AS t
  ON              c.id = t.customer_id
GROUP BY          c.id
  HAVING          COUNT(DISTINCT t.event_id) = 3;

-- 7

SELECT            e.name AS event,
                  e.starts_at AS starts_at,
                  s2.name AS section,
                  s1.row AS row,
                  s1.number AS seat
FROM              customers AS c
JOIN              tickets AS t
  ON              t.customer_id = c.id
JOIN              events AS e
  ON              t.event_id = e.id
JOIN              seats AS s1
  ON              t.seat_id = s1.id
JOIN              sections AS s2
  ON              s1.section_id = s2.id
WHERE             c.email = 'gennaro.rath@mcdermott.co';