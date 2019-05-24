--QUERY-01 Найти товары, цены на которые отличаются от цены на модель.

SELECT 
   id_ware,
   moniker,     
   name,
   pw.price AS ware_price,
   pm.price AS model_price
FROM 
   t_ware
INNER JOIN t_price_model pm USING (id_model)
INNER JOIN t_price_ware pw USING (id_ware)
WHERE pw.price != pm.price;
