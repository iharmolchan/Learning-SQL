DECLARE     
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
END;
/
