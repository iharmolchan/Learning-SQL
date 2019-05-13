-- trigger to prevent user from updating sale strings where sale status is 'done'

CREATE OR REPLACE TRIGGER t_sale_str_state_restriction_update
BEFORE UPDATE ON t_sale_str 
FOR EACH ROW
DECLARE
   v_state_old t_sale.e_state%TYPE;
   v_state_new t_sale.e_state%TYPE;
BEGIN
   SELECT e_state INTO v_state_old FROM t_sale WHERE id_sale = :old.id_sale;
   SELECT e_state INTO v_state_new FROM t_sale WHERE id_sale = :new.id_sale;
   IF UPPER(v_state_old) = 'DONE' OR UPPER(v_state_new) = 'DONE' THEN
      RAISE_APPLICATION_ERROR(-20010,'Can''t update sales with ''DONE'' status');
   END IF;  
END;
/
