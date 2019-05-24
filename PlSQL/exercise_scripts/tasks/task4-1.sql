-- TASK-04 Триггер для строки продажи и для самой продажи, автоматически вычисляющий сумму по строкам при изменении цены или количества, 
--         а также скидки в заголовке, и изменяющие общую сумму продажи в заголовке. 

-- trigger to insert or update 'summa' and 'nds' fields in sale strings

CREATE OR REPLACE TRIGGER t_sale_str_fill_summa_nds
BEFORE INSERT OR UPDATE ON t_sale_str 
FOR EACH ROW
WHEN (OLD.qty IS NULL OR OLD.qty != NEW.qty OR OLD.disc_price != NEW.disc_price)
BEGIN
   :new.summa:= :new.qty * :new.disc_price;
   :new.nds:= :new.summa * 0.2 /* example nds */;   
END;
/
