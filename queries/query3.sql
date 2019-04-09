--QUERY-03 Вывод каталога с отступами в соответствии с уровнями каталога. Для каждого узла — число нижележащих узлов.
   
   SELECT LPAD(' ',5*(LEVEL-1))||code||': '||name||'('||number_of_childs||')' "Code:Name(Number of childs)"
   FROM t_ctl_node
   INNER JOIN (   
     SELECT ( COUNT(*) -1 ) number_of_childs, root
     FROM (
       SELECT id_ctl_node, connect_by_root(code) root
       FROM t_ctl_node
       CONNECT BY id_parent = PRIOR id_ctl_node)
     GROUP BY root)
   ON t_ctl_node.code=root
   CONNECT BY PRIOR id_ctl_node=id_parent
   START WITH code='all'
   ORDER SIBLINGS BY code;
  

   
