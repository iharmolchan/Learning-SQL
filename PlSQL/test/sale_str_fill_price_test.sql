DECLARE
   n_real_price t_sale_str.price%TYPE;
   n_estimated_price t_sale_str.price%TYPE;
   n_sale_id t_sale.id_sale%TYPE;
   v_ware_price t_price_ware%ROWTYPE;
BEGIN
   DBMS_OUTPUT.PUT_LINE('_____________________________________');
   DBMS_OUTPUT.PUT_LINE('starting test on sale string autocomplete fields restriction');
   
   SELECT id_sale INTO n_sale_id FROM t_sale WHERE UPPER(e_state) = 'NEW' ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
   SELECT * INTO v_ware_price FROM t_price_ware ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
   n_estimated_price := v_ware_price.price * (1 + v_ware_price.margin/100);
   
   INSERT INTO t_sale_str (id_sale, id_ware, qty)
   VALUES (n_sale_id, v_ware_price.id_ware, 1)
   RETURNING price INTO n_real_price;      
      
   IF n_real_price = n_estimated_price THEN
      DBMS_OUTPUT.PUT_LINE('TEST PASSED');
   ELSE
      DBMS_OUTPUT.PUT_LINE('TEST IS NOT PASSED!!!');
   END IF;      
   DBMS_OUTPUT.PUT_LINE('_____________________________________');
   ROLLBACK;     
END;
/
