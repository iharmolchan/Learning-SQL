DECLARE     
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
END;
/
