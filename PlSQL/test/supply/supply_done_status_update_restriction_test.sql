DECLARE
   STATUS_EXCEPTION EXCEPTION;
   PRAGMA EXCEPTION_INIT(STATUS_EXCEPTION, -20010);
   n_supply_id t_supply.id_supply%TYPE;
BEGIN
   DBMS_OUTPUT.PUT_LINE('_____________________________________');
   DBMS_OUTPUT.PUT_LINE('starting test on supply update restriction on done status');
   
   SELECT id_supply INTO n_supply_id FROM t_supply ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
   
   UPDATE t_supply SET e_state = 'DONE', dt = SYSDATE WHERE id_supply = n_supply_id;
   
   DBMS_OUTPUT.PUT_LINE('TEST IS NOT PASSED!!!');
   DBMS_OUTPUT.PUT_LINE('_____________________________________');
   ROLLBACK;   
EXCEPTION WHEN STATUS_EXCEPTION THEN
   DBMS_OUTPUT.PUT_LINE('TEST PASSED');
   DBMS_OUTPUT.PUT_LINE('_____________________________________');
END;
/
