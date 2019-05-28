-- creating new role
CREATE ROLE new_dba;

-- granting some rights to new role
GRANT CONNECT TO new_dba;
GRANT SELECT ANY TABLE TO new_dba;
GRANT UPDATE ANY TABLE TO new_dba;
GRANT select_catalog_role TO new_dba;
GRANT exp_full_database TO new_dba;
GRANT imp_full_database TO new_dba;

-- assigning new role to user
GRANT new_dba TO molchan; -- GRANT new_dba TO molchan WITH ADMIN OPTION;  -- with admin option example

-- deleting role
DROP ROLE new_dba;
