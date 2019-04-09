--QUERY-03 Вывод каталога с отступами в соответствии с уровнями каталога. Для каждого узла — число нижележащих узлов.
   
   SELECT LPAD(' ',5*(LEVEL-1))||code||': '||name "Code:Name"
   FROM t_ctl_node
   CONNECT BY PRIOR id_ctl_node=id_parent
   START WITH CODE='all'
   ORDER SIBLINGS BY code;
   
   SELECT ( COUNT(*) -1 ) number_of_childs, root
   FROM ( SELECT connect_by_root(code) root
   FROM t_ctl_node
   CONNECT BY id_parent = PRIOR id_ctl_node)
   GROUP BY root;

   
