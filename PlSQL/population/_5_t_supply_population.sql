-- add random supplies

BEGIN
   FOR n_counter IN 1..100
   LOOP     
      INSERT INTO 
         t_supply(dt, id_supplier, e_state)
      VALUES(
         TO_DATE(ROUND(DBMS_RANDOM.VALUE(2458393,2458603)),'J'), -- random date from 01.10.2018  to 29.04.2019
         ROUND(DBMS_RANDOM.VALUE(100000,100006)), -- random supplier
         UPPER('NEW'));
   END LOOP;
   COMMIT; 
EXCEPTION
WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE( SQLERRM );
END;
/
