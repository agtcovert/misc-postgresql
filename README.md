# postgresql-json-views

Set of scripts that show an example of using PostgreSQL's JSONB datatype, presenting it as a view and allowing SQL standard updates.

Requires postgresql >= 9.4.x.
My testing done on 9.6.2.



json_view_example=# explain analyze select * from normal_data where lastname ='AH4TIAyhxfrzbApESQdEQA4mIfumtko42sX';
                                                              QUERY PLAN
---------------------------------------------------------------------------------------------------------------------------------------
 Index Scan using ix_normal_data_lastname on normal_data  (cost=0.56..8.57 rows=1 width=129) (actual time=0.773..0.775 rows=1 loops=1)
   Index Cond: ((lastname)::text = 'AH4TIAyhxfrzbApESQdEQA4mIfumtko42sX'::text)
 Planning time: 0.197 ms
 Execution time: 0.828 ms
(4 rows)


json_view_example=# explain analyze select * from v_people_data where lastname ='AH4TIAyhxfrzbApESQdEQA4mIfumtko42sX';
                                                          QUERY PLAN
------------------------------------------------------------------------------------------------------------------------------
 Seq Scan on json_example  (cost=0.00..273309.91 rows=25000 width=460) (actual time=0.032..2941.337 rows=1 loops=1)
   Filter: ((((json_text ->> 'lastname'::text))::character varying(100))::text = 'AH4TIAyhxfrzbApESQdEQA4mIfumtko42sX'::text)
   Rows Removed by Filter: 4999999
 Planning time: 0.102 ms
 Execution time: 2941.363 ms
 
Bitmap Heap Scan on json_example  (cost=918.31..70674.70 rows=25000 width=460) (actual time=0.749..0.750 rows=1 loops=1)
Recheck Cond: ((((json_text ->> 'lastname'::text))::character varying(100))::text = 'AH4TIAyhxfrzbApESQdEQA4mIfumtko42sX'::text)
Heap Blocks: exact=1
->  Bitmap Index Scan on ix_test_2  (cost=0.00..912.06 rows=25000 width=0) (actual time=0.713..0.713 rows=1 loops=1)
      Index Cond: ((((json_text ->> 'lastname'::text))::character varying(100))::text = 'AH4TIAyhxfrzbApESQdEQA4mIfumtko42sX'::text)
Planning time: 2.331 ms
Execution time: 0.785 ms