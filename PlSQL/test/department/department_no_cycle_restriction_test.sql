DECLARE
   NOCYCLE_EXCEPTION EXCEPTION;
   PRAGMA EXCEPTION_INIT (NOCYCLE_EXCEPTION, -20010);   
BEGIN
   DBMS_OUTPUT.PUT_LINE('_____________________________________');
   DBMS_OUTPUT.PUT_LINE('starting test on department no cycle restriction');
      
   UPDATE t_dept SET id_parent = id_dept;      

   DBMS_OUTPUT.PUT_LINE('TEST IS NOT PASSED!!!');   
   DBMS_OUTPUT.PUT_LINE('_____________________________________'); 
   ROLLBACK; 
EXCEPTION WHEN NOCYCLE_EXCEPTION THEN
   DBMS_OUTPUT.PUT_LINE('TEST PASSED'); 
   DBMS_OUTPUT.PUT_LINE('_____________________________________'); 
   ROLLBACK;      
END;
/
