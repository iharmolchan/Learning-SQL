-- TASK-04 Триггер для строки продажи и для самой продажи, автоматически вычисляющий сумму по строкам при изменении цены или количества, 
--         а также скидки в заголовке, и изменяющие общую сумму продажи в заголовке. 


-- compound trigger to change summa and nds in sale and sale strings when sale discount is changed

CREATE OR REPLACE TRIGGER t_sale_update_str_on_discount_change
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
      IF :old.discount != :new.discount THEN -- saving ids of supplies with changed discounts into the array
         v_discounts(v_discounts.count).id_sale:= :new.id_sale;
         v_discounts(v_discounts.count - 1).new_discount:= :new.discount;
      END IF;
END BEFORE EACH ROW;

--in after statement updating discount_price of every sale string where sale discount has been chabged 
--(and it fires trigger from first part of the task)  
AFTER STATEMENT IS
   BEGIN
      FOR n_array_index IN 0 .. v_discounts.count - 1
      LOOP
         UPDATE t_sale_str
         SET disc_price = price * (1 - discount / 100) * (1 - v_discounts(n_array_index).new_discount / 100) 
         WHERE id_sale = v_discounts(n_array_index).id_sale;
      END LOOP;
END AFTER STATEMENT;
END t_sale_update_str_on_discount_change;
/
