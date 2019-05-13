-- trigger to prevent user from updating data in autocomplete fields

CREATE OR REPLACE TRIGGER t_supply_str_autocomplete_restriction_update
AFTER UPDATE ON t_supply_str
FOR EACH ROW
WHEN (NEW.summa != (NEW.qty * NEW.price) OR NEW.nds != (NEW.summa * 0.2))
BEGIN
   RAISE_APPLICATION_ERROR(-20010,'can''t update data in autocomplete fields (summa and nds)');
END;
/
