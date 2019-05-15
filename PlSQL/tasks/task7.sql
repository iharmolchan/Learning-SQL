-- TASK-07 Доработка предыдущего: при исполнении накладной необходимо блокировать продажу отсутствующего товара, 
--         но при этом обязательно выдавать сообщение по всем товарам, которых не хватает, а не останавливаться на первом.

-- trigger to change ware stocks when stataus of document (sale) is changed ('new' or 'done')

CREATE OR REPLACE TRIGGER  t_sale_no_stocks_restriction_update
BEFORE UPDATE ON t_sale
FOR EACH ROW
WHEN (OLD.e_state != NEW.e_state AND UPPER(NEW.e_state) = 'DONE')
DECLARE
   TYPE wareRestArray IS TABLE OF t_rest%ROWTYPE INDEX BY BINARY_INTEGER;
   v_rest wareRestArray;   
   CURSOR cur_wares IS SELECT id_ware, qty FROM t_sale_str WHERE id_sale = :new.id_sale;
   n_ware_rest t_rest.qty%TYPE;
   v_result_error_mesasge VARCHAR2(4000 CHAR) := 'Can''t fulfill sale '||:new.id_sale||'. Following wares are out of stocks:'; 
BEGIN
   FOR r_ware IN cur_wares
   LOOP
      BEGIN
         SELECT NVL(qty, 0) INTO n_ware_rest FROM t_rest_hist 
         WHERE id_ware = r_ware.id_ware AND dt_beg <= :new.dt ORDER BY dt_beg DESC FETCH FIRST 1 ROW ONLY;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         n_ware_rest := 0;   
      END;
      IF r_ware.qty - n_ware_rest > 0 THEN 
         v_rest(v_rest.count).id_ware := r_ware.id_ware;
         v_rest(v_rest.count - 1).qty := r_ware.qty;
      END IF;
   END LOOP;
      
   IF v_rest.count > 0 THEN
      FOR n_array_index IN 0 .. v_rest.count - 1
      LOOP
         v_result_error_mesasge := CONCAT (v_result_error_mesasge, chr(10)                       ||
                                                                   'ware '                       ||
                                                                   v_rest(n_array_index).id_ware ||
                                                                   ' lacks '                     ||
                                                                   v_rest(n_array_index).qty     ||
                                                                   ' units');
      END LOOP;
                  
      RAISE_APPLICATION_ERROR(-20010, v_result_error_mesasge);
   END IF;      
END;
/
