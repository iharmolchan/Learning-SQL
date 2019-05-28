-- creating user
CREATE USER molchan IDENTIFIED BY 1992;
/

-- granting connection to user
GRANT CREATE SESSION TO molchan;
/

-- granting all system rights to user
GRANT ALL PRIVILEGES TO molchan;

-- revoking connection from user
REVOKE CREATE SESSION FROM molchan;
/

-- quota on users tablespace
ALTER USER molchan QUOTA 100M ON users;
--  GRANT UNLIMITED TABLESPACE TO molchan;
/

-- locking user account
ALTER USER molchan ACCOUNT LOCK;
/

-- dropping user
DROP USER molchan; -- CASCADE to drop all the objects of user
/
