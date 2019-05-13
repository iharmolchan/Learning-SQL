-- trigger to prevent user from deleting supplies with 'done' status

CREATE OR REPLACE TRIGGER t_supply_state_restriction_delete
BEFORE DELETE ON t_supply 
FOR EACH ROW
BEGIN
   IF UPPER(:old.e_state) = 'DONE' THEN
      RAISE_APPLICATION_ERROR(-20010,'can''t delete supply with ''done'' status');
   END IF;      
END;
/
