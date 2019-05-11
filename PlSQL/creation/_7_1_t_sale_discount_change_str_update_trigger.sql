-- compound trigger to change ware stocks when stataus of document (sale) is changed ('new' or 'done')

CREATE OR REPLACE TRIGGER t_sale_update_str_on_discount_change
FOR UPDATE OF discount
ON t_sale
DISABLE
COMPOUND TRIGGER
   TYPE SaleIdArray IS TABLE OF t_sale.id_sale%TYPE INDEX BY BINARY_INTEGER;
   v_chaged_discount_sale_ids SaleIdArray;
BEFORE EACH ROW IS
   BEGIN
      IF :old.discount != :new.discount THEN
         v_chaged_discount_sale_ids(v_chaged_discount_sale_ids.count):= :new.id_sale;
      END IF;
END BEFORE EACH ROW;
  
AFTER STATEMENT IS
   BEGIN
      FOR n_array_index IN 0 .. (v_chaged_discount_sale_ids.count - 1)
      LOOP
         UPDATE t_sale_str
         SET id_ware=id_ware
         WHERE id_sale = v_chaged_discount_sale_ids(n_array_index);
      END LOOP;
END AFTER STATEMENT;
END t_sale_update_str_on_discount_change; 
/
