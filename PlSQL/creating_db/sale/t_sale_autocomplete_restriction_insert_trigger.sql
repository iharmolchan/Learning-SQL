-- trigger to prevent user from inserting data into autocomplete fields

CREATE OR REPLACE TRIGGER t_sale_autocomplete_restriction_insert
BEFORE INSERT ON t_sale 
FOR EACH ROW
WHEN (NEW.summa IS NOT NULL OR NEW.nds IS NOT NULL)
BEGIN
   RAISE_APPLICATION_ERROR(-20010,'can''t insert data into autocomplete fields (summa and nds)');
END;
/
