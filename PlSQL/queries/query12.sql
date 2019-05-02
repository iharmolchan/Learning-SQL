-- QUERY-12 Вывод таблицы подразделений, для каждого узла — сумма продаж за заданный месяц. 
--          Написать запрос по таблице с отчетом и по исходным документам. Проверить соответствие.

WITH 
   department_sales_report (id_dept, sales_sum) 
AS( 
   SELECT
      id_dept,
      SUM (summa)
   FROM
      t_dept   
   INNER JOIN t_client USING (id_dept)
   INNER JOIN t_sale USING (id_client)
   WHERE
      TRUNC (dt, 'MM') = TO_DATE('2019-02', 'YYYY-MM') -- february of 2019 for example 
   GROUP BY
      id_dept)
SELECT 
   LPAD(' ',5*(LEVEL-1)) || name  AS "Name",
   NVL(sales_sum, 0)              AS sales_sum
FROM 
   t_dept
LEFT JOIN department_sales_report USING (id_dept)    
CONNECT BY PRIOR id_dept=id_parent
START WITH id_parent IS NULL
ORDER SIBLINGS BY name;
