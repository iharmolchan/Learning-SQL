CREATE OR REPLACE PACKAGE pkg_node_tests
AS  
   PROCEDURE tree_code_on_insert;
   PROCEDURE tree_code_on_update; 
END pkg_node_tests;
/

CREATE OR REPLACE PACKAGE BODY pkg_node_tests
AS
   -- tree_code_on_insert
   PROCEDURE tree_code_on_insert
   IS
      n_id_added_ctl_node t_ctl_node.id_ctl_node%TYPE;
      n_id_parent t_ctl_node.id_ctl_node%TYPE;
      v_insert_code t_ctl_node.code%TYPE := 'testcode';
      v_insert_name t_ctl_node.name%TYPE := 'testname';
      v_supposed_tree_code t_ctl_node.tree_code%TYPE;
      v_real_tree_code t_ctl_node.tree_code%TYPE;
      
   BEGIN
      DBMS_OUTPUT.PUT_LINE('_____________________________________');
      DBMS_OUTPUT.PUT_LINE('starting test on ctl_node tree_code autocomplete');
      
      SELECT id_ctl_node INTO n_id_parent FROM t_ctl_node
      ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
      
      INSERT INTO t_ctl_node (id_parent, code, name) 
      VALUES (n_id_parent, v_insert_code, v_insert_name)
      RETURNING id_ctl_node INTO n_id_added_ctl_node;
      
      SELECT SYS_CONNECT_BY_PATH(code, '/') INTO v_supposed_tree_code 
      FROM t_ctl_node 
      WHERE id_ctl_node = n_id_added_ctl_node
      CONNECT BY PRIOR id_ctl_node = id_parent
      START WITH id_parent IS NULL;
      
      SELECT tree_code INTO v_real_tree_code FROM t_ctl_node WHERE id_ctl_node = n_id_added_ctl_node; 
      
       DBMS_OUTPUT.PUT_LINE('estimated tree_code : '||v_supposed_tree_code||'. real tree_code : '||v_real_tree_code||'.');  
     
      IF v_supposed_tree_code = v_real_tree_code THEN
         DBMS_OUTPUT.PUT_LINE('TEST PASSED');
      ELSE
         DBMS_OUTPUT.PUT_LINE('TEST IS NOT PASSED!!!');   
      END IF;
      
      ROLLBACK;
      DBMS_OUTPUT.PUT_LINE('_____________________________________');       
   END tree_code_on_insert;
   
   -- tree_code_on_update
   PROCEDURE tree_code_on_update
   IS
      n_test_id_ctl_node t_ctl_node.id_ctl_node%TYPE;
      n_id_parent t_ctl_node.id_ctl_node%TYPE;
      v_test_code t_ctl_node.code%TYPE := 'testcode';
      v_old_tree_code t_ctl_node.tree_code%TYPE;
      v_supposed_tree_code t_ctl_node.tree_code%TYPE;
      v_real_tree_code t_ctl_node.tree_code%TYPE;
       
   BEGIN
      DBMS_OUTPUT.PUT_LINE('_____________________________________');
      DBMS_OUTPUT.PUT_LINE('starting test on ctl_node tree_code autocomplete');
      
      SELECT id_ctl_node INTO n_test_id_ctl_node FROM t_ctl_node
      ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
      
      SELECT tree_code INTO v_old_tree_code FROM t_ctl_node
      WHERE id_ctl_node =  n_test_id_ctl_node;
      
      DBMS_OUTPUT.PUT_LINE('old tree code: '||v_old_tree_code);
      
      SELECT id_ctl_node INTO n_id_parent FROM t_ctl_node
      WHERE id_ctl_node NOT IN (
                           SELECT id_ctl_node FROM t_ctl_node
                           CONNECT BY PRIOR id_ctl_node = id_parent
                           START WITH id_ctl_node = n_test_id_ctl_node)
      ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROW ONLY;
       
      UPDATE t_ctl_node
      SET id_parent = n_id_parent, code = v_test_code
      WHERE id_ctl_node = n_test_id_ctl_node;
      
      
      SELECT SYS_CONNECT_BY_PATH(code, '/') INTO v_supposed_tree_code 
      FROM t_ctl_node 
      WHERE id_ctl_node = n_test_id_ctl_node
      CONNECT BY PRIOR id_ctl_node = id_parent
      START WITH id_parent IS NULL;
      
      SELECT tree_code INTO v_real_tree_code FROM t_ctl_node WHERE id_ctl_node = n_test_id_ctl_node; 
      
      DBMS_OUTPUT.PUT_LINE('estimated tree_code : '||v_supposed_tree_code||'. real tree_code : '||v_real_tree_code||'.');  
     
      IF v_supposed_tree_code = v_real_tree_code THEN
         DBMS_OUTPUT.PUT_LINE('TEST PASSED');
      ELSE
         DBMS_OUTPUT.PUT_LINE('TEST IS NOT PASSED!!!');   
      END IF;
      
      ROLLBACK;
      DBMS_OUTPUT.PUT_LINE('_____________________________________');     
   END tree_code_on_update;
     
END pkg_node_tests;
/
