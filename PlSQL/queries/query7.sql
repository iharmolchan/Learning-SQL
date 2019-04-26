--QUERY-07 Вычислить число продаж, их общую сумму, средневзвешенную, максимальную и минимальную скидки по каждому клиенту, 
--         у которых были продажи со скидкой более, чем 25%. Все — без учета скидок на строки

SELECT 
   s.id_client      AS client_id,
   moniker        AS short_name,
   COUNT(*)       AS number_of_sales,
   SUM(summa)     AS overall_sum,
   AVG(summa)     AS average_sale_sum,
   MAX(discount)  AS max_discount,
   MIN (discount) AS min_discount
FROM 
   t_sale s
INNER JOIN t_client c ON s.id_client=c.id_client
WHERE EXISTS(
   SELECT 
      * 
   FROM 
      t_sale
   WHERE 
      discount>25 AND id_client =s.id_client
)
GROUP BY
   s.id_client,
   moniker  
