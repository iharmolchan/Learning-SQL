DECLARE
   n_random NUMBER (1,0);
BEGIN
   FOR n_counter IN 1..200
   LOOP
      n_random:= ROUND(DBMS_RANDOM.VALUE(0,9));   
      INSERT INTO 
         t_sale(dt, id_client, e_state, discount)
      VALUES(
         TO_DATE(ROUND(DBMS_RANDOM.VALUE(2458395,2458602)),'J'), 
         ROUND(DBMS_RANDOM.VALUE(100000,100016)), 
         CASE
            WHEN n_random BETWEEN 1 AND 8 THEN 'DONE'
            ELSE 'NEW'  
         END,
         CASE
            WHEN n_random BETWEEN 0 AND 8 THEN 0
            ELSE ROUND(DBMS_RANDOM.VALUE(0,50))
         END);
  END LOOP;
  COMMIT; 
EXCEPTION
WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE( SQLERRM );
END;
/
