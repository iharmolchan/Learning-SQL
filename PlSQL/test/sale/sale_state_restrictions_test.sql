DECLARE
   n_sale_id t_sale.id_sale%TYPE;
   n_client_id t_client.id_client%TYPE;
   v_status_new VARCHAR (5 CHAR) := 'NEW';
   v_status_done VARCHAR (5 CHAR) := 'DONE';
   v_status_test VARCHAR (5 CHAR) := 'TEST';
   b_is_insert_test_passed BOOLEAN := FALSE;
   b_is_update_test_passed BOOLEAN := FALSE;
   b_is_delete_test_passed BOOLEAN := FALSE;
   STATE_EXCEPTION EXCEPTION;
   PRAGMA EXCEPTION_INIT(STATE_EXCEPTION, -20010);  
BEGIN
   DBMS_OUTPUT.PUT_LINE('_____________________________________');
   DBMS_OUTPUT.PUT_LINE('starting test on supply state restrictions');
   
   BEGIN
      SELECT id_client INTO n_client_id FROM t_client ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
      INSERT INTO t_sale (dt, id_client, e_state)
      VALUES (SYSDATE, n_client_id, v_status_test);
      DBMS_OUTPUT.PUT_LINE('INSERT trigger failed!');
      ROLLBACK;
   EXCEPTION WHEN STATE_EXCEPTION THEN
      b_is_insert_test_passed := TRUE;
   END;
   
   BEGIN
      SELECT id_sale INTO n_sale_id FROM t_sale ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
      UPDATE t_sale SET e_state = v_status_test WHERE id_sale = n_sale_id;
      DBMS_OUTPUT.PUT_LINE('UPDATE trigger failed!');
      ROLLBACK;
   EXCEPTION WHEN STATE_EXCEPTION THEN
      b_is_update_test_passed := TRUE;
   END;
  
   BEGIN
      SELECT id_sale INTO n_sale_id FROM t_sale ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
      UPDATE t_sale SET e_state = v_status_done WHERE id_sale = n_sale_id;
      DELETE FROM t_sale WHERE id_sale = n_sale_id;
      DBMS_OUTPUT.PUT_LINE('DELETE trigger failed!');
      ROLLBACK;
   EXCEPTION WHEN STATE_EXCEPTION THEN
      b_is_delete_test_passed := TRUE;
   END;    
   
   IF b_is_insert_test_passed AND b_is_update_test_passed AND b_is_delete_test_passed THEN
      DBMS_OUTPUT.PUT_LINE('TEST PASSED');
   ELSE
      DBMS_OUTPUT.PUT_LINE('TEST IS NOT PASSED!!!');
   END IF;
   
   DBMS_OUTPUT.PUT_LINE('_____________________________________');  
END;
/
