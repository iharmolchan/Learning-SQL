-- parent table
CREATE TABLE t_sale(
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
PARTITION BY RANGE (dt) INTERVAL(NUMTOYMINTERVAL(1, 'MONTH'))( 
   PARTITION p0 VALUES LESS THAN (DATE '2019-01-01'),
   PARTITION p1 VALUES LESS THAN (DATE '2019-02-01'),
   PARTITION p2 VALUES LESS THAN (DATE '2019-03-01'),
   PARTITION p3 VALUES LESS THAN (DATE '2019-04-01') 
);

--child table
CREATE TABLE t_sale_str(
   id_sale_str NUMBER(10,0)GENERATED BY DEFAULT ON NULL AS IDENTITY START WITH 100000,
   id_sale NUMBER(10,0) NOT NULL,
   num NUMBER(6,0),
   id_ware NUMBER(10,0) NOT NULL,
   qty NUMBER(6,0) NOT NULL,
   price NUMBER(8,2),
   discount NUMBER(8,6) DEFAULT 0,
   disc_price NUMBER(8,2),
   summa NUMBER(14,2),
   nds NUMBER(14,2),
   PRIMARY KEY (id_sale_str),
   CONSTRAINT sale_str_sale_fk FOREIGN KEY (id_sale) REFERENCES t_sale ON DELETE CASCADE;
)
PARTITION BY REFERENCE(sale_str_sale_fk); 
