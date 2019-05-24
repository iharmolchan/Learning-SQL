-- TASK-03 Триггер, автоматически устанавливающий цену продажи товара по значению цены на дату продажи с учетом скидки.

CREATE OR REPLACE TRIGGER t_sale_str_fill_price
BEFORE INSERT ON t_sale_str 
FOR EACH ROW
WHEN (OLD.price IS NULL OR OLD.discount != NEW.DISCOUNT OR OLD.id_ware != NEW.id_ware OR OLD.id_sale != NEW.id_sale)
DECLARE
   n_sale_discount t_sale.discount%TYPE;
   n_price t_price_ware.price%TYPE;
   n_margin t_price_ware.margin%TYPE;
BEGIN
   SELECT discount INTO n_sale_discount FROM t_sale WHERE id_sale = :new.id_sale;
   SELECT price INTO n_price FROM t_price_ware WHERE id_ware = :new.id_ware;
   SELECT margin INTO n_margin FROM t_price_ware WHERE id_ware = :new.id_ware;        
   
   :new.price:= n_price * (1 + n_margin / 100);
   :new.disc_price:= :new.price * (1 - :new.discount / 100) * (1 - n_sale_discount / 100);  
END;
/
