-- QUERY-14 Различные отчеты по прибылям от продажи — в разрезе моделей, товарных групп, торговых марок, клиентов и подразделений.
--          Сортировка по максимальной абсолютной и относительной прибыли.

-- BY NODE
WITH sales_profit_report
AS(
   SELECT 
      id_ware, 
      qty,
      summa - pw.price * qty AS abs_profit
   FROM t_sale_str
   INNER JOIN t_price_ware pw USING (id_ware))
SELECT 
   n.name,
   SUM(qty) overall_quantity,
   SUM(abs_profit) overall_profit,   
   ROUND(SUM(abs_profit) / SUM(qty), 2) AS relative_profit   
FROM   
   sales_profit_report
INNER JOIN t_ware USING (id_ware) 
INNER JOIN t_model m USING (id_model)
INNER JOIN t_ctl_node n ON (id_node = id_ctl_node)
GROUP BY 
   n.name
ORDER BY 
   overall_profit DESC, 
   relative_profit DESC     
