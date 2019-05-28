
-- creating client role
-- client can only browse catalogue
CREATE ROLE r_client;
GRANT SELECT ON shop.t_ctl_node TO r_client;
GRANT SELECT ON shop.t_model TO r_client;
GRANT SELECT ON shop.t_ware TO r_client;
/

-- creating salesman role
-- salesman can browse catalogue and manage sales
CREATE ROLE r_salesman;
GRANT SELECT ON shop.t_ctl_node TO r_salesman;
GRANT SELECT ON shop.t_model TO r_salesman;
GRANT SELECT ON shop.t_ware TO r_salesman;
GRANT SELECT ON shop.t_client TO r_salesman;
GRANT ALL ON shop.t_sale TO r_salesman;
GRANT ALL ON shop.t_sale_str TO r_salesman;
/

-- creating tovaroved role
-- tovaroved can edit catalogue and browse supply, sale and stocks information about wares
CREATE ROLE r_tovaroved;
GRANT ALL ON shop.t_ctl_node TO r_tovaroved;
GRANT ALL ON shop.t_model TO r_tovaroved;
GRANT ALL ON shop.t_ware TO r_tovaroved;
GRANT SELECT ON shop.t_sale TO r_tovaroved;
GRANT SELECT ON shop.t_sale_str TO r_tovaroved;
GRANT SELECT ON shop.t_client TO r_tovaroved;
GRANT SELECT ON shop.t_sale_rep TO r_tovaroved;
GRANT SELECT ON shop.t_rest TO r_tovaroved;
GRANT SELECT ON shop.t_rest_hist TO r_tovaroved;
GRANT SELECT ON shop.t_supply TO r_tovaroved;
GRANT SELECT ON shop.t_supply_str TO r_tovaroved;
GRANT SELECT ON shop.t_supplier TO r_tovaroved;
/

-- creating operator role
-- operator can manage supplies, ware prices and add new wares
CREATE ROLE r_operator;
GRANT SELECT ON shop.t_ctl_node TO r_operator;
GRANT SELECT, INSERT ON shop.t_model TO r_operator;
GRANT SELECT, INSERT ON shop.t_ware TO r_operator;
GRANT ALL ON shop.t_supply TO r_operator;
GRANT ALL ON shop.t_supply_str TO r_operator;
GRANT ALL ON shop.t_supplier TO r_operator;
GRANT ALL ON shop.t_price_model TO r_operator;
GRANT ALL ON shop.t_price_ware TO r_operator;
/


