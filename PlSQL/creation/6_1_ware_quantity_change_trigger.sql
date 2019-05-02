CREATE OR REPLACE TRIGGER ware_quantity_change
AFTER INSERT OR UPDATE ON t_supply_str 
FOR EACH ROW
DECLARE
   n_ware_rest_exists NUMBER;
   v_state t_supply.e_state%TYPE;   
BEGIN
   SELECT COUNT(*) INTO n_ware_rest_exists FROM t_rest WHERE id_ware=:new.id_ware;
   SELECT e_state INTO v_state FROM t_supply WHERE id_supply=:new.id_supply;
   IF n_ware_rest_exists =0 AND UPPER(v_state)='DONE' THEN   
      INSERT INTO t_rest(id_ware, qty)
      VALUES (:new.id_ware, :new.qty);
   ELSIF UPPER(v_state)='DONE' THEN 
      UPDATE t_rest
      SET qty=qty+:new.qty
      WHERE id_ware=:new.id_ware;
   END IF;            
END;
/
