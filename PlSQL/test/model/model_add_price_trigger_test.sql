DECLARE
   n_before_price t_model.price%TYPE;
   n_after_price t_model.price%TYPE;
   n_insert_price t_model.price%TYPE := 9999.99;
   n_id_model t_model.id_model%TYPE;
   n_is_price_exists NUMBER;
BEGIN
   DBMS_OUTPUT.PUT_LINE('_____________________________________');
   DBMS_OUTPUT.PUT_LINE('starting test model_add_price_trigger');
   
   SELECT id_model INTO n_id_model FROM t_model
   ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
   
   SELECT COUNT(*) INTO n_is_price_exists FROM t_price_model WHERE id_model = n_id_model;
   
   SELECT NVL(price, 0) INTO n_before_price FROM t_model WHERE id_model = n_id_model;
   DBMS_OUTPUT.PUT_LINE('before price is: '||n_before_price||'. insert price is: '||n_insert_price);
   
   IF n_is_price_exists > 0 THEN   
      UPDATE t_price_model
      SET price = n_insert_price
      WHERE id_model = n_id_model;
   ELSE
      INSERT INTO t_price_model (id_model, price)
      VALUES (n_id_model, n_insert_price);
   END IF;      
   
   SELECT NVL(price, 0) INTO n_after_price FROM t_model WHERE id_model = n_id_model;
   DBMS_OUTPUT.PUT_LINE('after price is: '||n_after_price);
   
   IF n_insert_price = n_after_price THEN
      DBMS_OUTPUT.PUT_LINE('TEST PASSED');
   ELSE
      DBMS_OUTPUT.PUT_LINE('TEST IS NOT PASSED!!!');
   END IF;
   
   DBMS_OUTPUT.PUT_LINE('_____________________________________');
   
   ROLLBACK;  
END;
/
