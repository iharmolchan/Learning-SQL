-- trigger to prevent user from updating sale when status is 'done'

CREATE OR REPLACE TRIGGER t_sale_done_state_restriction_update
BEFORE UPDATE ON t_sale 
FOR EACH ROW
FOLLOWS t_sale_state_restriction_update
WHEN (UPPER(OLD.e_state) = 'DONE' OR UPPER(NEW.e_state) = 'DONE')
BEGIN
   IF :new.dt != :old.dt OR :new.discount != :old.discount OR :new.summa != :old.summa OR :old.nds != :new.nds THEN
      RAISE_APPLICATION_ERROR(-20010,'can''t update sale with ''done'' status');
   END IF;
END;
/
