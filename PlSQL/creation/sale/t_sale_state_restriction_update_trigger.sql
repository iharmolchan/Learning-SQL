-- trigger to prevent user from setting sale status different from 'done' or 'new'

CREATE OR REPLACE TRIGGER t_sale_state_restriction_update
BEFORE UPDATE ON t_sale 
FOR EACH ROW
WHEN (UPPER(NEW.e_state) NOT IN ('NEW', 'DONE'))
BEGIN
   RAISE_APPLICATION_ERROR(-20010,'e_state can only be ''done'' or ''new''');
END;
/
