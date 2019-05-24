--TASK-01 Триггер для строки поставки, автоматически вычисляющий сумму и НДС строки. 
--        Следующий шаг — вычисление в триггере суммы и НДС заголовка поставки по изменению в строках.

-- trigger to update 'summa' and 'nds' fields in supply when deleting supply string

CREATE OR REPLACE TRIGGER t_supply_fill_summa_nds_delete
AFTER DELETE ON t_supply_str 
FOR EACH ROW
BEGIN   
   UPDATE 
      t_supply
   SET 
      summa = summa - :old.summa,
      nds = nds - :old.nds
   WHERE 
      id_supply = :old.id_supply;
END;
/
