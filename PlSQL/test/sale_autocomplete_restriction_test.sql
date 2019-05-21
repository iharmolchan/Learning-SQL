DECLARE
   n_sale_id t_sale.id_sale%TYPE;
   n_client_id t_client.id_client%TYPE;
   b_is_insert_test_passed BOOLEAN := FALSE;
   b_is_update_test_passed BOOLEAN := FALSE;
   AUTOCOMPLETE_EXCEPTION EXCEPTION;
   PRAGMA EXCEPTION_INIT(AUTOCOMPLETE_EXCEPTION, -20010);  
BEGIN
   DBMS_OUTPUT.PUT_LINE('_____________________________________');
   DBMS_OUTPUT.PUT_LINE('starting test on sale autocomplete fields restriction');
   
   BEGIN
      SELECT id_client INTO n_client_id FROM t_client ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
      INSERT INTO t_sale (dt, id_client, e_state, summa, nds)
      VALUES (SYSDATE, n_client_id, 'NEW', 1, 1);
      DBMS_OUTPUT.PUT_LINE('INSERT trigger failed!');
      ROLLBACK;
   EXCEPTION WHEN AUTOCOMPLETE_EXCEPTION THEN
      b_is_insert_test_passed := TRUE;
   END;   
  
   BEGIN
      SELECT id_sale INTO n_sale_id FROM t_sale ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
      UPDATE t_sale SET summa = 1, nds = 1 WHERE id_sale = n_sale_id;
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
