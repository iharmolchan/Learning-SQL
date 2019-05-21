DECLARE
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
END;
/
