
--drop create
@"E:\work\Learning-SQL\PlSQL\creation\drop_tables.sql" 
@"E:\work\Learning-SQL\PlSQL\creation\create_tables.sql"

-- dept, model, ware triggers
@"E:\work\Learning-SQL\PlSQL\creation\dept\t_dept_nocycle_restriction_trigger.sql"
@"E:\work\Learning-SQL\PlSQL\creation\model\t_model_add_price_trigger.sql"
@"E:\work\Learning-SQL\PlSQL\creation\ware\t_ware_add_price_trigger.sql"

-- supply triggers
@"E:\work\Learning-SQL\PlSQL\creation\supply\t_supply_autocomplete_restriction_insert_trigger.sql" 
@"E:\work\Learning-SQL\PlSQL\creation\supply\t_supply_autocomplete_restriction_update_trigger.sql"
@"E:\work\Learning-SQL\PlSQL\creation\supply\t_supply_state_restriction_insert_trigger.sql" 
@"E:\work\Learning-SQL\PlSQL\creation\supply\t_supply_state_restriction_update_trigger.sql"
@"E:\work\Learning-SQL\PlSQL\creation\supply\t_supply_state_restriction_delete_trigger.sql"
@"E:\work\Learning-SQL\PlSQL\creation\supply\t_supply_disable_supply_str_delete_triggers.sql" 
@"E:\work\Learning-SQL\PlSQL\creation\supply\t_supply_enable_supply_str_delete_triggers.sql"
@"E:\work\Learning-SQL\PlSQL\creation\supply\t_supply_done_state_restriction_update_trigger.sql" 
@"E:\work\Learning-SQL\PlSQL\creation\supply\t_supply_state_sales_rep_update_trigger.sql" 
@"E:\work\Learning-SQL\PlSQL\creation\supply\t_supply_state_ware_qty_change_update_trigger.sql" 
@"E:\work\Learning-SQL\PlSQL\creation\supply\t_supply_state_ware_rest_hist_change_update_trigger.sql" 

--supply str triggers
@"E:\work\Learning-SQL\PlSQL\creation\supply_str\t_supply_str_state_restriction_delete_trigger.sql" 
@"E:\work\Learning-SQL\PlSQL\creation\supply_str\t_supply_str_state_restriction_insert_trigger.sql" 
@"E:\work\Learning-SQL\PlSQL\creation\supply_str\t_supply_str_state_restriction_update_trigger.sql"
@"E:\work\Learning-SQL\PlSQL\creation\supply_str\t_supply_str_autocomplete_restriction_insert_trigger.sql" 
@"E:\work\Learning-SQL\PlSQL\creation\supply_str\t_supply_str_autocomplete_restriction_update_trigger.sql" 
@"E:\work\Learning-SQL\PlSQL\creation\supply_str\t_supply_str_fill_summa_nds_trigger.sql"
@"E:\work\Learning-SQL\PlSQL\creation\supply_str\t_supply_fill_summa_nds_delete_trigger.sql" 
@"E:\work\Learning-SQL\PlSQL\creation\supply_str\t_supply_fill_summa_nds_insert_trigger.sql" 
@"E:\work\Learning-SQL\PlSQL\creation\supply_str\t_supply_fill_summa_nds_update_trigger.sql"

-- sale triggers
@"E:\work\Learning-SQL\PlSQL\creation\sale\t_sale_autocomplete_restriction_insert_trigger.sql" 
@"E:\work\Learning-SQL\PlSQL\creation\sale\t_sale_autocomplete_restriction_update_trigger.sql"
@"E:\work\Learning-SQL\PlSQL\creation\sale\t_sale_state_restriction_insert_trigger.sql" 
@"E:\work\Learning-SQL\PlSQL\creation\sale\t_sale_state_restriction_update_trigger.sql"
@"E:\work\Learning-SQL\PlSQL\creation\sale\t_sale_state_restriction_delete_trigger.sql"
@"E:\work\Learning-SQL\PlSQL\creation\sale\t_sale_disable_sale_str_delete_triggers.sql"
@"E:\work\Learning-SQL\PlSQL\creation\sale\t_sale_enable_sale_str_delete_triggers.sql"
@"E:\work\Learning-SQL\PlSQL\creation\sale\t_sale_done_state_restriction_update_trigger.sql"  
@"E:\work\Learning-SQL\PlSQL\creation\sale\t_sale_no_stocks_restriction_update_trigger.sql"  
@"E:\work\Learning-SQL\PlSQL\creation\sale\t_sale_discount_change_str_update_trigger.sql"
@"E:\work\Learning-SQL\PlSQL\creation\sale\t_sale_state_sales_rep_update_trigger.sql" 
@"E:\work\Learning-SQL\PlSQL\creation\sale\t_sale_state_ware_qty_change_update_trigger.sql" 
@"E:\work\Learning-SQL\PlSQL\creation\sale\t_sale_state_ware_rest_hist_change_update_trigger.sql" 

-- sale str triggers
@"E:\work\Learning-SQL\PlSQL\creation\sale_str\t_sale_str_state_restriction_delete_trigger.sql" 
@"E:\work\Learning-SQL\PlSQL\creation\sale_str\t_sale_str_state_restriction_insert_trigger.sql" 
@"E:\work\Learning-SQL\PlSQL\creation\sale_str\t_sale_str_state_restriction_update_trigger.sql"
@"E:\work\Learning-SQL\PlSQL\creation\sale_str\t_sale_str_autocomplete_restriction_insert_trigger.sql" 
@"E:\work\Learning-SQL\PlSQL\creation\sale_str\t_sale_str_autocomplete_restriction_update_trigger.sql" 
@"E:\work\Learning-SQL\PlSQL\creation\sale_str\t_sale_str_fill_price_trigger.sql"
@"E:\work\Learning-SQL\PlSQL\creation\sale_str\t_sale_str_fill_summa_nds_trigger.sql" 
@"E:\work\Learning-SQL\PlSQL\creation\sale_str\t_sale_fill_summa_nds_delete_trigger.sql" 
@"E:\work\Learning-SQL\PlSQL\creation\sale_str\t_sale_fill_summa_nds_insert_trigger.sql" 
@"E:\work\Learning-SQL\PlSQL\creation\sale_str\t_sale_fill_summa_nds_update_trigger.sql"

--sale report triggers
@"E:\work\Learning-SQL\PlSQL\creation\sale_rep\t_sales_report_fill_fields_insert_trigger.sql" 
@"E:\work\Learning-SQL\PlSQL\creation\sale_rep\t_sales_report_fill_fields_update_trigger.sql"

--ctl node triggers
@"E:\work\Learning-SQL\PlSQL\creation\ctl_node\t_node_fill_tree_code_insert_trigger.sql" 
@"E:\work\Learning-SQL\PlSQL\creation\ctl_node\t_node_fill_tree_code_update_trigger.sql"  

-- population
@"E:\work\Learning-SQL\PlSQL\population\1_initial_data_population.sql" 
@"E:\work\Learning-SQL\PlSQL\population\2_t_ware population.sql" 
@"E:\work\Learning-SQL\PlSQL\population\3_t_model_price population.sql" 
@"E:\work\Learning-SQL\PlSQL\population\4_t_ware_price population.sql" 
@"E:\work\Learning-SQL\PlSQL\population\5_t_supply_population.sql" 
@"E:\work\Learning-SQL\PlSQL\population\6_t_supply_str_population.sql" 
@"E:\work\Learning-SQL\PlSQL\population\7_t_sale_population.sql" 
@"E:\work\Learning-SQL\PlSQL\population\8_t_sale_str_population.sql"  
  

