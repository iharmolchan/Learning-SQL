--TASK-01 Триггер для строки поставки, автоматически вычисляющий сумму и НДС строки. 
--        Следующий шаг — вычисление в триггере суммы и НДС заголовка поставки по изменению в строках.

--first part of task
CREATE OR REPLACE TRIGGER fill_summa_nds_supply_str
BEFORE INSERT OR UPDATE ON t_supply_str 
FOR EACH ROW
WHEN (OLD.qty IS NULL OR OLD.qty!=NEW.qty OR OLD.price!=NEW.price)
BEGIN
   :new.summa:= :new.qty*:new.price;
   :new.nds:=:new.summa*0.2;   
END;
/
--second part of task
CREATE OR REPLACE TRIGGER fill_summa_nds_supply
BEFORE INSERT OR UPDATE ON t_supply_str 
FOR EACH ROW
FOLLOWS fill_summa_nds_supply_str
WHEN (OLD.qty!=NEW.qty OR OLD.price!=NEW.price OR OLD.qty IS NULL)
DECLARE
   n_summa_exists NUMBER;  
BEGIN
   SELECT COUNT(summa) INTO n_summa_exists FROM t_supply WHERE id_supply=:new.id_supply; 
   IF n_summa_exists =0 
   THEN   
      UPDATE 
         t_supply
      SET 
         summa=:new.summa,
         nds=:new.nds
      WHERE 
         id_supply=:new.id_supply;
   ELSE
      UPDATE 
         t_supply
      SET 
         summa=summa+:new.summa,
         nds=nds+:new.nds
      WHERE 
         id_supply=:new.id_supply;
   END IF;            
END;
/
