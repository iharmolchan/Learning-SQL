CREATE OR REPLACE TRIGGER disable_sale_str_triggers
AFTER DELETE ON t_sale 
DECLARE
   PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
    EXECUTE IMMEDIATE 'ALTER TRIGGER t_sale_str_done_state_restriction_delete ENABLE';
    EXECUTE IMMEDIATE 'ALTER TRIGGER t_sale_fill_summa_nds_delete ENABLE';
END;
