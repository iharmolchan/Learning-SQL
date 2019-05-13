--TASK-12 Набор процедур элементарных действий или триггера, контролирующие отсутствие циклов в иерархии подразделений.

CREATE OR REPLACE TRIGGER t_dept_nocycle_restriction
AFTER INSERT OR UPDATE ON t_dept
DECLARE
   n_is_loop_exists NUMBER; 
BEGIN
   SELECT SUM(connect_by_iscycle) INTO n_is_loop_exists FROM t_dept CONNECT BY NOCYCLE PRIOR id_dept=id_parent;
   IF n_is_loop_exists > 0 THEN
      RAISE_APPLICATION_ERROR(-20010,'your action causes loop statement in department table');
   END IF;       
END;
/
