--TASK-01 Триггер для строки поставки, автоматически вычисляющий сумму и НДС строки. 
--        Следующий шаг — вычисление в триггере суммы и НДС заголовка поставки по изменению в строках.

-- trigger to insert or update 'summa' and 'nds' fields in supply strings

CREATE OR REPLACE TRIGGER t_supply_str_fill_summa_nds
BEFORE INSERT OR UPDATE ON t_supply_str 
FOR EACH ROW
FOLLOWS t_supply_str_autocomplete_restriction_insert, t_supply_str_state_restriction_update
WHEN (OLD.qty IS NULL OR OLD.qty != NEW.qty OR OLD.price != NEW.price)
BEGIN
   :new.summa:= :new.qty * :new.price;
   :new.nds:= :new.summa * 0.2 /* example nds */;   
END;
/
