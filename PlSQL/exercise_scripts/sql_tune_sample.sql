DECLARE
   my_task_name varchar2(30);my_sqltext clob;rep_tuning   clob;
BEGIN
   BEGIN DBMS_SQLTUNE.DROP_TUNING_TASK('my_sql_tuning_task');
   EXCEPTION WHEN OTHERS THEN
      NULL;
   END;
   MY_SQLTEXT := '--текст запроса (без точки с запятой в конце запроса)' ;
   MY_TASK_NAME := DBMS_SQLTUNE.CREATE_TUNING_TASK(
      SQL_TEXT => my_sqltext,
      TIME_LIMIT => 60,               --задается время выполнения в секундах
      TASK_NAME => 'my_sql_tuning_task', 
      DESCRIPTION => my_task_name ,
      SCOPE => DBMS_SQLTUNE.scope_comprehensive);
   BEGIN
      DBMS_SQLTUNE.EXECUTE_TUNING_TASK('my_sql_tuning_task');
   EXCEPTION WHEN OTHERS THEN
      NULL;
   END;
END;
