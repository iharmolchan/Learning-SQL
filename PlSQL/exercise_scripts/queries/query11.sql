-- QUERY-11  Найти модели, на которые предоставлены нехарактерно большие скидки, с учетом предыдущего анализа. 
--           Сделать предположение о с составе этих моделей

SELECT 
   id_model, 
   m.name AS model_name,
   ROUND(AVG(discount)) AS average_discount_by_model
FROM 
   t_model m
INNER JOIN t_ware USING (id_model)
INNER JOIN t_sale_str USING (id_ware)
WHERE
   discount > 0
GROUP BY 
   id_model, 
   m.name
HAVING 
   AVG(discount) > (SELECT AVG(discount)FROM t_sale_str WHERE discount>0) + 15;
/



