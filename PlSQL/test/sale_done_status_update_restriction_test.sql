DECLARE
   STATUS_EXCEPTION EXCEPTION;
   PRAGMA EXCEPTION_INIT(STATUS_EXCEPTION, -20010);
   n_sale_id t_sale.id_sale%TYPE;
BEGIN
   DBMS_OUTPUT.PUT_LINE('_____________________________________');
   DBMS_OUTPUT.PUT_LINE('starting test on sale update restriction on done status');
   
   SELECT id_sale INTO n_sale_id FROM t_sale ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
   
   UPDATE t_sale SET e_state = 'DONE', dt = SYSDATE WHERE id_sale = n_sale_id;
   
   DBMS_OUTPUT.PUT_LINE('TEST IS NOT PASSED!!!');
   DBMS_OUTPUT.PUT_LINE('_____________________________________');
   ROLLBACK;   
EXCEPTION WHEN STATUS_EXCEPTION THEN
   DBMS_OUTPUT.PUT_LINE('TEST PASSED');
   DBMS_OUTPUT.PUT_LINE('_____________________________________');
END;
/
