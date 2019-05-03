CREATE OR REPLACE TRIGGER fill_summa_nds_sale_str
BEFORE INSERT OR UPDATE ON t_sale_str 
FOR EACH ROW
WHEN (OLD.qty IS NULL OR OLD.qty!=NEW.qty OR OLD.price!=NEW.price OR OLD.discount!=NEW.discount)
DECLARE
   n_sale_discount t_sale.discount%TYPE; 
BEGIN
   SELECT
      discount
   INTO 
      n_sale_discount
   FROM
      t_sale
   WHERE
      id_sale=:new.id_sale;      
   :new.disc_price:= :new.price*(1-:new.discount/100)*(1-n_sale_discount/100);
   :new.summa:= :new.qty*:new.disc_price;
   :new.nds:=:new.summa*0.2;   
END;
/
