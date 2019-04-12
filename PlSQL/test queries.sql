/*select *
from t_ctl_node
connect by 
   id_parent = prior id_ctl_node
start with 
   id_ctl_node=100000;*/
   
   select lpad(' ',5*(level-1))||code||': '||name "Code:Name", connect_by_root(code)
   from t_ctl_node
   connect by prior id_ctl_node=id_parent
   start with code='all'
   order siblings by code;
   
   select ( count(*) -1 ) number_of_childs, root
   from ( select connect_by_root(code) root
   from   t_ctl_node
   connect by id_parent = prior id_ctl_node)
   group by     root
   order by root;

   
