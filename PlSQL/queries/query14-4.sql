-- QUERY-14 Различные отчеты по прибылям от продажи — в разрезе моделей, товарных групп, торговых марок, клиентов и подразделений.
--          Сортировка по максимальной абсолютной и относительной прибыли.

-- BY CLIENT
WITH sales_profit_report
AS(
   SELECT 
      id_client, 
      qty,
      st.summa - pw.price * qty AS abs_profit
   FROM t_sale_str st
   INNER JOIN t_price_ware pw USING (id_ware)
   INNER JOIN t_sale s USING (id_sale))
SELECT 
   id_client,
   moniker,
   SUM(qty) overall_quantity,
   SUM(abs_profit) overall_profit,   
   ROUND(SUM(abs_profit) / SUM(qty), 2) AS relative_profit   
FROM   
   sales_profit_report
INNER JOIN t_client USING (id_client) 
GROUP BY 
   id_client,
   moniker
ORDER BY 
   overall_profit DESC, 
   relative_profit DESC;
