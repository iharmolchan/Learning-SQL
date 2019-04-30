DECLARE
   CURSOR cur_wares IS SELECT id_ware, id_model FROM t_ware;
   n_random NUMBER (1,0);
   r_price_model t_price_model%ROWTYPE;
BEGIN
   FOR r_ware IN cur_wares
   LOOP
      n_random:= ROUND(DBMS_RANDOM.VALUE(0,9));
      SELECT * INTO r_price_model FROM t_price_model WHERE id_model = r_ware.id_model;
      INSERT INTO
         t_price_ware (id_ware, dt_beg, dt_end, price)
      VALUES(
         r_ware.id_ware, 
         r_price_model.dt_beg,
         r_price_model.dt_end,
         CASE
           WHEN n_random BETWEEN 0 AND 8 THEN r_price_model.price
           ELSE ROUND(DBMS_RANDOM.VALUE(5,1000), 2)
         END);   
   END LOOP;
   COMMIT;  
EXCEPTION
WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE( SQLERRM );    
END;
/
