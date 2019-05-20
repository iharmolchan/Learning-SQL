DECLARE
   n_supply_id t_supply.id_supply%TYPE;
   n_supply_str_id t_supply_str.id_supply_str%TYPE;
   n_ware_id t_ware.id_ware%TYPE;
   b_is_insert_test_passed BOOLEAN := FALSE;
   b_is_update_test_passed BOOLEAN := FALSE;
   b_is_delete_test_passed BOOLEAN := FALSE;
   STATE_EXCEPTION EXCEPTION;
   PRAGMA EXCEPTION_INIT(STATE_EXCEPTION, -20010);  
BEGIN
   DBMS_OUTPUT.PUT_LINE('_____________________________________');
   DBMS_OUTPUT.PUT_LINE('starting test on supply str state restrictions');
   
   SELECT id_supply INTO n_supply_id FROM t_supply WHERE UPPER(e_state) = 'DONE' ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
   SELECT id_ware INTO n_ware_id FROM t_ware ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
   
   BEGIN      
      INSERT INTO t_supply_str (id_supply, id_ware, qty, price)
      VALUES (n_supply_id, n_ware_id, 1, 1);
      DBMS_OUTPUT.PUT_LINE('INSERT trigger failed!');
      ROLLBACK;
   EXCEPTION WHEN STATE_EXCEPTION THEN
      b_is_insert_test_passed := TRUE;
   END;
   
   BEGIN
      SELECT id_supply_str INTO n_supply_str_id FROM t_supply_str 
      WHERE id_supply = n_supply_id ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
      UPDATE t_supply_str SET num = num + 1 WHERE id_supply_str = n_supply_str_id;
      DBMS_OUTPUT.PUT_LINE('UPDATE trigger failed!');
      ROLLBACK;
   EXCEPTION WHEN STATE_EXCEPTION THEN
      b_is_update_test_passed := TRUE;
   END;
  
   BEGIN
      SELECT id_supply_str INTO n_supply_str_id FROM t_supply_str 
      WHERE id_supply = n_supply_id ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
      DELETE FROM t_supply_str WHERE id_supply_str = n_supply_str_id;
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
