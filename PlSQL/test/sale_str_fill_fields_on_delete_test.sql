DECLARE     
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
END;
/
