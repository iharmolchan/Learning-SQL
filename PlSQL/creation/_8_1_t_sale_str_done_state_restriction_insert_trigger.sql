-- trigger to prevent user from insering sale strings into sales with 'done' status

CREATE OR REPLACE TRIGGER t_sale_str_done_state_restiction_insert
BEFORE INSERT ON t_sale_str 
FOR EACH ROW
DECLARE
   v_state t_sale.e_state%TYPE;
BEGIN
   SELECT e_state INTO v_state FROM t_sale WHERE id_sale = :new.id_sale;
   IF UPPER(v_state) = 'DONE' THEN
      RAISE_APPLICATION_ERROR(-20010,'Can''t insert into sales with ''DONE'' status');
   END IF;  
END;
/
