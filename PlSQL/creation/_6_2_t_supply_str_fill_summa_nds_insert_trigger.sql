-- trigger to set or update 'summa' and 'nds' fields in supply when inserting new supply string

CREATE OR REPLACE TRIGGER t_supply_str_fill_summa_nds_insert
AFTER INSERT ON t_supply_str 
FOR EACH ROW
BEGIN 
   UPDATE 
      t_supply
   SET 
      summa = NVL(summa, 0) + :new.summa,
      nds = NVL(nds, 0) + :new.nds
   WHERE 
      id_supply = :new.id_supply;
END;
/
