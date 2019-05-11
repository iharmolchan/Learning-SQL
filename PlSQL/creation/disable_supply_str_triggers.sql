CREATE OR REPLACE TRIGGER disable_supply_str_triggers
BEFORE DELETE ON t_supply 
DECLARE
   PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
   EXECUTE IMMEDIATE 'ALTER TRIGGER t_supply_str_done_state_restriction_delete DISABLE';
   EXECUTE IMMEDIATE 'ALTER TRIGGER t_supply_fill_summa_nds_delete DISABLE';  
END;
