--QUERY-02 Найти продажи, цены без скидки в которых отличаются от цены на товар.

SELECT 
   id_sale,
   dt       AS sale_date,
   c.name   AS client_name,
   s.price  AS sale_price,
   w.name   AS ware_name,
   w.price  AS ware_price
FROM 
   t_sale
INNER JOIN t_client c USING (id_client)
INNER JOIN t_sale_str s USING (id_sale)
INNER JOIN t_ware w USING (id_ware)
INNER JOIN t_price_ware USING (id_ware)
WHERE s.price != w.price
