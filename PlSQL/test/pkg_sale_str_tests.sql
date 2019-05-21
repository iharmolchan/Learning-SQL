CREATE OR REPLACE PACKAGE pkg_sale_str_tests
AS  
   PROCEDURE autocomplete_restrictions;
   PROCEDURE state_restrictions;
   PROCEDURE fill_price;
   PROCEDURE fill_fields_insert;
   PROCEDURE fill_fields_update;
   PROCEDURE fill_fields_delete;
 
END pkg_sale_str_tests;
/

CREATE OR REPLACE PACKAGE BODY pkg_sale_str_tests
AS
   -- autocomplete_restrictions
   PROCEDURE autocomplete_restrictions
   IS
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
   END autocomplete_restrictions;
   
   
   -- state_restrictions
   PROCEDURE state_restrictions
   IS
      n_sale_id t_sale.id_sale%TYPE;
      n_sale_str_id t_sale_str.id_sale_str%TYPE;
      n_ware_id t_ware.id_ware%TYPE;
      b_is_insert_test_passed BOOLEAN := FALSE;
      b_is_update_test_passed BOOLEAN := FALSE;
      b_is_delete_test_passed BOOLEAN := FALSE;
      STATE_EXCEPTION EXCEPTION;
      PRAGMA EXCEPTION_INIT(STATE_EXCEPTION, -20010);  
   BEGIN
      DBMS_OUTPUT.PUT_LINE('_____________________________________');
      DBMS_OUTPUT.PUT_LINE('starting test on sale str state restrictions');
      
      SELECT id_sale INTO n_sale_id FROM t_sale WHERE UPPER(e_state) = 'DONE' ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
      SELECT id_ware INTO n_ware_id FROM t_ware ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
      
      BEGIN            
         INSERT INTO t_sale_str (id_sale, id_ware, qty, discount)
         VALUES (n_sale_id, n_ware_id, 1, 1);
         DBMS_OUTPUT.PUT_LINE('INSERT trigger failed!');
         ROLLBACK;
      EXCEPTION WHEN STATE_EXCEPTION THEN
         b_is_insert_test_passed := TRUE;
      END;
      
      BEGIN
         SELECT id_sale_str INTO n_sale_str_id FROM t_sale_str 
         WHERE id_sale = n_sale_id ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
         UPDATE t_sale_str SET num = num + 1 WHERE id_sale_str = n_sale_str_id;
         DBMS_OUTPUT.PUT_LINE('UPDATE trigger failed!');
         ROLLBACK;
      EXCEPTION WHEN STATE_EXCEPTION THEN
         b_is_update_test_passed := TRUE;
      END state_restrictions;
     
      BEGIN
         SELECT id_sale_str INTO n_sale_str_id FROM t_sale_str 
         WHERE id_sale = n_sale_id ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
         DELETE FROM t_sale_str WHERE id_sale_str = n_sale_str_id;
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
   
   -- fill_price
   PROCEDURE fill_price
   IS
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
   END fill_price;
   
   -- fill_fields_insert
   PROCEDURE fill_fields_insert
   IS
      TYPE saleStrData IS RECORD(   
         id_sale_str t_sale_str.id_sale_str%TYPE,
         summa t_sale_str.summa%TYPE,
         nds t_sale_str.nds%TYPE,
         disc_price t_sale_str.disc_price%TYPE);      
      v_sale_str_data saleStrData;
      v_sale_before t_sale%ROWTYPE;
      v_sale_after t_sale%ROWTYPE;
      n_ware_id t_ware.id_ware%TYPE;
      n_insert_qty t_sale_str.qty%TYPE := 10;
      b_is_sale_str_filled BOOLEAN := FALSE;
      b_is_sale_filled BOOLEAN := FALSE;
   BEGIN
      DBMS_OUTPUT.PUT_LINE('_____________________________________');
      DBMS_OUTPUT.PUT_LINE('starting test on fill sale str and sale fields on insert');
      
      SELECT * INTO v_sale_before FROM t_sale WHERE UPPER(e_state) = 'NEW' ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
      SELECT id_ware INTO n_ware_id FROM t_ware ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
      
      INSERT INTO t_sale_str (id_sale, id_ware, qty)
      VALUES (v_sale_before.id_sale, n_ware_id, n_insert_qty)
      RETURNING id_sale_str, summa, nds, disc_price INTO v_sale_str_data;
      
      SELECT * INTO v_sale_after FROM t_sale WHERE id_sale = v_sale_before.id_sale;
      
      IF v_sale_str_data.summa = n_insert_qty * v_sale_str_data.disc_price AND 
         v_sale_str_data.nds = v_sale_str_data.summa * 0.2     
      THEN
         b_is_sale_str_filled := TRUE;
      ELSE
         DBMS_OUTPUT.PUT_LINE('sale str is not filled');
      END IF; 
        
      IF v_sale_after.summa = v_sale_before.summa + v_sale_str_data.summa AND
         v_sale_after.nds = v_sale_before.nds + v_sale_str_data.nds
      THEN    
         b_is_sale_filled := TRUE;
      ELSE
         DBMS_OUTPUT.PUT_LINE('sale is not filled');   
      END IF;
      
      IF b_is_sale_str_filled AND b_is_sale_filled THEN
          DBMS_OUTPUT.PUT_LINE('TEST PASSED');
      ELSE
         DBMS_OUTPUT.PUT_LINE('TEST IS NOT PASSED!!!');
      END IF;        
      
      DBMS_OUTPUT.PUT_LINE('_____________________________________');
      
      ROLLBACK;      
   END fill_fields_insert;
   
   -- fill_fields_update
   PROCEDURE fill_fields_update
   IS
      v_sale_str_before t_sale_str%ROWTYPE;
      v_sale_str_after t_sale_str%ROWTYPE;
      v_sale_before t_sale%ROWTYPE;
      v_sale_after t_sale%ROWTYPE;
      n_update_qty t_sale_str.qty%TYPE := 100;
      b_is_sale_str_filled BOOLEAN := FALSE;
      b_is_sale_filled BOOLEAN := FALSE;
      
      AUTOCOMPLETE_EXCEPTION EXCEPTION;
      PRAGMA EXCEPTION_INIT (AUTOCOMPLETE_EXCEPTION, -20010);  
   BEGIN
      DBMS_OUTPUT.PUT_LINE('_____________________________________');
      DBMS_OUTPUT.PUT_LINE('starting test on fill sale str and sale fields on update');
      
      SELECT * INTO v_sale_before FROM t_sale WHERE UPPER(e_state) = 'NEW' ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
      SELECT * INTO v_sale_str_before FROM t_sale_str WHERE id_sale = v_sale_before.id_sale ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
      
      BEGIN
         UPDATE t_sale_str SET qty = n_update_qty
         WHERE id_sale_str = v_sale_str_before.id_sale_str;
      EXCEPTION WHEN AUTOCOMPLETE_EXCEPTION THEN
         NULL;
      END;        
      
      SELECT * INTO v_sale_after FROM t_sale WHERE id_sale = v_sale_before.id_sale;
      SELECT * INTO v_sale_str_after FROM t_sale_str WHERE id_sale_str = v_sale_str_before.id_sale_str;
      
      IF v_sale_str_after.summa = n_update_qty * v_sale_str_after.disc_price AND 
         v_sale_str_after.nds = v_sale_str_after.summa * 0.2     
      THEN
         b_is_sale_str_filled := TRUE;
      ELSE
         DBMS_OUTPUT.PUT_LINE('sale str is not filled');
      END IF; 
        
      IF v_sale_after.summa = v_sale_before.summa - v_sale_str_before.summa + v_sale_str_after.summa AND
         v_sale_after.nds = v_sale_before.nds - v_sale_str_before.nds + v_sale_str_after.nds
      THEN    
         b_is_sale_filled := TRUE;
      ELSE
         DBMS_OUTPUT.PUT_LINE('sale is not filled');   
      END IF;
      
      IF b_is_sale_str_filled AND b_is_sale_filled THEN
          DBMS_OUTPUT.PUT_LINE('TEST PASSED');
      ELSE
         DBMS_OUTPUT.PUT_LINE('TEST IS NOT PASSED!!!');
      END IF;        
      
      DBMS_OUTPUT.PUT_LINE('_____________________________________');
      
      ROLLBACK;      
   END fill_fields_update;
   
   -- fill_fields_delete
   PROCEDURE fill_fields_delete
   IS
      v_sale_str t_sale_str%ROWTYPE;
      v_sale_before t_sale%ROWTYPE;
      v_sale_after t_sale%ROWTYPE;
   BEGIN
      DBMS_OUTPUT.PUT_LINE('_____________________________________');
      DBMS_OUTPUT.PUT_LINE('starting test on fill sale str and sale fields on update');
      
      SELECT * INTO v_sale_before FROM t_sale WHERE UPPER(e_state) = 'NEW' ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
      SELECT * INTO v_sale_str FROM t_sale_str WHERE id_sale = v_sale_before.id_sale ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
      
      DELETE FROM t_sale_str WHERE id_sale_str = v_sale_str.id_sale_str;  
      
      SELECT * INTO v_sale_after FROM t_sale WHERE id_sale = v_sale_before.id_sale;
      
      IF v_sale_after.summa = v_sale_before.summa - v_sale_str.summa AND 
         v_sale_after.nds = v_sale_before.nds - v_sale_str.nds     
      THEN
         DBMS_OUTPUT.PUT_LINE('TEST PASSED');
      ELSE
         DBMS_OUTPUT.PUT_LINE('TEST IS NOT PASSED!!!');
      END IF; 
      
      DBMS_OUTPUT.PUT_LINE('_____________________________________');
      
      ROLLBACK;      
   END fill_fields_delete;
 
END pkg_sale_str_tests;
/
