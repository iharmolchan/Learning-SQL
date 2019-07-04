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
         e_state = 'DONE' AND dt < '&FROM_DATE'
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
         e_state = 'DONE' AND dt < '&FROM_DATE'
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
         e_state = 'DONE' AND dt BETWEEN '&FROM_DATE' AND '&TO_DATE'
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
         e_state = 'DONE' AND dt BETWEEN '&FROM_DATE' AND '&TO_DATE'
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
