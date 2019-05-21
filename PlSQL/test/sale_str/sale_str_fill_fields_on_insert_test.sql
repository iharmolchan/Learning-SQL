DECLARE
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
END;
/
