-- trigger to insert or update 'summa' and 'nds' fields in sale strings

CREATE OR REPLACE TRIGGER t_sale_str_fill_summa_nds
BEFORE INSERT OR UPDATE ON t_sale_str 
FOR EACH ROW
FOLLOWS t_sale_str_fill_price
WHEN (OLD.qty IS NULL OR OLD.qty != NEW.qty OR OLD.price != NEW.price)
BEGIN
   :new.summa:= :new.qty * :new.disc_price;
   :new.nds:= :new.summa * 0.2 /* example nds */;   
END;
/
