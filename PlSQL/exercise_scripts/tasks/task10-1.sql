-- TASK-10 Набор процедур для элементарных операций над узлами каталога, обеспечивающих вычисление иерархического кода: 
--         вставка, перемещение в иерархии, переименование.

-- procedure to add new node with filled tree code

CREATE OR REPLACE PROCEDURE add_node (v_id_parent t_ctl_node.id_parent%TYPE, 
                                      v_code      t_ctl_node.code%TYPE, 
                                      v_name      t_ctl_node.name%TYPE)
IS
   v_tree_code t_ctl_node.tree_code%TYPE;
BEGIN
   SELECT tree_code INTO v_tree_code FROM t_ctl_node WHERE id_ctl_node = v_id_parent;
   IF v_tree_code IS NOT NULL THEN
      v_tree_code := CONCAT (v_tree_code, '/'||v_code);
   ELSE
      v_tree_code := '/'||v_code;
   END IF;
   
   INSERT INTO t_ctl_node (id_parent, code, tree_code, name)
   VALUES (v_id_parent, v_code, v_tree_code, v_name);
   
   COMMIT;
END;
/
