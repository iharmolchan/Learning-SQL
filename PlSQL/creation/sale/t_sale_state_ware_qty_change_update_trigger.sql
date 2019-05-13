-- trigger to change ware stocks when stataus of document (sale) is changed ('new' or 'done')

CREATE OR REPLACE TRIGGER  t_sale_state_ware_qty_change_update
AFTER UPDATE ON t_sale
FOR EACH ROW
FOLLOWS t_sale_autocomplete_restriction_update
WHEN (OLD.e_state != NEW.e_state)
DECLARE
   CURSOR cur_wares IS SELECT id_ware, qty FROM t_sale_str WHERE id_sale = :new.id_sale;
   n_ware_rest_exists NUMBER; 
BEGIN
   FOR r_ware IN cur_wares
   LOOP
      SELECT COUNT(*) INTO n_ware_rest_exists FROM t_rest WHERE id_ware = r_ware.id_ware;
      IF n_ware_rest_exists = 0 AND UPPER(:new.e_state) = 'DONE' THEN   
         INSERT INTO t_rest(id_ware, qty)
         VALUES (r_ware.id_ware, -r_ware.qty);
      ELSIF UPPER(:new.e_state) = 'DONE' THEN 
         UPDATE t_rest
         SET qty = qty - r_ware.qty
         WHERE id_ware = r_ware.id_ware;
      ELSIF UPPER(:new.e_state) = 'NEW' THEN
         UPDATE t_rest
         SET qty = qty + r_ware.qty
         WHERE id_ware = r_ware.id_ware;   
      END IF;            
   END LOOP;
END;
/
