DECLARE
   CURSOR cur_sales IS SELECT  id_sale  FROM t_sale;
   n_wares NUMBER(1,0);
   r_ware t_ware%ROWTYPE;
   n_wares_quantity NUMBER; 
   n_ware_id t_ware.id_ware%TYPE;
   n_ware_price t_ware.price%TYPE;
   n_random NUMBER (2,0);
BEGIN
   SELECT COUNT(*)-1 INTO n_wares_quantity FROM t_ware;
   FOR r_sale IN cur_sales
   LOOP
      n_wares:= ROUND(DBMS_RANDOM.VALUE(1,7));
      FOR n_counter IN 1..n_wares
      LOOP
         n_random:= ROUND(DBMS_RANDOM.VALUE(0,99));   
         n_ware_id:= ROUND(DBMS_RANDOM.VALUE(100000,100000+n_wares_quantity));
         CASE
            WHEN n_random BETWEEN 0 AND 98 THEN 
               n_ware_price:= null;
            ELSE 
               n_ware_price:= ROUND(DBMS_RANDOM.VALUE(10,1000), 2); 
         END CASE;        
         INSERT INTO 
            t_sale_str (id_sale, id_ware, qty, price, discount)
         VALUES (
            r_sale.id_sale,
            n_ware_id,
            ROUND(DBMS_RANDOM.VALUE(1,3)),
            n_ware_price,
            CASE
               WHEN n_random BETWEEN 0 AND 90 THEN 0
               ELSE ROUND(DBMS_RANDOM.VALUE(0,49))
            END);
      END LOOP;
   END LOOP;
   COMMIT;  
EXCEPTION
WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE( SQLERRM );    
END;
/
