--TASK-11 Альтернатива предыдущему: триггера, обеспечивающие вычисление иерархического кода для узлов каталога. 
--        Это сложнее, чем набор процедур.

CREATE OR REPLACE TRIGGER t_node_fill_tree_code_insert
BEFORE INSERT ON t_ctl_node
FOR EACH ROW
DECLARE
   v_parent_tree_code t_ctl_node.tree_code%TYPE;
BEGIN
   BEGIN
      SELECT tree_code INTO v_parent_tree_code FROM t_ctl_node WHERE id_ctl_node = :new.id_parent;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      NULL;
   END;
      
   IF v_parent_tree_code IS NOT NULL THEN
      :new.tree_code := CONCAT(v_parent_tree_code, '/'||:new.code);
   ELSE
      :new.tree_code := '/'||:new.code;
   END IF;      
END;
/
