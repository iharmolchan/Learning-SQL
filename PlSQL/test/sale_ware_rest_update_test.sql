DECLARE
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
END;
/
