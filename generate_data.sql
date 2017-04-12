CREATE OR REPLACE FUNCTION generate_data(rowcount BIGINT)
RETURNS VOID AS $$
DECLARE
    i BIGINT := 0;
    firstname VARCHAR(100);
BEGIN

  IF rowcount < 0 THEN
    RAISE EXCEPTION 'Must generate at least 1 row of data';
  END IF;

  FOR i in 1..rowcount
  LOOP

    firstname := random_string(25);

    INSERT INTO normal_data
      (id, firstname, lastname, email, last_update)
    VALUES
      (gen_random_uuid(), firstname, random_string(35),
       firstname || i || '@' ||
          (CASE (random() * 2)::INTEGER
            WHEN 0 THEN 'gmail'
            WHEN 1 THEN 'yahoo'
            WHEN 2 THEN 'outlook'
           END) || '.com'
        , now());
  END LOOP;
  RETURN;
END;
$$ LANGUAGE 'plpgsql';
