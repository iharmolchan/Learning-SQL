-- trigger to prevent user from deleting sale strings where supply status is 'done'

CREATE OR REPLACE TRIGGER t_sale_str_done_state_restriction_delete
BEFORE DELETE ON t_sale_str 
FOR EACH ROW
DECLARE
   v_state t_sale.e_state%TYPE;
BEGIN
   SELECT e_state INTO v_state FROM t_sale WHERE id_sale = :old.id_sale;
   IF UPPER(v_state) = 'DONE' THEN
      RAISE_APPLICATION_ERROR(-20010,'Can''t delete sales with ''DONE'' status');
   END IF;  
END;
/
