--TASK-11 Альтернатива предыдущему: триггера, обеспечивающие вычисление иерархического кода для узлов каталога. 
--        Это сложнее, чем набор процедур.

CREATE OR REPLACE TRIGGER t_node_fill_tree_code_parent_update
FOR UPDATE OF id_parent ON t_ctl_node
COMPOUND TRIGGER
   TYPE idNodeArray IS TABLE OF t_ctl_node.id_ctl_node%TYPE INDEX BY BINARY_INTEGER;
   v_node_ids idNodeArray;   
   v_parent_tree_code t_ctl_node.tree_code%TYPE;   
   n_id_ctl_node t_ctl_node.id_ctl_node%TYPE;   
   CURSOR cur_children_ids IS SELECT id_ctl_node, id_parent
                              FROM t_ctl_node                             
                              CONNECT BY PRIOR id_ctl_node = id_parent
                              START WITH id_ctl_node = n_id_ctl_node
                              ORDER BY LEVEL;
BEFORE EACH ROW IS
BEGIN
   IF :new.id_parent != :old.id_parent OR 
     (:old.id_parent IS NULL AND :new.id_parent IS NOT NULL) OR 
     (:new.id_parent IS NULL AND :old.id_parent IS NOT NULL)
   THEN
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
            BEGIN
               SELECT tree_code INTO v_parent_tree_code FROM t_ctl_node WHERE id_ctl_node = r_node.id_parent;
            EXCEPTION WHEN NO_DATA_FOUND THEN
               NULL;   
            END;
                           
            UPDATE t_ctl_node 
            SET tree_code = CONCAT (v_parent_tree_code, '/'||code)
            WHERE id_ctl_node = r_node.id_ctl_node;       
         END LOOP;   
      END LOOP;   
   END IF;
END AFTER STATEMENT;

END t_node_fill_tree_code_parent_update;
/
