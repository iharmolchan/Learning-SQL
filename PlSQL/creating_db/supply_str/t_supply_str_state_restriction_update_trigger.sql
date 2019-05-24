-- trigger to prevent user from updating supply strings where supply status is 'done'

CREATE OR REPLACE TRIGGER t_supply_str_state_restriction_update
BEFORE UPDATE ON t_supply_str 
FOR EACH ROW
DECLARE
   v_state_old t_supply.e_state%TYPE;
   v_state_new t_supply.e_state%TYPE;
BEGIN
   SELECT e_state INTO v_state_old FROM t_supply WHERE id_supply = :old.id_supply;
   SELECT e_state INTO v_state_new FROM t_supply WHERE id_supply = :new.id_supply;
   IF UPPER(v_state_old) = 'DONE' OR UPPER(v_state_new) = 'DONE' THEN
      RAISE_APPLICATION_ERROR(-20010,'Can''t update supplies with ''DONE'' status');
   END IF;  
END;
/
