--QUERY-05 Вывод каталога с отступами, для листа с товарами — число моделей и товаров в нем.

SELECT 
   LPAD(' ',5*(LEVEL-1)) || 
   name                  ||
   CASE 
      WHEN number_of_models != 0 
      THEN ' ('||number_of_models||')' 
   END                   ||
   CASE 
      WHEN number_of_wares  != 0 
      THEN ' ('||number_of_wares||')'  
   END
   AS "Name (Number of models) (Number of wares)"          
FROM 
   t_ctl_node
INNER JOIN (
   -- selecting distinct number of models and wares for every node   
   SELECT 
      id_ctl_node, 
      COUNT(DISTINCT id_model) number_of_models, 
      COUNT(DISTINCT id_ware) number_of_wares
   FROM
      t_ctl_node
   LEFT JOIN t_model ON id_node=id_ctl_node
   LEFT JOIN t_ware USING (id_model)
   GROUP BY id_ctl_node)
USING(id_ctl_node)
CONNECT BY PRIOR id_ctl_node=id_parent
START WITH id_parent IS NULL
ORDER SIBLINGS BY name;
