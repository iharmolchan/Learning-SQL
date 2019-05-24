-- QUERY-14 Различные отчеты по прибылям от продажи — в разрезе моделей, товарных групп, торговых марок, клиентов и подразделений.
--          Сортировка по максимальной абсолютной и относительной прибыли.

-- BY MODEL
WITH sales_profit_report
AS(
   SELECT 
      id_ware, 
      qty,
      summa - pw.price * qty AS abs_profit
   FROM t_sale_str
   INNER JOIN t_price_ware pw USING (id_ware))
SELECT 
   id_model,
   m.moniker,
   SUM(qty) overall_quantity,
   SUM(abs_profit) overall_profit,   
   ROUND(SUM(abs_profit) / SUM(qty), 2) AS relative_profit   
FROM   
   sales_profit_report
INNER JOIN t_ware USING (id_ware) 
INNER JOIN t_model m USING (id_model)
GROUP BY 
   id_model, 
   m.moniker
ORDER BY 
   overall_profit DESC, 
   relative_profit DESC;
