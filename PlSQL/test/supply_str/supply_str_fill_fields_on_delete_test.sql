DECLARE     
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
END;
/
