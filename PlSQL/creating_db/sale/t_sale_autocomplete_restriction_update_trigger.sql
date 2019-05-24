-- trigger to prevent user from updating data in autocomplete fields

CREATE OR REPLACE TRIGGER t_sale_autocomplete_restriction_update
AFTER UPDATE ON t_sale
FOR EACH ROW
WHEN (NEW.summa != OLD.summa OR NEW.nds != OLD.nds)
DECLARE
   mutating_error EXCEPTION;
   PRAGMA EXCEPTION_INIT(mutating_error, -4091);
   n_summa t_sale_str.summa%TYPE;
   n_nds t_sale_str.nds%TYPE;
BEGIN
   SELECT SUM(summa) INTO n_summa FROM t_sale_str WHERE id_sale = :new.id_sale;
   SELECT SUM(nds) INTO n_nds FROM t_sale_str WHERE id_sale = :new.id_sale;
   IF n_summa != :new.summa OR n_nds != :new.nds THEN
      RAISE_APPLICATION_ERROR(-20010,'can''t update data in autocomplete fields (summa and nds)');
   END IF;
EXCEPTION
  WHEN mutating_error THEN
     NULL; 
END;
/
