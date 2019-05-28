--creating user for grodno sales department
CREATE USER grodno_region IDENTIFIED BY grodno_region;

-- granting some privelleges all priveleges on sale table to user
GRANT CONNECT TO grodno_region;
GRANT ALL ON shop.t_sale TO grodno_region;
-- granting rights to write statistics
GRANT SELECT ON sys.V_$SESSION TO grodno_region;
GRANT SELECT ON sys.V_$SESSTAT TO grodno_region;
GRANT SELECT ON sys.V_$STATNAME TO grodno_region;

-------------------------------------------------------------------------------
-- CREATING CONTEXT TO SHOP APP  (under shop user)

-- granting context creation privelegy to shop (under system user)
GRANT CREATE ANY CONTEXT TO shop;

--creating context package
CREATE OR REPLACE PACKAGE shop_context 
AS
   PROCEDURE select_dept_id ;
END;

--creating package body
CREATE OR REPLACE PACKAGE BODY shop_context 
AS
   PROCEDURE select_dept_id
   IS
      dept_id NUMBER;
   BEGIN
      SELECT 
         id_dept 
      INTO 
         dept_id 
      FROM 
         shop.t_dept 
      WHERE
         UPPER(name) = REPLACE(sys_context('USERENV', 'SESSION_USER'), '_', ' ');      
      dbms_session.set_context('department_info', 'dept_id', dept_id);
   EXCEPTION WHEN NO_DATA_FOUND THEN
      dbms_session.set_context('department_info', 'dept_id', NULL);        
   END select_dept_id;
END;

-- creating context using package created previously
CREATE CONTEXT department_info USING shop_context;

-- creating trigger to add department id to context
CREATE OR REPLACE TRIGGER shop.security_context
AFTER LOGON ON DATABASE
BEGIN
  shop_context.select_dept_id;
END;

-------------------------------------------------------------------------------------------
-- VPD FGAC

-- security package
CREATE OR REPLACE PACKAGE shop_security 
AS
   FUNCTION deptid_sec (object_schema VARCHAR2, object_name VARCHAR2) RETURN VARCHAR2;
END;

-- security package body
CREATE OR REPLACE PACKAGE BODY shop_security 
AS
   -- object_schema is the schema owning the table of view.
   -- object_name is the name of table, view, or synonym to which the policy applies. 
   FUNCTION deptid_sec (object_schema VARCHAR2, object_name VARCHAR2) RETURN VARCHAR2
   IS
      d_predicate VARCHAR2 (2000);
   BEGIN
       IF sys_context('department_info', 'dept_id') IS NOT NULL THEN
          d_predicate := 'id_client IN(SELECT id_client FROM shop.t_client WHERE id_dept = sys_context(''department_info'', ''dept_id''))';
       END IF;      
       RETURN d_predicate; 
   END deptid_sec;   
END shop_security;

------------------------------------------------------------------------------------------------------------
-- adding policy (under system user)
BEGIN
 dbms_rls.add_policy('shop','t_sale','manager_policy','shop','shop_security.deptid_sec', 'select');
END;

-- almost the same to above statement
BEGIN
   dbms_rls.add_policy(
      object_schema => 'shop',
      object_name => 't_sale',
      policy_name => 'manager_policy',
      function_schema => 'shop',
      policy_function => 'shop_security.deptid_sec',
      --statement_types => 'select' -- deafault: select, insert, update, delete (exepting index)
      update_check => TRUE);
END;


-- add column security policy
BEGIN
   dbms_rls.add_policy(
      object_schema => 'shop',
      object_name => 't_sale',
      policy_name => 'manager_policy',
      function_schema => 'shop',
      policy_function => 'shop_security.deptid_sec',
      statement_types => 'select',
      sec_relevant_cols => 'summa, nds'); -- just add columns nedded to be controled by policy
END;

