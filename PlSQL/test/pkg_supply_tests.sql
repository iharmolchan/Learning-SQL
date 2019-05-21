CREATE OR REPLACE PACKAGE pkg_supply_tests
AS  
   PROCEDURE autocomplete_restrictions;
   PROCEDURE state_restrictions;
   PROCEDURE closed_supply_restriction;
   PROCEDURE rest_update;
   PROCEDURE rest_history_update;
   PROCEDURE sales_report_update;
 
END pkg_supply_tests;
/

CREATE OR REPLACE PACKAGE BODY pkg_supply_tests
AS
   -- autocomplete_restrictions
   PROCEDURE autocomplete_restrictions
   IS
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
   END autocomplete_restrictions;
   
   -- state_restrictions
   PROCEDURE state_restrictions
   IS
      n_supply_id t_supply.id_supply%TYPE;
      n_supplier_id t_supplier.id_supplier%TYPE;
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
         SELECT id_supplier INTO n_supplier_id FROM t_supplier ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
         INSERT INTO t_supply (dt, id_supplier, e_state)
         VALUES (SYSDATE, n_supplier_id, v_status_test);
         DBMS_OUTPUT.PUT_LINE('INSERT trigger failed!');
         ROLLBACK;
      EXCEPTION WHEN STATE_EXCEPTION THEN
         b_is_insert_test_passed := TRUE;
      END;
      
      BEGIN
         SELECT id_supply INTO n_supply_id FROM t_supply ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
         UPDATE t_supply SET e_state = v_status_test WHERE id_supply = n_supply_id;
        DBMS_OUTPUT.PUT_LINE('UPDATE trigger failed!');
         ROLLBACK;
      EXCEPTION WHEN STATE_EXCEPTION THEN
         b_is_update_test_passed := TRUE;
      END;
     
      BEGIN
         SELECT id_supply INTO n_supply_id FROM t_supply ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
         UPDATE t_supply SET e_state = v_status_done WHERE id_supply = n_supply_id;
         DELETE FROM t_supply WHERE id_supply = n_supply_id;
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
   END state_restrictions;
   
   
   -- closed_supply_restriction
   PROCEDURE closed_supply_restriction
   IS
      STATUS_EXCEPTION EXCEPTION;
      PRAGMA EXCEPTION_INIT(STATUS_EXCEPTION, -20010);
      n_supply_id t_supply.id_supply%TYPE;
   BEGIN
      DBMS_OUTPUT.PUT_LINE('_____________________________________');
      DBMS_OUTPUT.PUT_LINE('starting test on supply update restriction on done status');
      
      SELECT id_supply INTO n_supply_id FROM t_supply ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
      
      UPDATE t_supply SET e_state = 'DONE', dt = SYSDATE WHERE id_supply = n_supply_id;
      
      DBMS_OUTPUT.PUT_LINE('TEST IS NOT PASSED!!!');
      DBMS_OUTPUT.PUT_LINE('_____________________________________');
      ROLLBACK;   
   EXCEPTION WHEN STATUS_EXCEPTION THEN
      DBMS_OUTPUT.PUT_LINE('TEST PASSED');
      DBMS_OUTPUT.PUT_LINE('_____________________________________');
   END closed_supply_restriction;
   
   -- rest_update
   PROCEDURE rest_update
   IS
      TYPE inputData IS RECORD(
         supply_id t_supply.id_supply%TYPE,
         ware_id t_ware.id_ware%TYPE,
         quantity t_supply_str.qty%TYPE);
      v_input_data inputData;
      n_rest_qty_before t_rest.qty%TYPE;
      n_rest_qty_after t_rest.qty%TYPE;
      b_is_execute_supply_test_passed BOOLEAN := FALSE;
      b_is_undo_supply_test_passed BOOLEAN := FALSE;      
   BEGIN
      DBMS_OUTPUT.PUT_LINE('_____________________________________');
      DBMS_OUTPUT.PUT_LINE('starting supply update rest test');

      SELECT id_supply, id_ware, SUM(qty) INTO v_input_data FROM t_supply_str INNER JOIN t_supply USING (id_supply) 
      WHERE UPPER(e_state) = 'NEW' GROUP BY id_supply, id_ware 
      ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
      
      BEGIN
         SELECT qty INTO n_rest_qty_before FROM t_rest WHERE id_ware = v_input_data.ware_id;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         n_rest_qty_before := 0;
      END;
      
      UPDATE t_supply SET e_state = 'DONE' WHERE id_supply = v_input_data.supply_id;
      
      BEGIN
        SELECT qty INTO n_rest_qty_after FROM t_rest WHERE id_ware = v_input_data.ware_id;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         n_rest_qty_after := 0;
      END;
      
      IF n_rest_qty_after = n_rest_qty_before + v_input_data.quantity THEN
         b_is_execute_supply_test_passed := TRUE;
      ELSE
         DBMS_OUTPUT.PUT_LINE('trigger failed when supply is executed!');
      END IF;
      
      UPDATE t_supply SET e_state = 'NEW' WHERE id_supply = v_input_data.supply_id;
      
      BEGIN
         SELECT qty INTO n_rest_qty_before FROM t_rest WHERE id_ware = v_input_data.ware_id;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         n_rest_qty_after := 0;
      END;
      
      IF n_rest_qty_before = n_rest_qty_after - v_input_data.quantity THEN
         b_is_undo_supply_test_passed := TRUE;
      ELSE
         DBMS_OUTPUT.PUT_LINE('trigger failed when supply is undone!');
      END IF;

      IF b_is_execute_supply_test_passed AND b_is_undo_supply_test_passed THEN
         DBMS_OUTPUT.PUT_LINE('TEST PASSED');
      ELSE
         DBMS_OUTPUT.PUT_LINE('TEST IS NOT PASSED!!!');
      END IF;
      
      ROLLBACK;
      
      DBMS_OUTPUT.PUT_LINE('_____________________________________');
   END rest_update;
   
   -- rest_history_update
   PROCEDURE rest_history_update
   IS
      TYPE inputData IS RECORD(
         supply_id t_supply.id_supply%TYPE,
         supply_date t_supply.dt%TYPE,
         ware_id t_ware.id_ware%TYPE,
         quantity t_supply_str.qty%TYPE);
      v_input_data inputData;
      n_rest_qty_before t_rest_hist.qty%TYPE;
      n_rest_qty_after t_rest_hist.qty%TYPE;
      b_is_execute_supply_test_passed BOOLEAN := FALSE;
      b_is_undo_supply_test_passed BOOLEAN := FALSE;      
   BEGIN
      DBMS_OUTPUT.PUT_LINE('_____________________________________');
      DBMS_OUTPUT.PUT_LINE('starting supply update rest test');

      SELECT id_supply, dt, id_ware, SUM(qty) INTO v_input_data 
      FROM t_supply_str INNER JOIN t_supply USING (id_supply) 
      WHERE UPPER(e_state) = 'NEW' GROUP BY id_supply, id_ware, dt 
      ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
      
      BEGIN
         SELECT qty INTO n_rest_qty_before FROM t_rest_hist 
         WHERE id_ware = v_input_data.ware_id AND dt_beg = v_input_data.supply_date;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         BEGIN
            SELECT qty INTO n_rest_qty_before FROM t_rest_hist 
            WHERE id_ware = v_input_data.ware_id AND dt_beg < v_input_data.supply_date 
            ORDER BY dt_beg DESC FETCH FIRST 1 ROW ONLY;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            n_rest_qty_before := 0;   
         END;   
      END;
      
      UPDATE t_supply SET e_state = 'DONE' WHERE id_supply = v_input_data.supply_id;
      
      BEGIN
         SELECT qty INTO n_rest_qty_after FROM t_rest_hist 
         WHERE id_ware = v_input_data.ware_id AND dt_beg = v_input_data.supply_date;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         NULL;
      END;
      
      IF n_rest_qty_after = n_rest_qty_before + v_input_data.quantity THEN
         b_is_execute_supply_test_passed := TRUE;
      ELSE
         DBMS_OUTPUT.PUT_LINE('trigger failed when supply is executed!');
      END IF;
      
      IF b_is_execute_supply_test_passed THEN
         UPDATE t_supply SET e_state = 'NEW' WHERE id_supply = v_input_data.supply_id;
      
         BEGIN
            SELECT qty INTO n_rest_qty_before FROM t_rest_hist 
            WHERE id_ware = v_input_data.ware_id AND dt_beg = v_input_data.supply_date;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            NULL;
         END;
      
         IF n_rest_qty_before = n_rest_qty_after - v_input_data.quantity THEN
            b_is_undo_supply_test_passed := TRUE;
         ELSE
            DBMS_OUTPUT.PUT_LINE('trigger failed when supply is undone!');
        END IF;
      END IF;

      IF b_is_execute_supply_test_passed AND b_is_undo_supply_test_passed THEN
         DBMS_OUTPUT.PUT_LINE('TEST PASSED');
      ELSE
         DBMS_OUTPUT.PUT_LINE('TEST IS NOT PASSED!!!');
      END IF;
      
      ROLLBACK;
      
      DBMS_OUTPUT.PUT_LINE('_____________________________________');
   END rest_history_update;
   
   -- sales_report_update
   PROCEDURE sales_report_update
   IS
      TYPE inputData IS RECORD(
         supply_id t_supply.id_supply%TYPE,
         supply_date t_supply.dt%TYPE,
         ware_id t_ware.id_ware%TYPE,
         quantity t_supply_str.qty%TYPE,
         summa t_supply_str.summa%TYPE);
      v_input_data inputData;
      v_supply_before t_sale_rep%ROWTYPE;
      v_supply_after t_sale_rep%ROWTYPE;
      b_is_execute_supply_test_passed BOOLEAN := FALSE;
      b_is_undo_supply_test_passed BOOLEAN := FALSE;      
   BEGIN
      DBMS_OUTPUT.PUT_LINE('_____________________________________');
      DBMS_OUTPUT.PUT_LINE('starting supply update sales report test');

      SELECT id_supply, dt, id_ware, SUM(qty), SUM(st.summa) INTO v_input_data FROM t_supply_str st INNER JOIN t_supply USING (id_supply) 
      WHERE UPPER(e_state) = 'NEW' GROUP BY id_supply, id_ware, dt 
      ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
      
      BEGIN
         SELECT * INTO v_supply_before FROM t_sale_rep 
         WHERE id_ware = v_input_data.ware_id AND month = TRUNC(v_input_data.supply_date, 'MM');
      EXCEPTION WHEN NO_DATA_FOUND THEN
         NULL;
      END;
      
      UPDATE t_supply SET e_state = 'DONE' WHERE id_supply = v_input_data.supply_id;
      
      BEGIN
         SELECT * INTO v_supply_after FROM t_sale_rep 
         WHERE id_ware = v_input_data.ware_id AND month = TRUNC(v_input_data.supply_date, 'MM');
      EXCEPTION WHEN NO_DATA_FOUND THEN
         NULL;
      END;
      
      IF NVL(v_supply_after.supply_qty, 0) = NVL(v_supply_before.supply_qty, 0) + v_input_data.quantity AND
         NVL(v_supply_after.supply_sum, 0) = NVL(v_supply_before.supply_sum, 0) + v_input_data.summa  THEN
         b_is_execute_supply_test_passed := TRUE;
      ELSE
         DBMS_OUTPUT.PUT_LINE('trigger failed when supply is executed!');
      END IF;
      
      UPDATE t_supply SET e_state = 'NEW' WHERE id_supply = v_input_data.supply_id;
      
      BEGIN
         SELECT * INTO v_supply_before FROM t_sale_rep 
         WHERE id_ware = v_input_data.ware_id AND month = TRUNC(v_input_data.supply_date, 'MM');
      EXCEPTION WHEN NO_DATA_FOUND THEN
         NULL;
      END;
      
      IF NVL(v_supply_before.supply_qty, 0) = NVL(v_supply_after.supply_qty, 0) - v_input_data.quantity AND
         NVL(v_supply_before.supply_sum, 0) = NVL(v_supply_after.supply_sum, 0) - v_input_data.summa  THEN
         b_is_undo_supply_test_passed := TRUE;
      ELSE
         DBMS_OUTPUT.PUT_LINE('trigger failed when supply is undone!');
      END IF;

      IF b_is_execute_supply_test_passed AND b_is_undo_supply_test_passed THEN
         DBMS_OUTPUT.PUT_LINE('TEST PASSED');
      ELSE
         DBMS_OUTPUT.PUT_LINE('TEST IS NOT PASSED!!!');
      END IF;
      
      ROLLBACK;
      
      DBMS_OUTPUT.PUT_LINE('_____________________________________');
   END sales_report_update; 
 
END pkg_supply_tests;
/
