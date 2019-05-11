-- trigger to update 'summa' and 'nds' fields in supply when deleting supply string

CREATE OR REPLACE TRIGGER t_supply_fill_summa_nds_delete
AFTER DELETE ON t_supply_str 
FOR EACH ROW
BEGIN
   dbms_output.put_line('deleting supply_str with id: '||:old.id_supply_str||'. message from t_supply_fill_summa_nds_delete trigger'); 
   UPDATE 
      t_supply
   SET 
      summa = summa - :old.summa,
      nds = nds - :old.nds
   WHERE 
      id_supply = :old.id_supply;
END;
/
