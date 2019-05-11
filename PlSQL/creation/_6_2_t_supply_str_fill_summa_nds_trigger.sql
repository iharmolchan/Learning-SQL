-- trigger to insert or update 'summa' and 'nds' fields in supply strings

CREATE OR REPLACE TRIGGER t_supply_str_fill_summa_nds
BEFORE INSERT OR UPDATE ON t_supply_str 
FOR EACH ROW
WHEN (OLD.qty IS NULL OR OLD.qty != NEW.qty OR OLD.price != NEW.price)
BEGIN
   :new.summa:= :new.qty * :new.price;
   :new.nds:= :new.summa * 0.2 /* example nds */;   
END;
/
