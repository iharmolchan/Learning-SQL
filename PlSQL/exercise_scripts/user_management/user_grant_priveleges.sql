-- grant some right to all users (public)
GRANT CREATE SESSION TO public;

-- with admin option example
GRANT CREATE SESSION TO molchan WITH ADMIN OPTION;

-- granting object rights (SELECT, ALTER, DELETE, INSERT, UPDATE, EXECUTE, REFERENCES, INDEX)
GRANT DELETE ON shop.vw_rest_ware TO molchan; -- view rights (SELECT, DELETE, INSERT, UPDATE)

GRANT INSERT (dt) ON shop.t_supply TO molchan; -- column rights

GRANT EXECUTE ON shop.pkg_department_tests TO molchan; -- procedure, function, package rights (EXECUTE, DEBUG)

GRANT READ ON DIRECTORY bfile_dir TO molchan; -- directory rights (READ, WRITE)

GRANT DELETE ON shop.t_supply TO molchan WITH GRANT OPTION; -- grant option example

GRANT ALL ON shop.t_model TO molchan; -- grant all priveleges on object
                                      -- equvalent to 'GRANT SELECT,INSERT,UPDATE,DELETE on shop.t_model TO molchan;'

-- revoking object rights
REVOKE SELECT, INSERT ON shop.t_model FROM molchan;

-- procedure with invoker's rights
CREATE OR REPLACE PROCEDURE delete_supply (sale_id NUMBER)
AUTHID CURRENT_USER -- authid to assign rights which will be used when procedure invokes
IS
BEGIN
   DELETE FROM shop.t_sale WHERE id_sale = sale_id;
   COMMIT;
END;                                    


