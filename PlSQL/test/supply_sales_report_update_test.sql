DECLARE
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
END;
