
--drop create
@drop_tables.sql 
@create_tables.sql

-- dept, model, ware triggers
@dept\t_dept_nocycle_restriction_trigger.sql
@model\t_model_add_price_trigger.sql
@ware\t_ware_add_price_trigger.sql

-- supply triggers
@supply\t_supply_autocomplete_restriction_insert_trigger.sql 
@supply\t_supply_autocomplete_restriction_update_trigger.sql
@supply\t_supply_state_restriction_insert_trigger.sql 
@supply\t_supply_state_restriction_update_trigger.sql
@supply\t_supply_state_restriction_delete_trigger.sql
@supply\t_supply_disable_supply_str_delete_triggers.sql 
@supply\t_supply_enable_supply_str_delete_triggers.sql
@supply\t_supply_done_state_restriction_update_trigger.sql 
@supply\t_supply_state_sales_rep_update_trigger.sql 
@supply\t_supply_state_ware_qty_change_update_trigger.sql 
@supply\t_supply_state_ware_rest_hist_change_update_trigger.sql 

--supply str triggers
@supply_str\t_supply_str_state_restriction_delete_trigger.sql 
@supply_str\t_supply_str_state_restriction_insert_trigger.sql 
@supply_str\t_supply_str_state_restriction_update_trigger.sql
@supply_str\t_supply_str_autocomplete_restriction_insert_trigger.sql 
@supply_str\t_supply_str_autocomplete_restriction_update_trigger.sql 
@supply_str\t_supply_str_fill_summa_nds_trigger.sql
@supply_str\t_supply_fill_summa_nds_delete_trigger.sql 
@supply_str\t_supply_fill_summa_nds_insert_trigger.sql 
@supply_str\t_supply_fill_summa_nds_update_trigger.sql

-- sale triggers
@sale\t_sale_autocomplete_restriction_insert_trigger.sql 
@sale\t_sale_autocomplete_restriction_update_trigger.sql
@sale\t_sale_state_restriction_insert_trigger.sql 
@sale\t_sale_state_restriction_update_trigger.sql
@sale\t_sale_state_restriction_delete_trigger.sql
@sale\t_sale_disable_sale_str_delete_triggers.sql
@sale\t_sale_enable_sale_str_delete_triggers.sql
@sale\t_sale_done_state_restriction_update_trigger.sql  
@sale\t_sale_no_stocks_restriction_update_trigger.sql  
@sale\t_sale_discount_change_str_update_trigger.sql
@sale\t_sale_state_sales_rep_update_trigger.sql 
@sale\t_sale_state_ware_qty_change_update_trigger.sql 
@sale\t_sale_state_ware_rest_hist_change_update_trigger.sql 

-- sale str triggers
@sale_str\t_sale_str_state_restriction_delete_trigger.sql 
@sale_str\t_sale_str_state_restriction_insert_trigger.sql 
@sale_str\t_sale_str_state_restriction_update_trigger.sql
@sale_str\t_sale_str_autocomplete_restriction_insert_trigger.sql 
@sale_str\t_sale_str_autocomplete_restriction_update_trigger.sql 
@sale_str\t_sale_str_fill_price_trigger.sql
@sale_str\t_sale_str_fill_summa_nds_trigger.sql 
@sale_str\t_sale_fill_summa_nds_delete_trigger.sql 
@sale_str\t_sale_fill_summa_nds_insert_trigger.sql 
@sale_str\t_sale_fill_summa_nds_update_trigger.sql

--sale report triggers
@sale_rep\t_sales_report_fill_fields_insert_trigger.sql 
@sale_rep\t_sales_report_fill_fields_update_trigger.sql

--ctl node triggers
@ctl_node\t_node_fill_tree_code_insert_trigger.sql 
@ctl_node\t_node_fill_tree_code_update_trigger.sql  

-- population
@"E:\work\Learning-SQL\PlSQL\populating_db\1_initial_data_population.sql" 
@"E:\work\Learning-SQL\PlSQL\populating_db\2_t_ware population.sql" 
@"E:\work\Learning-SQL\PlSQL\populating_db\3_t_model_price population.sql" 
@"E:\work\Learning-SQL\PlSQL\populating_db\4_t_ware_price population.sql" 
@"E:\work\Learning-SQL\PlSQL\populating_db\5_t_supply_population.sql" 
@"E:\work\Learning-SQL\PlSQL\populating_db\6_t_supply_str_population.sql" 
@"E:\work\Learning-SQL\PlSQL\populating_db\7_t_sale_population.sql" 
@"E:\work\Learning-SQL\PlSQL\populating_db\8_t_sale_str_population.sql"