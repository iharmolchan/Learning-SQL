DECLARE 
   CURSOR cur_sale_strings IS SELECT * FROM t_sale_str;
   start_time TIMESTAMP;
   end_time TIMESTAMP;   
   TYPE saleArray IS TABLE OF t_sale_str%ROWTYPE INDEX BY BINARY_INTEGER;
   v_sale_array saleArray;
BEGIN
   FOR sale_string IN  cur_sale_strings
   LOOP
      v_sale_array(v_sale_array.count) := sale_string;
   END LOOP;
   
   start_time:= SYSTIMESTAMP;
   
   --loop inserting
   FOR i IN 0 .. v_sale_array.count - 1
   LOOP
      INSERT INTO t_sale_str_test VALUES v_sale_array(i);
   END LOOP;
   
   end_time := SYSTIMESTAMP;
   DBMS_OUTPUT.PUT_LINE('Loop inserting ended insert with time: '||(end_time - start_time)); 
   
   start_time := SYSTIMESTAMP;
   
   --forall bulk inserting
   FORALL i IN 0 .. v_sale_array.count-1
      INSERT INTO t_sale_str_test VALUES v_sale_array(i);
             
   end_time := SYSTIMESTAMP;
   DBMS_OUTPUT.PUT_LINE('FORALL bulk inserting ended insert with time: '||(end_time - start_time));           
   
   ROLLBACK;
   DBMS_OUTPUT.PUT_LINE('Rows were inserted: '||v_sale_array.count); 
END;     
