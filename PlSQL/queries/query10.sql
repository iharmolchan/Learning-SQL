-- QUERY-10 Выявить наиболее характерные значения скидок. 
--          Для этого построить распределение по предоставляемым скидкам, для каждой определить количество позиций, 
--          товаров и моделей, колдичество и сумму продаж.

SELECT
   ROUND(discount)           AS discount_percent,
   COUNT(*)                  AS number_of_positions, 
   COUNT(DISTINCT id_ware)   AS number_of_wares,
   COUNT(DISTINCT id_model)  AS number_of_models,  
   SUM(summa)                AS sum_of_sales, 
   SUM (QTY)                 AS quantity_of_wares_sold  
FROM
   t_sale_str
INNER JOIN t_ware USING(id_ware)   
INNER JOIN t_model USING(id_model)
WHERE
   discount>0   
GROUP BY discount
ORDER BY quantity_of_wares_sold DESC
