-- trigger to change ware stocks history when stataus of document (supply) is changed ('new' or 'done')

CREATE OR REPLACE TRIGGER t_supply_state_ware_rest_hist_change_update
AFTER UPDATE ON t_supply
FOR EACH ROW
FOLLOWS t_supply_autocomplete_restriction_update
WHEN (OLD.e_state != NEW.e_state)
DECLARE
   CURSOR cur_wares IS SELECT id_ware, qty FROM t_supply_str WHERE id_supply = :new.id_supply;
   n_ware_rest_exists NUMBER;
   d_previous_qty t_rest_hist.qty%TYPE; 
BEGIN
   FOR r_ware IN cur_wares
   LOOP
      SELECT COUNT(*) INTO n_ware_rest_exists FROM t_rest_hist WHERE id_ware = r_ware.id_ware AND dt_beg = :new.dt;
       
      IF n_ware_rest_exists = 0 AND UPPER(:new.e_state) = 'DONE' THEN      
         BEGIN
            SELECT qty INTO d_previous_qty FROM t_rest_hist 
            WHERE id_ware = r_ware.id_ware AND dt_beg < :new.dt 
            ORDER BY dt_beg DESC FETCH FIRST 1 ROW ONLY;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            d_previous_qty := 0;
         END;  

         INSERT INTO t_rest_hist(id_ware, qty, dt_beg)
         VALUES (r_ware.id_ware, d_previous_qty + r_ware.qty, :new.dt);
         
         UPDATE t_rest_hist
         SET qty = qty + r_ware.qty
         WHERE id_ware = r_ware.id_ware AND dt_beg > :new.dt;
          
      ELSIF UPPER(:new.e_state) = 'DONE' THEN          
         UPDATE t_rest_hist
         SET qty = qty + r_ware.qty
         WHERE id_ware = r_ware.id_ware AND dt_beg >= :new.dt;
         
      ELSIF UPPER(:new.e_state) = 'NEW' THEN           
         UPDATE t_rest_hist
         SET qty = qty - r_ware.qty
         WHERE id_ware = r_ware.id_ware AND dt_beg >= :old.dt;  
      END IF;            
   END LOOP;
END;
/
