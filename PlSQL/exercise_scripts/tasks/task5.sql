--TASK-05 Процедура назначения цены товару на заданном интервале, соответственно изменяющая таблицу цен. 
--        Должна изменять также цены в продажах-черновиках, естественно, с учетом скидки.

CREATE OR REPLACE PROCEDURE change_ware_price (n_id_ware t_ware.id_ware%TYPE, n_new_price t_price_ware.price%TYPE)
IS
   n_margin t_price_ware.margin%TYPE;
BEGIN   
   SELECT margin INTO n_margin FROM t_price_ware WHERE id_ware = n_id_ware;
   
   UPDATE 
      t_price_ware 
   SET 
      price = n_new_price 
   WHERE 
      id_ware = n_id_ware;
   
   COMMIT;
  
   UPDATE 
      t_sale_str st 
   SET 
      st.disc_price = n_new_price * (1 + n_margin/100) 
                                  * (1 - st.discount/100) 
                                  * (1 - (SELECT discount FROM t_sale WHERE id_sale = st.id_sale) / 100),
      st.price = n_new_price * (1 + n_margin/100)
   WHERE
      UPPER((SELECT e_state FROM t_sale WHERE id_sale = st.id_sale)) = 'NEW' AND id_ware = n_id_ware;
        
   COMMIT;    
END;
/
