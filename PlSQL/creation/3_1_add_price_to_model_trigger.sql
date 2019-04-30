CREATE OR REPLACE TRIGGER add_price_to_model
AFTER INSERT OR UPDATE ON t_price_model
FOR EACH ROW
BEGIN
   UPDATE
      t_model
   SET 
      price=:new.price
   WHERE
      id_model=:new.id_model;       
END;
/
