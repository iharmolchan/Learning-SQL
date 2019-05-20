-- add random supplies

BEGIN
   FOR n_counter IN 1..1000
   LOOP     
      INSERT INTO 
         t_supply(dt, id_supplier, e_state)
      VALUES(
         TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2018-10-01','J'),TO_CHAR(DATE '2019-04-29','J'))), 'J'), -- random date from 01.10.2018  to 29.04.2019
         (SELECT id_supplier FROM t_supplier ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY), -- random supplier
         UPPER('NEW'));
   END LOOP;
   COMMIT; 
EXCEPTION
WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE( SQLERRM );
END;
/
