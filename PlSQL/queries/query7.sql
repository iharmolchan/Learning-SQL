--QUERY-07 Вычислить число продаж, их общую сумму, средневзвешенную, максимальную и минимальную скидки по каждому клиенту, 
--         у которых были продажи со скидкой более, чем 25%. Все — без учета скидок на строки

SELECT 
   id_client             AS client_id,
   moniker               AS short_name,
   COUNT(*)              AS number_of_sales,
   SUM(summa)            AS overall_sum,
   ROUND(AVG(summa), 2)  AS average_sale_sum,
   MAX(discount)         AS max_discount,
   MIN (discount)        AS min_discount
FROM 
   t_sale
INNER JOIN t_client USING (id_client)
GROUP BY
   id_client,
   moniker 
HAVING
   MAX(discount)>25
