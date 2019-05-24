-- TASK-06 Процедура или триггер исполнения поставки и продажи, изменяющая текущее количество товара на складе. 
--         Естественно, должна обрабатыватьcя отмена исполнения.

-- trigger to change ware stocks when stataus of document (supply) is changed ('new' or 'done')

CREATE OR REPLACE TRIGGER t_supply_state_ware_qty_change_update
AFTER UPDATE ON t_supply
FOR EACH ROW
WHEN (OLD.e_state != NEW.e_state)
DECLARE
   CURSOR cur_wares IS SELECT id_ware, qty FROM t_supply_str WHERE id_supply = :new.id_supply;
   n_ware_rest_exists NUMBER; 
BEGIN
   FOR r_ware IN cur_wares
   LOOP
      SELECT COUNT(*) INTO n_ware_rest_exists FROM t_rest WHERE id_ware = r_ware.id_ware;
      IF n_ware_rest_exists = 0 AND UPPER(:new.e_state) = 'DONE' THEN   
         INSERT INTO t_rest(id_ware, qty)
         VALUES (r_ware.id_ware, r_ware.qty);
      ELSIF UPPER(:new.e_state) = 'DONE' THEN 
         UPDATE t_rest
         SET qty = qty + r_ware.qty
         WHERE id_ware = r_ware.id_ware;
      ELSIF UPPER(:new.e_state) = 'NEW' THEN 
         UPDATE t_rest
         SET qty = qty - r_ware.qty
         WHERE id_ware = r_ware.id_ware;   
      END IF;            
   END LOOP;
END;
/
