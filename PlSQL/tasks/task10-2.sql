-- TASK-10 Набор процедур для элементарных операций над узлами каталога, обеспечивающих вычисление иерархического кода: 
--         вставка, перемещение в иерархии, переименование.

-- procedure to move node in hierarchy

CREATE OR REPLACE PROCEDURE move_node (v_id_node        t_ctl_node.id_ctl_node%TYPE,
                                       v_new_id_parent  t_ctl_node.id_parent%TYPE)
IS
   v_tree_code t_ctl_node.tree_code%TYPE;
   v_code t_ctl_node.code%TYPE;
   CURSOR cur_children IS SELECT id_ctl_node, id_parent
                          FROM t_ctl_node
                          WHERE id_ctl_node != v_id_node
                          CONNECT BY id_parent = PRIOR id_ctl_node
                          START WITH id_ctl_node = v_id_node
                          ORDER BY LEVEL;
BEGIN
   SELECT tree_code INTO v_tree_code FROM t_ctl_node WHERE id_ctl_node = v_new_id_parent;
   SELECT code INTO v_code FROM t_ctl_node WHERE id_ctl_node = v_id_node;
   
   IF v_tree_code IS NOT NULL THEN
      v_tree_code := CONCAT (v_tree_code, '/'||v_code);
   ELSE
      v_tree_code := '/'||v_code;
   END IF;
   
   UPDATE t_ctl_node 
   SET id_parent = v_new_id_parent, tree_code = v_tree_code
   WHERE id_ctl_node = v_id_node;
   
   FOR r_child IN cur_children
   LOOP
      move_node(r_child.id_ctl_node, r_child.id_parent);
   END LOOP;   
   
   COMMIT;
END;
/
