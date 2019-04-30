-- QUERY-10 Выявить наиболее характерные значения скидок. 
--          Для этого построить распределение по предоставляемым скидкам, для каждой определить количество позиций, 
--          товаров и моделей, колдичество и сумму продаж.

SELECT
   round(discount),
   COUNT(*) number_of_positions, 
   COUNT(DISTINCT id_ware),
   COUNT(DISTINCT id_model),  
   SUM(summa), 
   SUM (QTY)    
FROM 
   t_sale_str
INNER JOIN t_ware USING(id_ware)   
INNER JOIN t_model USING(id_model)   
GROUP BY discount
ORDER BY number_of_positions DESC
