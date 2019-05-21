CREATE OR REPLACE PACKAGE pkg_department_tests
AS     
   PROCEDURE no_cycle_restriction; 
END pkg_department_tests;
/

CREATE OR REPLACE PACKAGE BODY pkg_department_tests
AS

   RESTRICTION_EXCEPTION EXCEPTION;
   PRAGMA EXCEPTION_INIT (RESTRICTION_EXCEPTION, -20010);  

   PROCEDURE no_cycle_restriction
   IS 
   BEGIN
      DBMS_OUTPUT.PUT_LINE('_____________________________________');
      DBMS_OUTPUT.PUT_LINE('starting test on department no cycle restriction');
         
      UPDATE t_dept SET id_parent = id_dept;      

      DBMS_OUTPUT.PUT_LINE('TEST IS NOT PASSED!!!');   
      DBMS_OUTPUT.PUT_LINE('_____________________________________'); 
      ROLLBACK; 
   EXCEPTION WHEN RESTRICTION_EXCEPTION THEN
      DBMS_OUTPUT.PUT_LINE('TEST PASSED'); 
      DBMS_OUTPUT.PUT_LINE('_____________________________________'); 
      ROLLBACK;      
   END;
     
END pkg_department_tests;
/
