CREATE OR REPLACE TRIGGER fill_summa_nds_sale_str
BEFORE INSERT OR UPDATE ON t_sale_str 
FOR EACH ROW
BEGIN
   :new.disc_price:= :new.price*(1-:new.discount/100);
   :new.summa:= :new.qty*:new.disc_price;
   :new.nds:=:new.summa*0.2;   
END;
/