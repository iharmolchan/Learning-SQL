
-- creating table with range partitioning
CREATE TABLE t_supply (
   id_supply NUMBER(10,0) GENERATED BY DEFAULT ON NULL AS IDENTITY START WITH 100000,
   code VARCHAR2(30 CHAR),
   num VARCHAR2(30 CHAR),
   dt DATE NOT NULL,
   id_supplier NUMBER(10,0) NOT NULL,
   e_state VARCHAR2(10) NOT NULL,
   summa NUMBER(14,2),
   nds NUMBER(14,2),
   PRIMARY KEY (id_supply)
)
PARTITION BY RANGE (dt)(
   PARTITION supplies_part1 VALUES LESS THAN (DATE '2019-01-01') ,
   PARTITION supplies_part2 VALUES LESS THAN (DATE '2019-02-01') ,
   PARTITION supplies_part3 VALUES LESS THAN (DATE '2019-03-01') ,
   PARTITION supplies_part4 VALUES LESS THAN (DATE '2019-04-01')
   --PARTITION supplies_part5 VALUES LESS THAN (MAXVALUE)          
);
/

-- adding new partition
ALTER TABLE 
   t_supply
ADD PARTITION 
   supplies_part5 VALUES LESS THAN (DATE '2019-05-01'); 
/

-- spitting existing partition
ALTER TABLE 
   t_supply
SPLIT PARTITION 
   supplies_part3 AT (DATE '2019-02-14') 
INTO
   (PARTITION supplies_part3A, PARTITION supplies_part3B);
/

-- merging existing partitions
ALTER TABLE 
   t_supply
MERGE PARTITIONS 
   supplies_part1, supplies_part2 
INTO PARTITION
   supplies_part0;
/

-- renaming partitions
ALTER TABLE t_supply RENAME PARTITION supplies_part4 TO supplies_march_2019;
/

-- exchanging partition
--creating source table that  matches the definition of the t_supply table
CREATE TABLE t_source_table (
   id_source NUMBER(10,0) GENERATED BY DEFAULT ON NULL AS IDENTITY START WITH 100000,
   code VARCHAR2(30 CHAR),
   num VARCHAR2(30 CHAR),
   dt DATE NOT NULL,
   id_supplier NUMBER(10,0) NOT NULL,
   e_state VARCHAR2(10) NOT NULL,
   summa NUMBER(14,2),
   nds NUMBER(14,2),
   PRIMARY KEY (id_source)
);
/
-- exchanging partition in t_supply with our source table 
ALTER TABLE 
   t_supply 
EXCHANGE PARTITION 
   supplies_part2 
WITH TABLE 
   t_source_table 
WITHOUT VALIDATION;
/

-- deleting partitions
ALTER TABLE 
   t_supply
DROP PARTITION 
   supplies_part2;
/

-- coalescing partitions (for hash and list partitioning only)
ALTER TABLE 
   t_supply
COALESCE PARTITION;


