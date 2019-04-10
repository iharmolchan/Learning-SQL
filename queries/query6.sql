--QUERY-06 Вывод каталога с отступами, для каждого узла — число моделей и товаров в нем и нижележащих узлах

   SELECT LPAD(' ',5*(LEVEL-1))||
          code||
          ': '||
          name||
          '('||
          number_of_models||
          ')('||
          number_of_wares||
          ')'          
          "Code:Name(Number of models)(Number of wares)"
   FROM t_ctl_node
   INNER JOIN (   
     SELECT COUNT( distinct moniker) number_of_models, COUNT(sz_orig) number_of_wares, root
     FROM (
       SELECT id_ctl_node, connect_by_root(code) root, t_model.moniker, sz_orig
       FROM t_ctl_node
       LEFT JOIN t_model
       ON id_node = id_ctl_node
       LEFT JOIN t_ware
       ON t_model.id_model=t_ware.id_model
       CONNECT BY id_parent = PRIOR id_ctl_node)
   GROUP BY root)
   ON t_ctl_node.code=root
   CONNECT BY PRIOR id_ctl_node=id_parent
   START WITH id_parent is null
   ORDER SIBLINGS BY code;
