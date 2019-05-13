-- trigger to prevent user from inserting data into autocomplete fields

CREATE OR REPLACE TRIGGER t_sale_str_autocomplete_restriction_insert
BEFORE INSERT ON t_sale_str 
FOR EACH ROW
FOLLOWS t_sale_str_state_restiction_insert
WHEN (NEW.summa IS NOT NULL OR NEW.nds IS NOT NULL OR NEW.price IS NOT NULL OR NEW.disc_price IS NOT NULL)
BEGIN
   RAISE_APPLICATION_ERROR(-20010,'can''t insert data into autocomplete fields (summa, nds, price, discount_price)');
END;
/
