CREATE OR REPLACE TRIGGER fill_summa_nds_sale
AFTER INSERT OR UPDATE ON t_sale_str 
FOR EACH ROW
DECLARE
   n_summa_exists NUMBER;
   n_discount t_sale.discount%TYPE;  
BEGIN
   SELECT COUNT(summa) INTO n_summa_exists FROM t_sale WHERE id_sale=:new.id_sale; 
   SELECT discount INTO n_discount FROM t_sale WHERE id_sale=:new.id_sale; 
   IF n_summa_exists =0 
   THEN   
      UPDATE 
         t_sale
      SET 
         summa=:new.summa*(1-n_discount/100),
         nds=:new.nds*(1-n_discount/100)
      WHERE 
         id_sale=:new.id_sale;
   ELSE
      UPDATE 
         t_sale
      SET 
         summa=summa+(:new.summa*(1-n_discount/100)),
         nds=nds+(:new.nds*(1-n_discount/100))
      WHERE 
         id_sale=:new.id_sale;
   END IF;            
END;
/