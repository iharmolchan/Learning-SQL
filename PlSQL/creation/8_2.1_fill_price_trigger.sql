CREATE OR REPLACE TRIGGER fill_price
BEFORE INSERT OR UPDATE ON t_sale_str 
FOR EACH ROW
WHEN (OLD.price IS NULL OR OLD.discount!=NEW.DISCOUNT)
DECLARE
   n_sale_discount t_sale.discount%TYPE;
   n_price t_price_ware.price%TYPE; 
BEGIN
   SELECT discount INTO n_sale_discount FROM t_sale WHERE id_sale=:new.id_sale;
   SELECT price INTO n_price FROM t_price_ware WHERE id_ware=:new.id_ware;      
   
   IF :new.price IS NULL THEN
      :new.price:=n_price;
      :new.disc_price:= :new.price*(1-:new.discount/100)*(1-n_sale_discount/100);
   ELSE
      :new.disc_price:= :new.price*(1-:new.discount/100)*(1-n_sale_discount/100);
   END IF;      
END;
/
