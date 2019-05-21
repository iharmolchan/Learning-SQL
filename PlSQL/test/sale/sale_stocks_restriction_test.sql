DECLARE
   STOCKS_EXCEPTION EXCEPTION;
   PRAGMA EXCEPTION_INIT(STOCKS_EXCEPTION, -20010);
   CONSTRAINT_EXCEPTION EXCEPTION;
   PRAGMA EXCEPTION_INIT(CONSTRAINT_EXCEPTION, -02290);
   v_sale_str t_sale_str%ROWTYPE;
   v_sale_id t_sale.id_sale%TYPE;
   n_stocks t_rest.qty%TYPE;
BEGIN
   DBMS_OUTPUT.PUT_LINE('_____________________________________');
   DBMS_OUTPUT.PUT_LINE('starting test on sale out of stocks restriction');
   
   SELECT id_sale INTO v_sale_id FROM t_sale WHERE UPPER(e_state) = 'NEW' ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
   SELECT * INTO v_sale_str FROM t_sale_str WHERE id_sale = v_sale_id ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
   SELECT qty INTO n_stocks FROM t_rest WHERE id_ware = v_sale_str.id_ware; 
   UPDATE t_sale_str SET qty = n_stocks + 1 WHERE id_sale_str = v_sale_str.id_sale_str;
   UPDATE t_sale SET dt = SYSDATE WHERE id_sale = v_sale_id;
   UPDATE t_sale SET e_state = 'DONE' WHERE id_sale = v_sale_id;
   
   DBMS_OUTPUT.PUT_LINE('TEST IS NOT PASSED!!!');
   DBMS_OUTPUT.PUT_LINE('_____________________________________');
   ROLLBACK;   
EXCEPTION 
   WHEN STOCKS_EXCEPTION THEN
      DBMS_OUTPUT.PUT_LINE('TEST PASSED');
      DBMS_OUTPUT.PUT_LINE('_____________________________________');
      ROLLBACK;
   WHEN CONSTRAINT_EXCEPTION THEN
      DBMS_OUTPUT.PUT_LINE('TEST IS NOT PASSED!!!');
      DBMS_OUTPUT.PUT_LINE('_____________________________________');
      ROLLBACK;
END;
/
