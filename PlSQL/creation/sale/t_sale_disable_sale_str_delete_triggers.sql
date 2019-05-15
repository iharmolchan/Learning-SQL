CREATE OR REPLACE TRIGGER t_sale_disable_sale_str_delete_triggers
BEFORE DELETE ON t_sale 
DECLARE
   PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
   EXECUTE IMMEDIATE 'ALTER TRIGGER t_sale_str_state_restriction_delete DISABLE';
   EXECUTE IMMEDIATE 'ALTER TRIGGER t_sale_fill_summa_nds_delete DISABLE';
END;
/
