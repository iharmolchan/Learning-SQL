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
