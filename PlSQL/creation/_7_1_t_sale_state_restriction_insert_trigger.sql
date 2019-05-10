-- trigger to prevent user from creating sales with status different from 'new'

CREATE OR REPLACE TRIGGER t_sale_state_restriction_insert
BEFORE INSERT ON t_sale 
FOR EACH ROW
WHEN (UPPER(NEW.e_state) != 'NEW')
BEGIN
   RAISE_APPLICATION_ERROR(-20010,'for new sales e_state can only be ''new''');
END;
/
