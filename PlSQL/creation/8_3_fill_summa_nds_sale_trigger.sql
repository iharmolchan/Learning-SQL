CREATE OR REPLACE TRIGGER fill_summa_nds_sale
AFTER INSERT OR UPDATE ON t_sale_str 
FOR EACH ROW
WHEN (OLD.qty IS NULL OR OLD.qty!=NEW.qty OR OLD.price!=NEW.price OR OLD.discount!=NEW.discount)
DECLARE
   n_summa_exists NUMBER;
BEGIN
   SELECT COUNT(summa) INTO n_summa_exists FROM t_sale WHERE id_sale=:new.id_sale; 
   IF n_summa_exists =0 
   THEN   
      UPDATE 
         t_sale
      SET 
         summa=:new.summa,
         nds=:new.nds
      WHERE 
         id_sale=:new.id_sale;
   ELSE
      UPDATE 
         t_sale
      SET 
         summa=summa+:new.summa,
         nds=nds+:new.nds
      WHERE 
         id_sale=:new.id_sale;
   END IF;            
END;
/
