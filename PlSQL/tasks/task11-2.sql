--TASK-11 Альтернатива предыдущему: триггера, обеспечивающие вычисление иерархического кода для узлов каталога. 
--        Это сложнее, чем набор процедур.

CREATE OR REPLACE TRIGGER t_node_fill_tree_code_update
FOR UPDATE OF code ON t_ctl_node
COMPOUND TRIGGER
   TYPE idNodeArray IS TABLE OF t_ctl_node.id_ctl_node%TYPE INDEX BY BINARY_INTEGER;
   v_node_ids idNodeArray;   
   v_parent_tree_code t_ctl_node.tree_code%TYPE;   
   n_id_ctl_node t_ctl_node.id_ctl_node%TYPE;   
   CURSOR cur_children_ids IS SELECT id_ctl_node, id_parent
                              FROM t_ctl_node
                              WHERE id_ctl_node != n_id_ctl_node
                              CONNECT BY PRIOR id_ctl_node = id_parent
                              START WITH id_ctl_node = n_id_ctl_node
                              ORDER BY LEVEL;
                              
BEFORE EACH ROW IS
BEGIN   
   IF :new.code != :old.code THEN
      :new.tree_code := CONCAT(SUBSTR(:old.tree_code, 1, INSTR( :old.tree_code, :old.code, -1) -2), '/'||:new.code);
      v_node_ids(v_node_ids.count) := :new.id_ctl_node;     
   END IF;
END BEFORE EACH ROW;
  
AFTER STATEMENT IS
BEGIN  
   IF v_node_ids.count > 0 THEN      
      FOR n_array_index IN 0 .. v_node_ids.count -1
      LOOP
         n_id_ctl_node := v_node_ids(n_array_index);
         FOR r_node IN cur_children_ids
         LOOP         
            SELECT tree_code INTO v_parent_tree_code FROM t_ctl_node WHERE id_ctl_node = r_node.id_parent;            
            UPDATE t_ctl_node 
            SET tree_code = CONCAT (v_parent_tree_code, '/'||code)
            WHERE id_ctl_node = r_node.id_ctl_node;       
         END LOOP;   
      END LOOP;   
   END IF;
END AFTER STATEMENT;

END t_node_fill_tree_code_update;
/
