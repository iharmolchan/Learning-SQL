DECLARE
   n_supply_id t_supply.id_supply%TYPE;
   n_supplier_id t_supplier.id_supplier%TYPE;
   b_is_insert_test_passed BOOLEAN := FALSE;
   b_is_update_test_passed BOOLEAN := FALSE;
   AUTOCOMPLETE_EXCEPTION EXCEPTION;
   PRAGMA EXCEPTION_INIT(AUTOCOMPLETE_EXCEPTION, -20010);  
BEGIN
   DBMS_OUTPUT.PUT_LINE('_____________________________________');
   DBMS_OUTPUT.PUT_LINE('starting test on supply autocomplete fields restriction');
   
   BEGIN
      SELECT id_supplier INTO n_supplier_id FROM t_supplier ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
      INSERT INTO t_supply (dt, id_supplier, e_state, summa, nds)
      VALUES (SYSDATE, n_supplier_id, 'NEW', 1, 1);
      DBMS_OUTPUT.PUT_LINE('INSERT trigger failed!');
      ROLLBACK;
   EXCEPTION WHEN AUTOCOMPLETE_EXCEPTION THEN
      b_is_insert_test_passed := TRUE;
   END;   
  
   BEGIN
      SELECT id_supply INTO n_supply_id FROM t_supply ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
      UPDATE t_supply SET summa = 1, nds = 1 WHERE id_supply = n_supply_id;
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
