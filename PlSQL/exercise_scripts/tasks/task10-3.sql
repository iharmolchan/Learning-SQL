-- TASK-10 Набор процедур для элементарных операций над узлами каталога, обеспечивающих вычисление иерархического кода: 
--         вставка, перемещение в иерархии, переименование.

-- procedure to rename node with hierarchy

CREATE OR REPLACE PROCEDURE rename_node_code (v_id_node   t_ctl_node.id_ctl_node%TYPE,
                                              v_new_code  t_ctl_node.code%TYPE)
IS
   v_tree_code t_ctl_node.tree_code%TYPE;
   v_id_parent t_ctl_node.id_parent%TYPE;
   
   CURSOR cur_children IS SELECT id_ctl_node, code
                          FROM t_ctl_node
                          WHERE id_ctl_node != v_id_node
                          CONNECT BY id_parent = PRIOR id_ctl_node
                          START WITH id_ctl_node = v_id_node
                          ORDER BY LEVEL;
BEGIN
   BEGIN
      SELECT id_parent INTO v_id_parent FROM t_ctl_node WHERE id_ctl_node = v_id_node;
      SELECT tree_code INTO v_tree_code FROM t_ctl_node WHERE id_ctl_node = v_id_parent;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      NULL;   
   END;
   
   IF v_tree_code IS NOT NULL THEN
      v_tree_code := CONCAT (v_tree_code, '/'||v_new_code);
   ELSE
      v_tree_code := '/'||v_new_code;
   END IF;
   
   UPDATE t_ctl_node 
   SET code = v_new_code, tree_code = v_tree_code
   WHERE id_ctl_node = v_id_node;
   
   COMMIT;
   
   FOR r_child IN cur_children
   LOOP
      rename_node_code(r_child.id_ctl_node, r_child.code);
   END LOOP;   
   
   COMMIT;
END;
/
