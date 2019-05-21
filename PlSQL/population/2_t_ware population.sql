-- fill t_ware table with different sizes wares depending on model (using random)

DECLARE
   CURSOR cur_models IS SELECT  id_model, moniker, name  FROM t_model  ORDER BY id_model;
   number_of_wares NUMBER(10,0);
   orig_sz t_ware.sz_orig%TYPE;
   rus_sz t_ware.sz_rus%TYPE;
   n_exists_ware NUMBER;
BEGIN
   FOR r_model IN cur_models
   LOOP
      number_of_wares:= ROUND(DBMS_RANDOM.VALUE(1,6)); -- max number of model sizes is 6, minimum is 1
      FOR n_counter IN 1..number_of_wares
      LOOP
         BEGIN
            rus_sz:= ROUND(DBMS_RANDOM.VALUE(18,48)); -- ranndom russian size from 18 to 48
            CASE -- determing original (european or us size) depending on russian random size
               WHEN rus_sz BETWEEN 18 AND 22 THEN orig_sz:= 'XS';
               WHEN rus_sz BETWEEN 23 AND 27 THEN orig_sz:= 'S';
               WHEN rus_sz BETWEEN 28 AND 32 THEN orig_sz:= 'M';
               WHEN rus_sz BETWEEN 33 AND 37 THEN orig_sz:= 'L';
               WHEN rus_sz BETWEEN 38 AND 42 THEN orig_sz:= 'XL';
               WHEN rus_sz BETWEEN 43 AND 48 THEN orig_sz:= 'XXL';
               ELSE orig_sz:='unknown size';
            END CASE;
            --check if ware with such size exists
            SELECT COUNT(*) INTO n_exists_ware FROM t_ware WHERE moniker = r_model.moniker||' '||orig_sz;
            --inserting wares in t_ware (ware name = model name + original size)
            IF n_exists_ware = 0 THEN
               INSERT INTO 
                  t_ware (moniker, name, id_model, sz_orig, sz_rus)
               VALUES 
                 (r_model.moniker||' '||orig_sz, r_model.name||' '||orig_sz, r_model.id_model, orig_sz, rus_sz);
            END IF; 
            EXCEPTION
            WHEN OTHERS THEN
               DBMS_OUTPUT.PUT_LINE( SQLERRM );
            END;
      END LOOP;
   END LOOP;
   COMMIT;  
EXCEPTION
WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE(SQLERRM);    
END;
/
