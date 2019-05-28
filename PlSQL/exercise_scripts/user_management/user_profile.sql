-- create profile miser
CREATE PROFILE miser
LIMIT
   CONNECT_TIME 120
   FAILED_LOGIN_ATTEMPTS 3
   IDLE_TIME 1
   SESSIONS_PER_USER 2;
/   
   
-- assign profile to user
ALTER USER molchan PROFILE miser;
/

-- change profile
ALTER PROFILE miser
LIMIT
   SESSIONS_PER_USER 4
   FAILED_LOGIN_ATTEMPTS 4;
/

-- password verifying function
ALTER PROFILE miser 
LIMIT
   PASSWORD_LIFE_TIME 180
   PASSWORD_GRACE_TIME 7
   PASSWORD_REUSE_TIME UNLIMITED
   PASSWORD_REUSE_MAX UNLIMITED
   FAILED_LOGIN_ATTEMPTS 10
   PASSWORD_LOCK_TIME 1
   PASSWORD_VERIFY_FUNCTION ora12c_verify_function;

-- enable resource limits from profiles   
ALTER SYSTEM SET resource_limit = TRUE;  

-- drop profile. CASCADE to delete prifile from users (will be assighned default profile)
DROP PROFILE miser CASCADE;
