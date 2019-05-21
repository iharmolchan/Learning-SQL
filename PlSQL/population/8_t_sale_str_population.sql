-- add random strings to existing sales

DECLARE
   CURSOR cur_sales IS SELECT  id_sale  FROM t_sale;
   n_wares NUMBER(1,0);
   r_ware t_ware%ROWTYPE;
   n_ware_id t_ware.id_ware%TYPE;
   n_random NUMBER (2,0);
BEGIN
   FOR r_sale IN cur_sales
   LOOP
      n_wares:= ROUND(DBMS_RANDOM.VALUE(1,7)); -- set random number of wares in sales (from 1 to 7)
      FOR n_counter IN 1..n_wares
      LOOP
         n_random:= ROUND(DBMS_RANDOM.VALUE(0,99));
         SELECT id_ware INTO n_ware_id FROM t_ware ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY; -- set random ware id
         INSERT INTO 
            t_sale_str (id_sale, id_ware, qty, discount)
         VALUES (
            r_sale.id_sale,
            n_ware_id,
            ROUND(DBMS_RANDOM.VALUE(1,3)), -- random quantity of ware ( 1 to 3)
            CASE
               WHEN n_random BETWEEN 0 AND 90 THEN 0 -- 90% chance to get zero discount
               ELSE ROUND(DBMS_RANDOM.VALUE(0,49))   -- 10% chance to get discount between 0 and 49% 
            END);
      END LOOP;
   END LOOP;
   COMMIT;  
EXCEPTION
WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE(SQLERRM);    
END;
/
