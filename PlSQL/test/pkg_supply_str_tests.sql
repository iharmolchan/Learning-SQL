CREATE OR REPLACE PACKAGE pkg_supply_str_tests
AS  
   PROCEDURE autocomplete_restriction;
   PROCEDURE state_restriction;
   PROCEDURE fill_fields_on_insert;
   PROCEDURE fill_fields_on_update;
   PROCEDURE fill_fields_on_delete;
 
END pkg_supply_str_tests;
/

CREATE OR REPLACE PACKAGE BODY pkg_supply_str_tests
AS
   -- autocomplete restrictions test
   PROCEDURE autocomplete_restriction
   IS
      n_supply_str_id t_supply_str.id_supply_str%TYPE;
      n_supply_id t_supply.id_supply%TYPE;
      n_ware_id t_ware.id_ware%TYPE;
      b_is_insert_test_passed BOOLEAN := FALSE;
      b_is_update_test_passed BOOLEAN := FALSE;
      AUTOCOMPLETE_EXCEPTION EXCEPTION;
      PRAGMA EXCEPTION_INIT(AUTOCOMPLETE_EXCEPTION, -20010);  
   BEGIN
      DBMS_OUTPUT.PUT_LINE('_____________________________________');
      DBMS_OUTPUT.PUT_LINE('starting test on supply string autocomplete fields restriction');
   
      BEGIN
         SELECT id_supply INTO n_supply_id FROM t_supply WHERE UPPER(e_state) = 'NEW' ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
         SELECT id_ware INTO n_ware_id FROM t_ware ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
         INSERT INTO t_supply_str (id_supply, id_ware, qty, price, summa, nds)
         VALUES (n_supply_id, n_ware_id, 1, 1, 1, 1);
         DBMS_OUTPUT.PUT_LINE('INSERT trigger failed!');
         ROLLBACK;
      EXCEPTION WHEN AUTOCOMPLETE_EXCEPTION THEN
         b_is_insert_test_passed := TRUE;
      END;   
  
      BEGIN
         SELECT id_supply_str INTO n_supply_str_id FROM t_supply_str WHERE id_supply = n_supply_id ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
         UPDATE t_supply_str SET summa = 1, nds = 1 WHERE id_supply_str = n_supply_str_id;
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
   END autocomplete_restriction;
   
   -- supply state restrictions test
   PROCEDURE state_restriction
   IS
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
   END state_restriction;
   
   -- fill fields in supply and supply string on insert test
   PROCEDURE fill_fields_on_insert
   IS
      TYPE supplyStrData IS RECORD(   
      id_supply_str t_supply_str.id_supply_str%TYPE,
      summa t_supply_str.summa%TYPE,
      nds t_supply_str.nds%TYPE);      
      v_supply_str_data supplyStrData;
      v_supply_before t_supply%ROWTYPE;
      v_supply_after t_supply%ROWTYPE;
      n_ware_id t_ware.id_ware%TYPE;
      n_insert_qty t_supply_str.qty%TYPE := 10;
      n_insert_price t_supply_str.price%TYPE := 100;
      b_is_supply_str_filled BOOLEAN := FALSE;
      b_is_supply_filled BOOLEAN := FALSE;
   BEGIN
      DBMS_OUTPUT.PUT_LINE('_____________________________________');
      DBMS_OUTPUT.PUT_LINE('starting test on fill supply str and supply fields on insert');
      
      SELECT * INTO v_supply_before FROM t_supply WHERE UPPER(e_state) = 'NEW' ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
      SELECT id_ware INTO n_ware_id FROM t_ware ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
      
      INSERT INTO t_supply_str (id_supply, id_ware, qty, price)
      VALUES (v_supply_before.id_supply, n_ware_id, n_insert_qty, n_insert_price)
      RETURNING id_supply_str, summa, nds INTO v_supply_str_data;
      
      SELECT * INTO v_supply_after FROM t_supply WHERE id_supply = v_supply_before.id_supply;
      
      IF v_supply_str_data.summa = n_insert_qty * n_insert_price AND 
         v_supply_str_data.nds = v_supply_str_data.summa * 0.2     
      THEN
         b_is_supply_str_filled := TRUE;
      ELSE
         DBMS_OUTPUT.PUT_LINE('supply str is not filled');
      END IF; 
        
      IF v_supply_after.summa = v_supply_before.summa + v_supply_str_data.summa AND
         v_supply_after.nds = v_supply_before.nds + v_supply_str_data.nds
      THEN    
         b_is_supply_filled := TRUE;
      ELSE
         DBMS_OUTPUT.PUT_LINE('supply is not filled');   
      END IF;
      
      IF b_is_supply_str_filled AND b_is_supply_filled THEN
          DBMS_OUTPUT.PUT_LINE('TEST PASSED');
      ELSE
         DBMS_OUTPUT.PUT_LINE('TEST IS NOT PASSED!!!');
      END IF;        
      
      DBMS_OUTPUT.PUT_LINE('_____________________________________');
      
      ROLLBACK;      
   END fill_fields_on_insert;
   
   -- fill fields in supply and supply string on update test
   PROCEDURE fill_fields_on_update
   IS
      v_supply_str_before t_supply_str%ROWTYPE;
      v_supply_str_after t_supply_str%ROWTYPE;
      v_supply_before t_supply%ROWTYPE;
      v_supply_after t_supply%ROWTYPE;
      n_update_qty t_supply_str.qty%TYPE := 10;
      n_update_price t_supply_str.price%TYPE := 100;
      b_is_supply_str_filled BOOLEAN := FALSE;
      b_is_supply_filled BOOLEAN := FALSE;
      
      AUTOCOMPLETE_EXCEPTION EXCEPTION;
      PRAGMA EXCEPTION_INIT (AUTOCOMPLETE_EXCEPTION, -20010);  
   BEGIN
      DBMS_OUTPUT.PUT_LINE('_____________________________________');
      DBMS_OUTPUT.PUT_LINE('starting test on fill supply str and supply fields on update');
      
      SELECT * INTO v_supply_before FROM t_supply WHERE UPPER(e_state) = 'NEW' ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
      SELECT * INTO v_supply_str_before FROM t_supply_str WHERE id_supply = v_supply_before.id_supply ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
      
      BEGIN
         UPDATE t_supply_str SET qty = n_update_qty, price = n_update_price
         WHERE id_supply_str = v_supply_str_before.id_supply_str;
      EXCEPTION WHEN AUTOCOMPLETE_EXCEPTION THEN
         NULL;
      END;        
      
      SELECT * INTO v_supply_after FROM t_supply WHERE id_supply = v_supply_before.id_supply;
      SELECT * INTO v_supply_str_after FROM t_supply_str WHERE id_supply_str = v_supply_str_before.id_supply_str;
      
      IF v_supply_str_after.summa = n_update_qty * n_update_price AND 
         v_supply_str_after.nds = v_supply_str_after.summa * 0.2     
      THEN
         b_is_supply_str_filled := TRUE;
      ELSE
         DBMS_OUTPUT.PUT_LINE('supply str is not filled');
      END IF; 
        
      IF v_supply_after.summa = v_supply_before.summa - v_supply_str_before.summa + v_supply_str_after.summa AND
         v_supply_after.nds = v_supply_before.nds - v_supply_str_before.nds + v_supply_str_after.nds
      THEN    
         b_is_supply_filled := TRUE;
      ELSE
         DBMS_OUTPUT.PUT_LINE('supply is not filled');   
      END IF;
      
      IF b_is_supply_str_filled AND b_is_supply_filled THEN
          DBMS_OUTPUT.PUT_LINE('TEST PASSED');
      ELSE
         DBMS_OUTPUT.PUT_LINE('TEST IS NOT PASSED!!!');
      END IF;        
      
      DBMS_OUTPUT.PUT_LINE('_____________________________________');
      
      ROLLBACK;      
   END fill_fields_on_update;
   
   -- fill fields in supply on delete test
   PROCEDURE fill_fields_on_delete
   IS
      v_supply_str t_supply_str%ROWTYPE;
      v_supply_before t_supply%ROWTYPE;
      v_supply_after t_supply%ROWTYPE;
   BEGIN
      DBMS_OUTPUT.PUT_LINE('_____________________________________');
      DBMS_OUTPUT.PUT_LINE('starting test on fill supply str and supply fields on update');
      
      SELECT * INTO v_supply_before FROM t_supply WHERE UPPER(e_state) = 'NEW' ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
      SELECT * INTO v_supply_str FROM t_supply_str WHERE id_supply = v_supply_before.id_supply ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
      
      DELETE FROM t_supply_str WHERE id_supply_str = v_supply_str.id_supply_str;  
      
      SELECT * INTO v_supply_after FROM t_supply WHERE id_supply = v_supply_before.id_supply;
      
      IF v_supply_after.summa = v_supply_before.summa - v_supply_str.summa AND 
         v_supply_after.nds = v_supply_before.nds - v_supply_str.nds     
      THEN
         DBMS_OUTPUT.PUT_LINE('TEST PASSED');
      ELSE
         DBMS_OUTPUT.PUT_LINE('TEST IS NOT PASSED!!!');
      END IF; 
      
      DBMS_OUTPUT.PUT_LINE('_____________________________________');
      
      ROLLBACK;      
   END fill_fields_on_delete; 
   
 
END pkg_supply_str_tests;
/
