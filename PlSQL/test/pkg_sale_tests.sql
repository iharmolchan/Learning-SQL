CREATE OR REPLACE PACKAGE pkg_sale_tests
AS  
   PROCEDURE autocomplete_restrictions;
   PROCEDURE state_restrictions;
   PROCEDURE closed_sale_restrictions;
   PROCEDURE out_of_stocks_restrictions;
   PROCEDURE rest_update;
   PROCEDURE rest_history_update;
   PROCEDURE sales_report_update;
   PROCEDURE update_strings_on_discount_change;
 
END pkg_sale_tests;
/

CREATE OR REPLACE PACKAGE BODY pkg_sale_tests
AS
   -- autocomplete_restrictions
   PROCEDURE autocomplete_restrictions
   IS
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
   END autocomplete_restrictions;
   
   -- state_restrictions
   PROCEDURE state_restrictions
   IS
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
   END state_restrictions;
   
   -- closed_sale_restrictions
   PROCEDURE closed_sale_restrictions
   IS
      STATUS_EXCEPTION EXCEPTION;
      PRAGMA EXCEPTION_INIT(STATUS_EXCEPTION, -20010);
      n_sale_id t_sale.id_sale%TYPE;
   BEGIN
      DBMS_OUTPUT.PUT_LINE('_____________________________________');
      DBMS_OUTPUT.PUT_LINE('starting test on sale update restriction on done status');
      
      SELECT id_sale INTO n_sale_id FROM t_sale ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
       
      UPDATE t_sale SET e_state = 'DONE', dt = SYSDATE WHERE id_sale = n_sale_id;
      
      DBMS_OUTPUT.PUT_LINE('TEST IS NOT PASSED!!!');
      DBMS_OUTPUT.PUT_LINE('_____________________________________');
      ROLLBACK;   
   EXCEPTION WHEN STATUS_EXCEPTION THEN
      DBMS_OUTPUT.PUT_LINE('TEST PASSED');
      DBMS_OUTPUT.PUT_LINE('_____________________________________');
   END closed_sale_restrictions;
   
   -- out_of_stocks_restrictions
   PROCEDURE out_of_stocks_restrictions
   IS
      STOCKS_EXCEPTION EXCEPTION;
      PRAGMA EXCEPTION_INIT(STOCKS_EXCEPTION, -20010);
      CONSTRAINT_EXCEPTION EXCEPTION;
      PRAGMA EXCEPTION_INIT(CONSTRAINT_EXCEPTION, -02290);
      v_sale_str t_sale_str%ROWTYPE;
      v_sale_id t_sale.id_sale%TYPE;
      n_stocks t_rest.qty%TYPE;
   BEGIN
      DBMS_OUTPUT.PUT_LINE('_____________________________________');
      DBMS_OUTPUT.PUT_LINE('starting test on sale out of stocks restriction');
      
      SELECT id_sale INTO v_sale_id FROM t_sale WHERE UPPER(e_state) = 'NEW' ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
      SELECT * INTO v_sale_str FROM t_sale_str WHERE id_sale = v_sale_id ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
      SELECT qty INTO n_stocks FROM t_rest WHERE id_ware = v_sale_str.id_ware; 
      UPDATE t_sale_str SET qty = n_stocks + 1 WHERE id_sale_str = v_sale_str.id_sale_str;
      UPDATE t_sale SET dt = SYSDATE WHERE id_sale = v_sale_id;
      UPDATE t_sale SET e_state = 'DONE' WHERE id_sale = v_sale_id;
      
      DBMS_OUTPUT.PUT_LINE('TEST IS NOT PASSED!!!');
      DBMS_OUTPUT.PUT_LINE('_____________________________________');
     ROLLBACK;   
   EXCEPTION 
      WHEN STOCKS_EXCEPTION THEN
         DBMS_OUTPUT.PUT_LINE('TEST PASSED');
         DBMS_OUTPUT.PUT_LINE('_____________________________________');
         ROLLBACK;
      WHEN CONSTRAINT_EXCEPTION THEN
         DBMS_OUTPUT.PUT_LINE('TEST IS NOT PASSED!!!');
         DBMS_OUTPUT.PUT_LINE('_____________________________________');
         ROLLBACK;
   END out_of_stocks_restrictions;
   
   -- rest_update
   PROCEDURE rest_update
   IS
      TYPE inputData IS RECORD(
         sale_id t_sale.id_sale%TYPE,
         ware_id t_ware.id_ware%TYPE,
         quantity t_sale_str.qty%TYPE);
      v_input_data inputData;
      n_rest_qty_before t_rest.qty%TYPE;
      n_rest_qty_after t_rest.qty%TYPE;
      b_is_execute_supply_test_passed BOOLEAN := FALSE;
      b_is_undo_supply_test_passed BOOLEAN := FALSE;      
   BEGIN
      DBMS_OUTPUT.PUT_LINE('_____________________________________');
      DBMS_OUTPUT.PUT_LINE('starting sale update rest test');

      SELECT id_sale, id_ware, SUM(qty) INTO v_input_data FROM t_sale_str INNER JOIN t_sale USING (id_sale) 
      WHERE UPPER(e_state) = 'NEW' GROUP BY id_sale, id_ware 
      ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
      
      BEGIN
         SELECT qty INTO n_rest_qty_before FROM t_rest WHERE id_ware = v_input_data.ware_id;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         n_rest_qty_before := 0;
      END;
      
      UPDATE t_sale SET e_state = 'DONE' WHERE id_sale = v_input_data.sale_id;
      
      BEGIN
         SELECT qty INTO n_rest_qty_after FROM t_rest WHERE id_ware = v_input_data.ware_id;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         n_rest_qty_after := 0;
      END;
       
      IF n_rest_qty_after = n_rest_qty_before - v_input_data.quantity THEN
         b_is_execute_supply_test_passed := TRUE;
      ELSE
         DBMS_OUTPUT.PUT_LINE('trigger failed when supply is executed!');
      END IF;
      
      UPDATE t_sale SET e_state = 'NEW' WHERE id_sale = v_input_data.sale_id;
      
      BEGIN
         SELECT qty INTO n_rest_qty_before FROM t_rest WHERE id_ware = v_input_data.ware_id;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         n_rest_qty_after := 0;
      END;
      
      IF n_rest_qty_before = n_rest_qty_after + v_input_data.quantity THEN
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
         sale_id t_sale.id_sale%TYPE,
         sale_date t_sale.dt%TYPE,
         ware_id t_ware.id_ware%TYPE,
         quantity t_sale_str.qty%TYPE);
      v_input_data inputData;
      n_rest_qty_before t_rest_hist.qty%TYPE;
      n_rest_qty_after t_rest_hist.qty%TYPE;
      b_is_execute_sale_test_passed BOOLEAN := FALSE;
      b_is_undo_sale_test_passed BOOLEAN := FALSE;      
   BEGIN
      DBMS_OUTPUT.PUT_LINE('_____________________________________');
      DBMS_OUTPUT.PUT_LINE('starting sale update rest test');

      SELECT id_sale, dt, id_ware, SUM(qty) INTO v_input_data 
      FROM t_sale_str INNER JOIN t_sale USING (id_sale) 
      WHERE UPPER(e_state) = 'NEW' GROUP BY id_sale, id_ware, dt 
      ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
       
      BEGIN
         SELECT qty INTO n_rest_qty_before FROM t_rest_hist 
         WHERE id_ware = v_input_data.ware_id AND dt_beg = v_input_data.sale_date;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         BEGIN
            SELECT qty INTO n_rest_qty_before FROM t_rest_hist 
            WHERE id_ware = v_input_data.ware_id AND dt_beg < v_input_data.sale_date 
            ORDER BY dt_beg DESC FETCH FIRST 1 ROW ONLY;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            n_rest_qty_before := 0;   
         END;   
      END;
      
      UPDATE t_sale SET e_state = 'DONE' WHERE id_sale = v_input_data.sale_id;
      
      BEGIN
         SELECT qty INTO n_rest_qty_after FROM t_rest_hist 
         WHERE id_ware = v_input_data.ware_id AND dt_beg = v_input_data.sale_date;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         NULL;
      END;
      
      IF n_rest_qty_after = n_rest_qty_before - v_input_data.quantity THEN
         b_is_execute_sale_test_passed := TRUE;
      ELSE
         DBMS_OUTPUT.PUT_LINE('trigger failed when sale is executed!');
      END IF;
      
      IF b_is_execute_sale_test_passed THEN
         UPDATE t_sale SET e_state = 'NEW' WHERE id_sale = v_input_data.sale_id;
      
         BEGIN
            SELECT qty INTO n_rest_qty_before FROM t_rest_hist 
            WHERE id_ware = v_input_data.ware_id AND dt_beg = v_input_data.sale_date;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            NULL;
         END;
      
         IF n_rest_qty_before = n_rest_qty_after + v_input_data.quantity THEN
            b_is_undo_sale_test_passed := TRUE;
         ELSE
           DBMS_OUTPUT.PUT_LINE('trigger failed when sale is undone!');
        END IF;
      END IF;

      IF b_is_execute_sale_test_passed AND b_is_undo_sale_test_passed THEN
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
         sale_id t_sale.id_sale%TYPE,
         sale_date t_sale.dt%TYPE,
         ware_id t_ware.id_ware%TYPE,
         quantity t_sale_str.qty%TYPE,
         summa t_sale_str.summa%TYPE);
      v_input_data inputData;
      v_sale_before t_sale_rep%ROWTYPE;
      v_sale_after t_sale_rep%ROWTYPE;
      b_is_execute_sale_test_passed BOOLEAN := FALSE;
      b_is_undo_sale_test_passed BOOLEAN := FALSE;      
   BEGIN
      DBMS_OUTPUT.PUT_LINE('_____________________________________');
      DBMS_OUTPUT.PUT_LINE('starting sale update sales report test');

      SELECT id_sale, dt, id_ware, SUM(qty), SUM(st.summa) INTO v_input_data FROM t_sale_str st INNER JOIN t_sale USING (id_sale) 
      WHERE UPPER(e_state) = 'NEW' GROUP BY id_sale, id_ware, dt 
      ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
      
      BEGIN
         SELECT * INTO v_sale_before FROM t_sale_rep 
         WHERE id_ware = v_input_data.ware_id AND month = TRUNC(v_input_data.sale_date, 'MM');
      EXCEPTION WHEN NO_DATA_FOUND THEN
         NULL;
      END;
      
      UPDATE t_sale SET e_state = 'DONE' WHERE id_sale = v_input_data.sale_id;
      
      BEGIN
         SELECT * INTO v_sale_after FROM t_sale_rep 
         WHERE id_ware = v_input_data.ware_id AND month = TRUNC(v_input_data.sale_date, 'MM');
      EXCEPTION WHEN NO_DATA_FOUND THEN
         NULL;
      END;
       
      IF NVL(v_sale_after.sale_qty, 0) = NVL(v_sale_before.sale_qty, 0) + v_input_data.quantity AND
         NVL(v_sale_after.sale_sum, 0) = NVL(v_sale_before.sale_sum, 0) + v_input_data.summa  THEN
         b_is_execute_sale_test_passed := TRUE;
      ELSE
         DBMS_OUTPUT.PUT_LINE('trigger failed when sale is executed!');
      END IF;
      
      UPDATE t_sale SET e_state = 'NEW' WHERE id_sale = v_input_data.sale_id;
      
      BEGIN
         SELECT * INTO v_sale_before FROM t_sale_rep 
         WHERE id_ware = v_input_data.ware_id AND month = TRUNC(v_input_data.sale_date, 'MM');
      EXCEPTION WHEN NO_DATA_FOUND THEN
         NULL;
      END;
      
      IF NVL(v_sale_before.sale_qty, 0) = NVL(v_sale_after.sale_qty, 0) - v_input_data.quantity AND
         NVL(v_sale_before.sale_sum, 0) = NVL(v_sale_after.sale_sum, 0) - v_input_data.summa  THEN
         b_is_undo_sale_test_passed := TRUE;
      ELSE
         DBMS_OUTPUT.PUT_LINE('trigger failed when sale is undone!');
      END IF;

      IF b_is_execute_sale_test_passed AND b_is_undo_sale_test_passed THEN
         DBMS_OUTPUT.PUT_LINE('TEST PASSED');
      ELSE
         DBMS_OUTPUT.PUT_LINE('TEST IS NOT PASSED!!!');
      END IF;
      
      ROLLBACK;
      
      DBMS_OUTPUT.PUT_LINE('_____________________________________');
   END sales_report_update;
   
   -- update_strings_on_discount_change
   PROCEDURE update_strings_on_discount_change
   IS
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
   END update_strings_on_discount_change;  
 
END pkg_sale_tests;
/
