-- TASK-02 Триггер, блокирующий установку скидки более 20% для «неVIP»-клиентов.

CREATE OR REPLACE TRIGGER sale_non_vip_client_discount
BEFORE INSERT OR UPDATE ON t_sale
FOR EACH ROW
WHEN (OLD.id_sale IS NULL OR OLD.id_client != NEW.id_client OR OLD.discount != NEW.discount)
DECLARE
   n_is_client_vip t_client.is_vip%TYPE;
BEGIN
   SELECT is_vip INTO n_is_client_vip FROM t_client WHERE id_client = :new.id_client;

   IF :new.discount > 20 AND n_is_client_vip = 0 THEN
      RAISE_APPLICATION_ERROR(-20010,'Non vip clients can''t have discount more then 20%');
   END IF;
END;


