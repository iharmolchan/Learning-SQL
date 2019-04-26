--QUERY-03 Вывод каталога с отступами в соответствии с уровнями каталога. Для каждого узла — число нижележащих узлов.

SELECT 
   LPAD(' ', 5 * (LEVEL - 1)) || 
   name                       ||
   CASE  -- skip writing number of children for leafs
      WHEN CONNECT_BY_ISLEAF=0 
      THEN ' (' || number_of_children || ')' 
   END
   AS "Name (Number of underlying nodes)"
FROM 
   t_ctl_node
LEFT JOIN ( 
   -- counting number of roots (e.g. number og children for every root)
   SELECT 
      COUNT(*) number_of_children, 
      root_node_id
   FROM (
      -- selecting root node for every child node from every level
      SELECT 
         connect_by_root(id_ctl_node) root_node_id
      FROM 
         t_ctl_node
      WHERE LEVEL = 2 -- number of levels of children to count (1st lvl - node themselves, 2nd - childes of nodes, >2nd lvl - childs of childs etc.)
      CONNECT BY id_parent = PRIOR id_ctl_node)
   GROUP BY root_node_id)
ON id_ctl_node = root_node_id
CONNECT BY id_parent = PRIOR id_ctl_node
START WITH id_parent IS NULL
ORDER SIBLINGS BY id_ctl_node;
                              
