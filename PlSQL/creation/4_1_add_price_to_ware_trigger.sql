CREATE OR REPLACE TRIGGER add_price_to_ware
AFTER INSERT OR UPDATE ON t_price_ware
FOR EACH ROW
BEGIN
   UPDATE
      t_ware
   SET 
      price=:new.price
   WHERE
      id_ware=:new.id_ware;       
END;
/
