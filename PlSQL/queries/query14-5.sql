-- QUERY-14 Различные отчеты по прибылям от продажи — в разрезе моделей, товарных групп, торговых марок, клиентов и подразделений.
--          Сортировка по максимальной абсолютной и относительной прибыли.

-- BY DEPARTMENT
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
   id_dept,
   d.name,
   SUM(qty) overall_quantity,
   SUM(abs_profit) overall_profit,   
   ROUND(SUM(abs_profit) / SUM(qty), 2) AS relative_profit   
FROM   
   sales_profit_report
INNER JOIN t_client USING (id_client)
INNER JOIN t_dept d USING (id_dept) 
GROUP BY 
   id_dept,
   d.name
ORDER BY 
   overall_profit DESC, 
   relative_profit DESC;
