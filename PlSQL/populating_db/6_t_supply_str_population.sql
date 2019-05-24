-- add random strings to existing supplies

DECLARE
   CURSOR cur_supplies IS SELECT  id_supply  FROM t_supply;
   n_wares NUMBER(2,0);
   r_ware t_ware%ROWTYPE;
   n_ware_id t_ware.id_ware%TYPE;
   n_ware_price t_ware.price%TYPE;
BEGIN
   FOR r_supply IN cur_supplies
   LOOP
      n_wares:= ROUND(DBMS_RANDOM.VALUE(5,20)); -- set random number of wares in supply (from 5 to 20)
      FOR n_counter IN 1..n_wares
      LOOP
         SELECT id_ware INTO n_ware_id FROM t_ware ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY; -- set random ware id 
         SELECT price INTO n_ware_price FROM t_ware WHERE id_ware = n_ware_id;                 
         INSERT INTO 
            t_supply_str (id_supply, id_ware, qty, price)
         VALUES (
            r_supply.id_supply,
            n_ware_id,
            ROUND(DBMS_RANDOM.VALUE(3,15)), -- random quantity of ware (3 to 15)
            n_ware_price);
      END LOOP;
   END LOOP;
   COMMIT;  
EXCEPTION
WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE( SQLERRM );    
END;
/
