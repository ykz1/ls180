CREATE DATABASE auction;

\c auction

CREATE TABLE bidders (
  id serial PRIMARY KEY,
  name text NOT NULL
);

CREATE TABLE items (
  id serial PRIMARY KEY,
  name text NOT NULL,
  initial_price numeric(6,2) NOT NULL CHECK (initial_price > 0.00),
  sales_price numeric(6,2) CHECK (initial_price > 0.00)
);

CREATE TABLE bids (
  id serial PRIMARY KEY,
  bidder_id integer NOT NULL REFERENCES bidders (id) ON DELETE CASCADE,
  item_id integer NOT NULL REFERENCES items (id) ON DELETE CASCADE,
  amount numeric(6,2) NOT NULL CHECK (amount > 0.00)
);

CREATE INDEX ON bids (bidder_id, item_id);

\copy from bidders.csv to 

\copy bidders from bidders.csv WITH (FORMAT CSV, DELIMITER ',', HEADER TRUE);
\copy items from items.csv WITH (FORMAT CSV, DELIMITER ',', HEADER TRUE);
\copy bids from bids.csv WITH (FORMAT CSV, DELIMITER ',', HEADER TRUE);