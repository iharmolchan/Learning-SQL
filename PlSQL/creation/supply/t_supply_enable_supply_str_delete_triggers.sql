CREATE OR REPLACE TRIGGER t_supply_enable_supply_str_delete_triggers
AFTER DELETE ON t_supply 
DECLARE
   PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
   EXECUTE IMMEDIATE 'ALTER TRIGGER t_supply_str_done_state_restriction_delete ENABLE';
   EXECUTE IMMEDIATE 'ALTER TRIGGER t_supply_fill_summa_nds_delete ENABLE';  
END;
