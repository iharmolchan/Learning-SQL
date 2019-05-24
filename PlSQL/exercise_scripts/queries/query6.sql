--QUERY-06 Вывод каталога с отступами, для каждого узла — число моделей и товаров в нем и нижележащих узлах

SELECT 
   LPAD(' ',5*(LEVEL-1)) ||
   name                  ||
   ' ('                  ||
   number_of_models      ||
   ') ('                 ||
   number_of_wares       ||
   ')'          
   AS "Name(Number of models)(Number of wares)"
FROM 
   t_ctl_node
INNER JOIN (   
   -- counting distinct number of models and ware for every node  
   SELECT 
      COUNT(DISTINCT id_model) number_of_models, 
      COUNT(DISTINCT id_ware) number_of_wares, 
      root_node_id
   FROM (
      -- selecting models and wares for every node with recursion
      SELECT 
         connect_by_root(id_ctl_node) root_node_id, 
         id_model, 
         id_ware
      FROM 
         t_ctl_node
      LEFT JOIN t_model ON id_node = id_ctl_node
      LEFT JOIN t_ware USING (id_model)
      CONNECT BY id_parent = PRIOR id_ctl_node)
   GROUP BY root_node_id)
ON id_ctl_node=root_node_id
CONNECT BY PRIOR id_ctl_node=id_parent
START WITH id_parent IS NULL
ORDER SIBLINGS BY name;
