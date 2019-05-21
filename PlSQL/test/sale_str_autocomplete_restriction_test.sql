DECLARE
   n_sale_str_id t_sale_str.id_sale_str%TYPE;
   n_sale_id t_sale.id_sale%TYPE;
   n_ware_id t_ware.id_ware%TYPE;
   b_is_insert_test_passed BOOLEAN := FALSE;
   b_is_update_test_passed BOOLEAN := FALSE;
   AUTOCOMPLETE_EXCEPTION EXCEPTION;
   PRAGMA EXCEPTION_INIT(AUTOCOMPLETE_EXCEPTION, -20010);  
BEGIN
   DBMS_OUTPUT.PUT_LINE('_____________________________________');
   DBMS_OUTPUT.PUT_LINE('starting test on sale string autocomplete fields restriction');
   
   BEGIN
      SELECT id_sale INTO n_sale_id FROM t_sale WHERE UPPER(e_state) = 'NEW' ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
      SELECT id_ware INTO n_ware_id FROM t_ware ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
      INSERT INTO t_sale_str (id_sale, id_ware, qty, price, summa, nds)
      VALUES (n_sale_id, n_ware_id, 1, 1, 1, 1);
      DBMS_OUTPUT.PUT_LINE('INSERT trigger failed!');
      ROLLBACK;
   EXCEPTION WHEN AUTOCOMPLETE_EXCEPTION THEN
      b_is_insert_test_passed := TRUE;
   END;   
  
   BEGIN
      SELECT id_sale_str INTO n_sale_str_id FROM t_sale_str WHERE id_sale = n_sale_id ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
      UPDATE t_sale_str SET summa = 1, nds = 1 WHERE id_sale_str = n_sale_str_id;
      DBMS_OUTPUT.PUT_LINE('UPDATE trigger failed!');
      ROLLBACK;
   EXCEPTION WHEN AUTOCOMPLETE_EXCEPTION THEN
      b_is_update_test_passed := TRUE;
   END;
   
   IF b_is_insert_test_passed AND b_is_update_test_passed THEN
      DBMS_OUTPUT.PUT_LINE('TEST PASSED');
   ELSE
      DBMS_OUTPUT.PUT_LINE('TEST IS NOT PASSED!!!');
   END IF;
   
   DBMS_OUTPUT.PUT_LINE('_____________________________________');     
END;
/
