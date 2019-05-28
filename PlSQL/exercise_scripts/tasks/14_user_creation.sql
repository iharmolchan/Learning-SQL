
-- creating sample clients
CREATE USER nelva IDENTIFIED BY nelva;
GRANT CONNECT TO nelva;
GRANT r_client TO nelva;
/

CREATE USER lamoda IDENTIFIED BY lamoda;
GRANT CONNECT TO lamoda;
GRANT r_client TO lamoda;
/

CREATE USER "xobbi.by" IDENTIFIED BY "xobbi.by";
GRANT CONNECT TO "xobbi.by";
GRANT r_client TO "xobbi.by";
/
-------------------------------------------------------------------
-- creating sample salesmen
CREATE USER grodno_ivanov IDENTIFIED BY ivanov;
GRANT CONNECT TO grodno_ivanov;
GRANT r_salesman TO grodno_ivanov;
/

CREATE USER minsk_petrov IDENTIFIED BY petrov;
GRANT CONNECT TO minsk_petrov;
GRANT r_salesman TO minsk_petrov;
/
-------------------------------------------------------------------
-- creating sample tovaroved
CREATE USER tovaroved_sidorova IDENTIFIED BY tovaroved_sidorova;
GRANT CONNECT TO tovaroved_sidorova;
GRANT r_tovaroved TO tovaroved_sidorova;
/
-------------------------------------------------------------------
-- creating sample operators
CREATE USER gomel_bieber IDENTIFIED BY gomel_bieber;
GRANT CONNECT TO gomel_bieber;
GRANT r_operator TO gomel_bieber;
/

CREATE USER mogilev_shulga IDENTIFIED BY mogilev_shulga;
GRANT CONNECT TO mogilev_shulga;
GRANT r_operator TO mogilev_shulga;
/

CREATE USER brest_ignatova IDENTIFIED BY brest_ignatova;
GRANT CONNECT TO brest_ignatova;
GRANT r_operator TO brest_ignatova;
/

