-- QUERY-13 Стандратная оборотка по товару в штуках за период: остаток на начало, приход, уход, остаток на конец

--creating package to set context variables (dates) for searching
--package 
CREATE OR REPLACE PACKAGE pkg_shop_app_context
IS
   PROCEDURE set_from_date (from_date_p IN DATE);
   PROCEDURE set_to_date (to_date_p IN DATE);
END;
/

--package body
CREATE OR REPLACE PACKAGE BODY pkg_shop_app_context
IS
   context_name_gv VARCHAR2(30) := 'SHOP_APP_CONTEXT';
   
   PROCEDURE set_from_date (from_date_p IN DATE) 
   IS
   BEGIN
      dbms_session.set_context(context_name_gv, 'FROM_DATE', from_date_p);
   END;

   PROCEDURE set_to_date (to_date_p IN DATE)
   IS
   BEGIN
      dbms_session.set_context(context_name_gv, 'TO_DATE', to_date_p);
   END;
END;
/

--context
CREATE OR REPLACE CONTEXT shop_app_context
USING pkg_shop_app_context
ACCESSED GLOBALLY;
/

-- creating view using context and 4 CTEs to get data
CREATE OR REPLACE VIEW vw_rest_ware_report
AS
   WITH 
      supply_start_cte (id_ware, start_supply_qty) -- supply before starting date  
      AS(   
         SELECT 
            id_ware, 
            SUM(qty)
         FROM 
            t_supply_str
         INNER JOIN t_supply USING (id_supply)
         WHERE 
            e_state = 'DONE' AND dt < SYS_CONTEXT('SHOP_APP_CONTEXT','FROM_DATE')
         GROUP BY
            id_ware),
      sale_start_cte  (id_ware, start_sale_qty)  -- sales before starting date           
      AS(
         SELECT 
            id_ware, 
            SUM(qty) 
         FROM 
            t_sale_str
         INNER JOIN t_sale USING (id_sale)
         WHERE 
            e_state = 'DONE' AND dt < SYS_CONTEXT('SHOP_APP_CONTEXT','FROM_DATE')
         GROUP BY
            id_ware),
      supply_period_cte (id_ware, period_supply_qty) -- supply in period between two used dates  
      AS(   
         SELECT 
            id_ware, 
            SUM(qty)
         FROM 
            t_supply_str
         INNER JOIN t_supply USING (id_supply)
         WHERE 
            e_state = 'DONE' AND dt BETWEEN SYS_CONTEXT('SHOP_APP_CONTEXT','FROM_DATE') AND SYS_CONTEXT('SHOP_APP_CONTEXT','TO_DATE')
         GROUP BY
            id_ware),
      sale_period_cte  (id_ware, period_sale_qty) -- sale in period between two used dates             
      AS(
         SELECT 
            id_ware, 
            SUM(qty) 
         FROM 
            t_sale_str
         INNER JOIN t_sale USING (id_sale)
         WHERE 
            e_state = 'DONE' AND dt BETWEEN SYS_CONTEXT('SHOP_APP_CONTEXT','FROM_DATE') AND SYS_CONTEXT('SHOP_APP_CONTEXT','TO_DATE')
         GROUP BY
            id_ware)               
   SELECT 
      id_ware                                                                                                  AS ware_id, 
      moniker                                                                                                  AS ware_name,
      NVL(start_supply_qty, 0) - NVL(start_sale_qty, 0)                                                        AS start_quantity,
      NVL(period_supply_qty, 0)                                                                                AS supply,
      NVL(period_sale_qty, 0)                                                                                  AS sales,
      NVL(start_supply_qty, 0) - NVL(start_sale_qty, 0) + NVL(period_supply_qty, 0) - NVL(period_sale_qty, 0)  AS end_quantity
   FROM
      t_ware
   LEFT JOIN supply_start_cte USING (id_ware)
   LEFT JOIN sale_start_cte USING (id_ware)
   LEFT JOIN supply_period_cte USING (id_ware)
   LEFT JOIN sale_period_cte USING (id_ware)
   ORDER BY 
      id_ware; 
/
-- set up dates for selecting from view
BEGIN
   pkg_shop_app_context.set_from_date(DATE '2018-11-10'); --FROM DATE 
   pkg_shop_app_context.set_to_date(DATE '2018-11-20');   --TO DATE
END;
/
-- and select * from our view
SELECT 
   *
FROM 
   vw_rest_ware_report;
/
