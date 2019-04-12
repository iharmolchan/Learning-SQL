--QUERY-04 Вывод таблицы подразделений с отступами в соответствии с уровнями каталога
   
   SELECT LPAD(' ',5*(LEVEL-1)) || name "Name"
   FROM t_dept
   CONNECT BY PRIOR id_dept=id_parent
   START WITH id_parent is null
   ORDER SIBLINGS BY name;
