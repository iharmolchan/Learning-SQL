-- QUERY-09 Выдать отчет о продажах по подразделениям, для каждого подразделения в дереве в отчет включать подчиненные.
--          В отчете — число продаж, число строк, количество, общая сумма.

WITH 
   department_sales_report (id_dept, number_of_sales, number_of_sale_strings, sales_quantity, sales_sum) 
AS( 
   SELECT
      id_dept,
      COUNT(DISTINCT id_sale),
      COUNT(DISTINCT id_sale_str),
      SUM (qty),
      SUM (st.summa)
   FROM
      t_dept   
   INNER JOIN t_client USING (id_dept)
   INNER JOIN t_sale USING (id_client)
   INNER JOIN t_sale_str st USING (id_sale)
   GROUP BY
      id_dept)
SELECT 
   LPAD(' ',5*(LEVEL-1)) || name   AS "Name",
   NVL(number_of_sales, 0)         AS number_of_sales,
   NVL(number_of_sale_strings, 0)  AS number_of_sale_strings,
   NVL(sales_quantity, 0)          AS sales_quantity,
   NVL(sales_sum, 0)               AS sales_sum
FROM 
   t_dept
LEFT JOIN department_sales_report USING (id_dept)    
CONNECT BY PRIOR id_dept=id_parent
START WITH id_parent IS NULL
ORDER SIBLINGS BY name;
