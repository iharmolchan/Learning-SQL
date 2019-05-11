DECLARE
   n_before_price t_model.price%TYPE;
   n_after_price t_model.price%TYPE;
   n_insert_price t_model.price%TYPE:= 9999.99;
   n_id_model t_model.id_model%TYPE:= 100000;
BEGIN
   select NVL(price, -1) into n_before_price from t_model where id_model =n_id_model;
   dbms_output.put_line('before price is: '||n_before_price);
   dbms_output.put_line('insert price is: '||n_insert_price);
   
   update t_price_model
   set price = n_insert_price
   where id_model = n_id_model;
   
   select NVL(price, -1) into n_after_price from t_model where id_model =n_id_model;
   dbms_output.put_line('after price is: '||n_after_price);
   
   if (n_insert_price= n_after_price) then
   dbms_output.put_line('test passed');
   else
   dbms_output.put_line('test is not passed');
   end if;
   
   update t_price_model
   set price = n_before_price
   where id_model = n_id_model; 
   
   
END;
/
