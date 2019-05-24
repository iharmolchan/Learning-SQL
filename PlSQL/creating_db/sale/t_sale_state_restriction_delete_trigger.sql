-- trigger to prevent user from deleting sales with 'done' status

CREATE OR REPLACE TRIGGER t_sale_state_restriction_delete
BEFORE DELETE ON t_sale 
FOR EACH ROW
BEGIN
   IF UPPER(:old.e_state) = 'DONE' THEN
      RAISE_APPLICATION_ERROR(-20010,'can''t delete supply with ''done'' status');
   END IF;      
END;
/
