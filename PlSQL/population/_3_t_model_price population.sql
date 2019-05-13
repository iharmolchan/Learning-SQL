-- add random prices to models

DECLARE
   CURSOR cur_models IS SELECT  id_model FROM t_model;
BEGIN
   FOR r_model IN cur_models
   LOOP
      INSERT INTO
         t_price_model (id_model, price)
      VALUES(
         r_model.id_model,
         ROUND(DBMS_RANDOM.VALUE(5,1000), 2));  -- prices from 5 to 1000   
   END LOOP;
   COMMIT;  
EXCEPTION
WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE(SQLERRM);    
END;
/
