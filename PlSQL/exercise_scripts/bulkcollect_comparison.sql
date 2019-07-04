DECLARE 
   CURSOR cur_sale_strings IS SELECT * FROM t_sale_str;
   start_time TIMESTAMP;
   end_time TIMESTAMP;   
   TYPE saleArray IS TABLE OF t_sale_str%ROWTYPE INDEX BY BINARY_INTEGER;
   v_sale_array saleArray;
BEGIN
   start_time:= SYSTIMESTAMP;
   
   FOR sale_string IN  cur_sale_strings
   LOOP
      v_sale_array(v_sale_array.count) := sale_string;
   END LOOP;   
   
   end_time := SYSTIMESTAMP;
   DBMS_OUTPUT.PUT_LINE('Loop selecting ended with time: '||(end_time - start_time));
   
   --truncating array
   v_sale_array.delete;
   
   start_time:= SYSTIMESTAMP;
   
   SELECT * BULK COLLECT INTO  v_sale_array FROM t_sale_str;  
   
   end_time := SYSTIMESTAMP;
   DBMS_OUTPUT.PUT_LINE('BULK COLLECT ended select with time: '||(end_time - start_time));   
   
   ROLLBACK;
   DBMS_OUTPUT.PUT_LINE('Rows were inserted: '||v_sale_array.count); 
END;     
