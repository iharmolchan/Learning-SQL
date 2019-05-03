CREATE OR REPLACE TRIGGER fill_summa_nds_sale_str
BEFORE INSERT OR UPDATE ON t_sale_str 
FOR EACH ROW
FOLLOWS fill_price
WHEN (OLD.qty IS NULL OR OLD.qty!=NEW.qty OR OLD.discount!=NEW.DISCOUNT)
BEGIN
   :new.summa:= :new.qty*:new.disc_price;
   :new.nds:=:new.summa*0.2;   
END;
/
