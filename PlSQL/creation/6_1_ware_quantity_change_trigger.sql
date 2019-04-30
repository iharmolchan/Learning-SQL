CREATE OR REPLACE TRIGGER ware_quantity_change
AFTER INSERT OR UPDATE ON t_supply_str 
FOR EACH ROW
DECLARE
   n_ware_rest_exists NUMBER;   
BEGIN
   SELECT COUNT(*) INTO n_ware_rest_exists FROM t_rest WHERE id_ware=:new.id_ware;
   IF n_ware_rest_exists =0 THEN   
      INSERT INTO t_rest(id_ware, qty)
      VALUES (:new.id_ware, :new.qty);
   ELSE
      UPDATE t_rest
      SET qty=qty+:new.qty
      WHERE id_ware=:new.id_ware;
   END IF;            
END;
/