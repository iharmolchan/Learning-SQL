CREATE OR REPLACE TRIGGER fill_summa_nds_supply_str
BEFORE INSERT OR UPDATE ON t_supply_str 
FOR EACH ROW
BEGIN
   :new.summa:= :new.qty*:new.price;
   :new.nds:=:new.summa*0.2;   
END;
/