DECLARE
   v_sale t_sale%ROWTYPE;
   v_sale_str t_sale_str%ROWTYPE;
   n_estimated_price t_sale_str.price%TYPE;
BEGIN
   DBMS_OUTPUT.PUT_LINE('_____________________________________');
   DBMS_OUTPUT.PUT_LINE('starting test on sale update restriction on done status');
   
   SELECT * INTO v_sale FROM t_sale WHERE UPPER(e_state) = 'NEW' ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;   
   
   UPDATE t_sale SET discount = discount + 10 WHERE id_sale = v_sale.id_sale;
   
   SELECT * INTO v_sale_str FROM t_sale_str WHERE id_sale = v_sale.id_sale ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
   
   n_estimated_price := v_sale_str.price * (1 - v_sale_str.discount / 100) * (1 - (v_sale.discount + 10) / 100);
   
   IF v_sale_str.disc_price = n_estimated_price THEN
      DBMS_OUTPUT.PUT_LINE('TEST PASSED');
      DBMS_OUTPUT.PUT_LINE('_____________________________________');
   ELSE
      DBMS_OUTPUT.PUT_LINE('TEST IS NOT PASSED!!!');
      DBMS_OUTPUT.PUT_LINE('_____________________________________');
   END IF;
   
   ROLLBACK;           
END;
/
