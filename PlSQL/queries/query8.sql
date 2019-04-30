--QUERY-08 Вычислить число строк продаж, количество, сумму средневзвешенную, 
--         максимальную и минимальную скидку по торговой марке (t_model.label).

SELECT
   label         AS ware_label,
   count(*)      AS number_of_sales,
   sum(qty)      AS overall_quantity,
   avg(summa)    AS average_sale,
   max(discount) AS max_discount,
   min(discount) AS min_discount
FROM
   t_sale_str
INNER JOIN 
   t_ware USING (id_ware)
INNER JOIN 
   t_model USING (id_model)
GROUP BY 
   label
ORDER BY
   ware_label       
