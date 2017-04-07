CREATE OR REPLACE FUNCTION json_intext(text) RETURNS json AS $$
SELECT json_in($1::cstring);
$$ LANGUAGE SQL IMMUTABLE;
 
CREATE CAST (text AS json) WITH FUNCTION json_intext(text) AS IMPLICIT;
