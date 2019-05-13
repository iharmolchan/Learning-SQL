-- trigger to update 'summa' and 'nds' fields in sale when deleting sale string

CREATE OR REPLACE TRIGGER t_sale_fill_summa_nds_delete
AFTER DELETE ON t_sale_str 
FOR EACH ROW
BEGIN
   dbms_output.put_line('sale str trigger 8.2'); 
   UPDATE 
      t_sale
   SET 
      summa = summa - :old.summa,
      nds = nds - :old.nds
   WHERE 
      id_sale = :old.id_sale;
END;
/
