-- trigger to update 'summa' and 'nds' fields in supply when updating supply string

CREATE OR REPLACE TRIGGER t_supply_fill_summa_nds_update
AFTER UPDATE ON t_supply_str 
FOR EACH ROW
WHEN (OLD.summa != NEW.summa OR OLD.id_supply != NEW.id_supply )  
BEGIN
   UPDATE 
      t_supply
   SET 
      summa = NVL(summa, 0) + :new.summa,
      nds = NVL(nds, 0) + :new.nds
   WHERE 
      id_supply = :new.id_supply;
   UPDATE 
      t_supply
   SET 
      summa = summa - :old.summa,
      nds = nds - :old.nds
   WHERE 
      id_supply = :old.id_supply;
END;
/
