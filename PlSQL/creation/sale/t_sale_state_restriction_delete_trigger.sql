-- trigger to prevent user from deleting sales with 'done' status

CREATE OR REPLACE TRIGGER t_sale_state_restriction_delete
BEFORE DELETE ON t_sale 
FOR EACH ROW
DECLARE
   PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
   IF UPPER(:old.e_state) = 'DONE' THEN
      RAISE_APPLICATION_ERROR(-20010,'can''t delete sale with ''done'' status');
   ELSE
      EXECUTE IMMEDIATE 'ALTER TRIGGER t_sale_str_done_state_restriction_delete DISABLE';
      EXECUTE IMMEDIATE 'ALTER TRIGGER t_sale_fill_summa_nds_delete DISABLE';
   END IF;      
END;
/
