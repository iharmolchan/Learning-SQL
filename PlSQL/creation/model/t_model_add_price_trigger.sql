-- trigger to add price to model table when table with prices is changed

CREATE OR REPLACE TRIGGER t_model_add_price
AFTER INSERT OR UPDATE ON t_price_model
FOR EACH ROW
WHEN (OLD.price IS NULL OR OLD.price != NEW.price)
BEGIN
   UPDATE
      t_model
   SET 
      price = :new.price
   WHERE
      id_model = :new.id_model;       
END;
/
