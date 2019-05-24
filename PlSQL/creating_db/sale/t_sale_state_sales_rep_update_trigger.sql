-- trigger to change sales report when status of sale is 'done'

CREATE OR REPLACE TRIGGER t_sale_state_sales_rep_update
AFTER UPDATE ON t_sale
FOR EACH ROW
FOLLOWS t_sale_autocomplete_restriction_update
WHEN (OLD.e_state != NEW.e_state)
DECLARE
   CURSOR cur_wares IS SELECT id_ware, qty, summa FROM t_sale_str WHERE id_sale = :new.id_sale;
   n_sales_rep_exists NUMBER;
BEGIN
   FOR r_ware IN cur_wares
   LOOP
      SELECT COUNT(*) INTO n_sales_rep_exists FROM t_sale_rep WHERE id_ware = r_ware.id_ware AND month = TRUNC(:new.dt, 'MM');
       
      IF n_sales_rep_exists = 0 AND UPPER(:new.e_state) = 'DONE' THEN
         INSERT INTO t_sale_rep (id_ware, month, sale_qty, sale_sum)
         VALUES (r_ware.id_ware, TRUNC(:new.dt, 'MM'), r_ware.qty, r_ware.summa);
          
      ELSIF UPPER(:new.e_state) = 'DONE' THEN          
         UPDATE t_sale_rep
         SET sale_qty = sale_qty + r_ware.qty, sale_sum = sale_sum + r_ware.summa
         WHERE id_ware = r_ware.id_ware AND month = TRUNC(:new.dt, 'MM');
         
      ELSIF UPPER(:new.e_state) = 'NEW' THEN           
         UPDATE t_sale_rep
         SET sale_qty = sale_qty - r_ware.qty, sale_sum = sale_sum - r_ware.summa
         WHERE id_ware = r_ware.id_ware AND month = TRUNC(:new.dt, 'MM');
      END IF;            
   END LOOP;
END;
/
