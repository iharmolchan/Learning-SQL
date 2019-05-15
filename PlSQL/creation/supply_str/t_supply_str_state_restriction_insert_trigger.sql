-- trigger to prevent user from insering supply strings into supplies with 'done' status

CREATE OR REPLACE TRIGGER t_supply_str_state_restiction_insert
BEFORE INSERT ON t_supply_str 
FOR EACH ROW
DECLARE
   v_state t_supply.e_state%TYPE;
BEGIN
   SELECT e_state INTO v_state FROM t_supply WHERE id_supply = :new.id_supply;
   IF UPPER(v_state) = 'DONE' THEN
      RAISE_APPLICATION_ERROR(-20010,'Can''t insert into supplies with ''DONE'' status');
   END IF;  
END;
/
