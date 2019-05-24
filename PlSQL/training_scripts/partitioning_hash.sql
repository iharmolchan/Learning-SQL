CREATE TABLE t_sale (
   id_sale NUMBER(10,0)GENERATED BY DEFAULT ON NULL AS IDENTITY START WITH 100000,
   num VARCHAR2(30),
   dt DATE NOT NULL,
   id_client NUMBER(10,0) NOT NULL,
   e_state VARCHAR2(10) NOT NULL,
   discount NUMBER(8,6) DEFAULT 0,
   summa NUMBER(14,2),
   nds NUMBER(14,2),
   PRIMARY KEY (id_sale)
)
PARTITION BY HASH (id_sale)
   PARTITIONS 4;
   --STORE IN (ts1, ts2, ts3, ts4)  --example tablespaces