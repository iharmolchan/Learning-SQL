-- trigger to prevent user from creating supplies with status different from 'new'

CREATE OR REPLACE TRIGGER t_supply_state_restriction_insert
BEFORE INSERT ON t_supply 
FOR EACH ROW
WHEN (UPPER(NEW.e_state) != 'NEW')
BEGIN
   RAISE_APPLICATION_ERROR(-20010,'for new supplies e_state can only be ''new''');
END;
/
