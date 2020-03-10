DROP TABLE IF EXISTS property_tracker;

CREATE TABLE property_tracker(
  id SERIAL PRIMARY KEY,
  address VARCHAR(255),
  property_value INT,
  number_bedrooms INT,
  year_built INT
);
