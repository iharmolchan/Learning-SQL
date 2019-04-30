--TASK-01 Триггер для строки поставки, автоматически вычисляющий сумму и НДС строки. 
--        Следующий шаг — вычисление в триггере суммы и НДС заголовка поставки по изменению в строках.

CREATE OR REPLACE TRIGGER supply_str_summa_and_nds_count
BEFORE INSERT OR UPDATE ON t_supply_str FOR EACH ROW
BEGIN
   :new.summa:=:new.qty*:new.price;
   :new.nds:=:new.summa*0.2;
END;
