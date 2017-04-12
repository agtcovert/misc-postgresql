CREATE DATABASE json_view_example;

-- \c json_view_example

CREATE TABLE normal_data
  (
   id uuid PRIMARY KEY,
   firstname VARCHAR(100) NOT NULL,
   lastname VARCHAR(100) NOT NULL,
   email VARCHAR(200) NOT NULL,
   last_update TIMESTAMPTZ
  );

CREATE TABLE json_example (id BIGSERIAL PRIMARY KEY, json_text jsonb NOT NULL );

-- create random_string function
-- create generate_data function

-- 5m for good test dataset
SELECT generate_data(5000000);

-- create an index so we can do some comparisons later
CREATE INDEX ix_normal_data_lastname ON normal_data(lastname);

-- now create our JSON data
INSERT INTO json_example (json_text) (SELECT row_to_json(t) FROM (SELECT * FROM normal_data) t);

CREATE OR REPLACE VIEW v_people_data AS
    SELECT
      (json_text->>'id')::uuid AS id,
      (json_text->>'firstname')::varchar(100) AS firstname,
      (json_text->>'lastname')::varchar(100) AS lastname,
      (json_text->>'last_update')::timestamptz AS last_update
    FROM json_example;


CREATE INDEX ix_json_example_id ON json_example USING BTREE ( CAST (json_text->>'id' as uuid));
CREATE INDEX ix_json_example_lastname_btree ON json_example USING BTREE ( CAST (json_text->>'lastname' AS VARCHAR(100)));

--CREATE INDEX ix_json_example_lastname_gin ON json_example USING GIN ( CAST (json_text->>'lastname' AS VARCHAR(100)));


