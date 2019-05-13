-- trigger to prevent user from deleting supply strings where supply status is 'done'

CREATE OR REPLACE TRIGGER t_supply_str_state_restriction_delete
BEFORE DELETE ON t_supply_str 
FOR EACH ROW
DECLARE
   v_state t_supply.e_state%TYPE;
BEGIN
   SELECT e_state INTO v_state FROM t_supply WHERE id_supply = :old.id_supply;
   IF UPPER(v_state) = 'DONE' THEN
      RAISE_APPLICATION_ERROR(-20010,'Can''t delete supplies with ''DONE'' status');
   END IF;  
END;
/
