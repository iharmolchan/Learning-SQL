-- trigger to set or update 'summa' and 'nds' fields in sale when inserting new sale string

CREATE OR REPLACE TRIGGER t_sale_fill_summa_nds_insert
AFTER INSERT ON t_sale_str 
FOR EACH ROW
BEGIN 
   UPDATE 
      t_sale
   SET 
      summa = NVL(summa, 0) + :new.summa,
      nds = NVL(nds, 0) + :new.nds
   WHERE 
      id_sale = :new.id_sale;
END;
/
