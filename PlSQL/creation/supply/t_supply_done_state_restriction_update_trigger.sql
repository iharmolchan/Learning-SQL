-- trigger to prevent user from updating supply when status is 'done'

CREATE OR REPLACE TRIGGER t_supply_done_state_restriction_update
BEFORE UPDATE ON t_supply 
FOR EACH ROW
FOLLOWS t_supply_state_restriction_update
WHEN (UPPER(OLD.e_state) = 'DONE' OR UPPER(NEW.e_state) = 'DONE')
BEGIN
   IF :new.dt != :old.dt OR :new.code != :old.code OR :new.num != :old.num THEN
      RAISE_APPLICATION_ERROR(-20010,'can''t update supply with ''done'' status');
   END IF;   
END;
/
