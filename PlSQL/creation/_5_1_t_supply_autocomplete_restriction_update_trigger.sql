-- trigger to prevent user from updating data in autocomplete fields

CREATE OR REPLACE TRIGGER t_supply_autocomplete_restriction_update
after UPDATE ON t_supply
FOR EACH ROW
WHEN (NEW.summa != OLD.summa OR NEW.nds != OLD.nds)
DECLARE
   mutating_error EXCEPTION;
   PRAGMA EXCEPTION_INIT(mutating_error, -4091);
   n_summa t_supply_str.summa%TYPE;
   n_nds t_supply_str.nds%TYPE;
BEGIN
   SELECT SUM(summa) INTO n_summa FROM t_supply_str WHERE id_supply = :new.id_supply;
   SELECT SUM(nds) INTO n_nds FROM t_supply_str WHERE id_supply = :new.id_supply;
   IF n_summa != :new.summa OR n_nds != :new.nds THEN
      RAISE_APPLICATION_ERROR(-20010,'can''t update data in autocomplete fields (summa and nds)');
   END IF;
EXCEPTION
  WHEN mutating_error THEN
     NULL; 
END;
/
