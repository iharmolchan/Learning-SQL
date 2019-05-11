-- compound trigger to change ware stocks when stataus of document (sale) is changed ('new' or 'done')

CREATE OR REPLACE TRIGGER t_sale_update_str_on_discount_change_v2
FOR UPDATE OF discount
ON t_sale
COMPOUND TRIGGER
   TYPE saleNewDiscount IS RECORD (
      id_sale t_sale.id_sale%TYPE,
      new_discount t_sale.discount%TYPE);
   TYPE discountArray IS TABLE OF saleNewDiscount INDEX BY BINARY_INTEGER;
   v_discounts discountArray;
BEFORE EACH ROW IS
   BEGIN
      IF :old.discount != :new.discount THEN
         v_discounts(v_discounts.count).id_sale:= :new.id_sale;
         v_discounts(v_discounts.count - 1).new_discount:= :new.discount;
      END IF;
END BEFORE EACH ROW;
  
AFTER STATEMENT IS
   BEGIN
      FOR n_array_index IN 0 .. v_discounts.count - 1
      LOOP
         UPDATE t_sale_str
         SET disc_price = price * (1 - discount / 100) * (1 - v_discounts(n_array_index).new_discount / 100) 
         WHERE id_sale = v_discounts(n_array_index).id_sale;
      END LOOP;
END AFTER STATEMENT;
END t_sale_update_str_on_discount_change_v2;
/
