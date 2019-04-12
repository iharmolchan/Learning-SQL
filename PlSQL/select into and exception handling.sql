DECLARE
  ware_name t_ware.name%TYPE;
  ware_moniker t_ware.moniker%TYPE;
BEGIN
  SELECT moniker, name
  INTO ware_moniker, ware_name 
  FROM t_ware 
  WHERE t_ware.moniker LIKE 'Lee Rider S%';
  dbms_output.put_line('Name: '||ware_name||'. '||'Moniker: '||ware_moniker);
EXCEPTION
  WHEN TOO_MANY_ROWS THEN dbms_output.put_line('exception! query has returned more than one result');
  WHEN NO_DATA_FOUND THEN dbms_output.put_line('exception! no rows found');
  WHEN OTHERS THEN dbms_output.put_line('something wrong');  
END;
