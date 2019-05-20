-- add random supplies

DECLARE
   n_random NUMBER (1,0);
BEGIN
   FOR n_counter IN 1..2000
   LOOP
      n_random:= ROUND(DBMS_RANDOM.VALUE(0,9));   
      INSERT INTO 
         t_sale(dt, id_client, e_state, discount)
      VALUES(
         TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2018-10-03','J'), TO_CHAR(DATE '2019-04-28','J'))), 'J'), -- random date from 03.10.2018  to 28.04.2019 
         (SELECT id_client FROM t_client ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY), -- random clinet
         UPPER('NEW'),
         CASE
            WHEN n_random BETWEEN 0 AND 8 THEN 0  -- 90% to get discount eqal to zero
            ELSE ROUND(DBMS_RANDOM.VALUE(0,50))   -- 10% to get discount between 0 and 50%
         END);
  END LOOP;
  COMMIT; 
EXCEPTION
WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE( SQLERRM );
END;
/
