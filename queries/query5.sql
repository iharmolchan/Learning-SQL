--QUERY-05 Вывод каталога с отступами, для листа с товарами — число моделей и товаров в ним.

   SELECT LPAD(' ',5*(LEVEL-1))||
          code||
          ': '||
          name||
          CASE WHEN number_of_models = 0 THEN '' ELSE '('||to_char(number_of_models)||')' END||
          CASE WHEN number_of_wares = 0 THEN '' ELSE '('||to_char(number_of_wares)||')' END
          "Code:Name(Number of models)(Number od wares)"          
   FROM t_ctl_node
   INNER JOIN (   
     SELECT COUNT(DISTINCT moniker) number_of_models, COUNT(sz_orig) number_of_wares, root 
     FROM(
       SELECT code root, t_model.moniker, sz_orig
       FROM t_ctl_node
       LEFT JOIN t_model
       ON id_node=id_ctl_node
       LEFT JOIN t_ware
       ON t_model.id_model=t_ware.id_model)
     GROUP BY root)
   ON t_ctl_node.code=root
   CONNECT BY PRIOR id_ctl_node=id_parent
   START WITH id_parent IS NULL
   ORDER SIBLINGS BY code;
