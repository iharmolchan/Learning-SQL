DECLARE
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
END;
/
