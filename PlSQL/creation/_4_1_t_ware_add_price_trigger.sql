-- trigger to add price to ware table when table with prices is changed

CREATE OR REPLACE TRIGGER t_ware_add_price
AFTER INSERT OR UPDATE ON t_price_ware
FOR EACH ROW
WHEN (OLD.price IS NULL OR OLD.price != NEW.price)
BEGIN
   UPDATE
      t_ware
   SET 
      price = :new.price
   WHERE
      id_ware = :new.id_ware;       
END;
/
