DECLARE
   n_random NUMBER (1,0);
BEGIN
   FOR n_counter IN 1..1000
   LOOP
      n_random:= ROUND(DBMS_RANDOM.VALUE(0,9));   
      INSERT INTO 
         t_supply(dt, id_supplier, e_state)
      VALUES(
         TO_DATE(ROUND(DBMS_RANDOM.VALUE(2458393,2458603)),'J'), 
         ROUND(DBMS_RANDOM.VALUE(100000,100006)), 
         CASE
            WHEN n_random BETWEEN 0 AND 8 THEN 'DONE'
            ELSE 'NEW'  
         END);
  END LOOP;
  COMMIT; 
EXCEPTION
WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE( SQLERRM );
END;
/
