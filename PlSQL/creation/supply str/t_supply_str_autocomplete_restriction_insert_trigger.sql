-- trigger to prevent user from inserting data into autocomplete fields

CREATE OR REPLACE TRIGGER t_supply_str_autocomplete_restriction_insert
BEFORE INSERT ON t_supply_str 
FOR EACH ROW
FOLLOWS t_supply_str_state_restiction_insert
WHEN (NEW.summa IS NOT NULL OR NEW.nds IS NOT NULL)
BEGIN
   RAISE_APPLICATION_ERROR(-20010,'can''t insert data into autocomplete fields (summa and nds)');
END;
/
