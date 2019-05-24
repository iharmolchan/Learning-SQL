-- trigger to prevent user from updating data in autocomplete fields

CREATE OR REPLACE TRIGGER t_sale_str_autocomplete_restriction_update
AFTER UPDATE ON t_sale_str
FOR EACH ROW
DECLARE
   n_sale_discount t_sale.discount%TYPE;
   n_price t_price_ware.price%TYPE;
   n_margin t_price_ware.margin%TYPE;
   n_real_price t_price_ware.price%TYPE;
   n_real_disc_price t_sale_str.disc_price%TYPE;
   n_real_summa t_sale_str.summa%TYPE;
   n_real_nds t_sale_str.nds%TYPE;    
   
BEGIN
   SELECT discount INTO n_sale_discount FROM t_sale WHERE id_sale = :new.id_sale;
   SELECT price INTO n_price FROM t_price_ware WHERE id_ware = :new.id_ware;
   SELECT margin INTO n_margin FROM t_price_ware WHERE id_ware = :new.id_ware;
   n_real_price := n_price * (1 + n_margin/100);
   n_real_disc_price := n_real_price * (1 - n_sale_discount/100) * (1 - :new.discount/100);
   n_real_summa := n_real_disc_price * :new.qty;
   n_real_nds := n_real_summa * 0.2;  
    
   IF :new.price != n_real_price OR :new.disc_price != n_real_disc_price OR :new.summa != n_real_summa OR :new.nds != n_real_nds THEN
      RAISE_APPLICATION_ERROR(-20010,'can''t update data in autocomplete fields (summa, nds, price, discount_price)');
   END IF;
END;
/
