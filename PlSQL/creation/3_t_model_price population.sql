DECLARE
   CURSOR cur_models IS SELECT  id_model FROM t_model;
BEGIN
   FOR r_model IN cur_models
   LOOP
      INSERT INTO
         t_price_model (id_model, dt_beg, dt_end, price)
      VALUES(
         r_model.id_model, 
         TO_DATE(ROUND(DBMS_RANDOM.VALUE(2458363,2458594)),'J'),
         TO_DATE(ROUND(DBMS_RANDOM.VALUE(2458619,2458675)),'J'),
         ROUND(DBMS_RANDOM.VALUE(5,1000), 2));   
   END LOOP;
   COMMIT;  
EXCEPTION
WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE( SQLERRM );    
END;
/
