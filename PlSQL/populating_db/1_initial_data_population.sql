
-- begin data population 

/* supplier data */
---------------------
    INSERT INTO t_supplier (moniker, name) 
    VALUES ('Kogankids', 'Kogankids Group Limited');
    ---------------------
    INSERT INTO t_supplier (moniker, name) 
    VALUES ('Bravo', 'Bravo Inc.');
    ---------------------
    INSERT INTO t_supplier (moniker, name) 
    VALUES ('Lipar', 'Lipar Group');
    ---------------------
    INSERT INTO t_supplier (moniker, name) 
    VALUES ('Misstix', 'Misstix Corporation');
    ---------------------
    INSERT INTO t_supplier (moniker, name) 
    VALUES ('Modalight', 'Modalight Co. Ltd.');
    ---------------------
    INSERT INTO t_supplier (moniker, name) 
    VALUES ('Alibaba', 'Alibaba Group');
    ---------------------
    INSERT INTO t_supplier (moniker, name) 
    VALUES ('Chinabrands', 'Chinabrands.com');
   
/* department data */
---------------------
    INSERT INTO t_dept (name)
    VALUES ('Administration');
    ---------------------
    INSERT INTO t_dept (name)
    VALUES ('IT');
    ---------------------
    INSERT INTO t_dept (name)
    VALUES ('Sales');
    ---------------------
    INSERT INTO t_dept (name)
    VALUES ('Delivery');
    ---------------------
    INSERT INTO t_dept (name, id_parent)
    VALUES ('Grodno region', (SELECT id_dept FROM t_dept WHERE UPPER(name)=UPPER('sales')));
    ---------------------
    INSERT INTO t_dept (name, id_parent)
    VALUES ('Vitebsk region', (SELECT id_dept FROM t_dept WHERE UPPER(name)=UPPER('sales')));
    ---------------------
    INSERT INTO t_dept (name, id_parent)
    VALUES ('Brest region', (SELECT id_dept FROM t_dept WHERE UPPER(name)=UPPER('sales')));
    ---------------------
    INSERT INTO t_dept (name, id_parent)
    VALUES ('Gomel region', (SELECT id_dept FROM t_dept WHERE UPPER(name)=UPPER('sales')));
    ---------------------
    INSERT INTO t_dept (name, id_parent)
    VALUES ('Minsk region', (SELECT id_dept FROM t_dept WHERE UPPER(name)=UPPER('sales')));
    ---------------------
    INSERT INTO t_dept (name, id_parent)
    VALUES ('Mogilev region', (SELECT id_dept FROM t_dept WHERE UPPER(name)=UPPER('sales')));
    ---------------------
    INSERT INTO t_dept (name, id_parent)
    VALUES ('Development', (SELECT id_dept FROM t_dept WHERE UPPER(name)=UPPER('it')));
    ---------------------
    INSERT INTO t_dept (name, id_parent)
    VALUES ('Testing', (SELECT id_dept FROM t_dept WHERE UPPER(name)=UPPER('it')));
    ---------------------
    INSERT INTO t_dept (name, id_parent)
    VALUES ('Manual testing', (SELECT id_dept FROM t_dept WHERE UPPER(name)=UPPER('testing')));
    ---------------------
    INSERT INTO t_dept (name, id_parent)
    VALUES ('Automative', (SELECT id_dept FROM t_dept WHERE UPPER(name)=UPPER('testing')));
    ---------------------
    INSERT INTO t_dept (name, id_parent)
    VALUES ('Frontend', (SELECT id_dept FROM t_dept WHERE UPPER(name)=UPPER('development')));
    ---------------------
    INSERT INTO t_dept (name, id_parent)
    VALUES ('Backend', (SELECT id_dept FROM t_dept WHERE UPPER(name)=UPPER('development')));
    ---------------------
    INSERT INTO t_dept (name, id_parent)
    VALUES ('JavaSript', (SELECT id_dept FROM t_dept WHERE UPPER(name)=UPPER('frontend')));
    ---------------------
    INSERT INTO t_dept (name, id_parent)
    VALUES ('HTML', (SELECT id_dept FROM t_dept WHERE UPPER(name)=UPPER('frontend')));
    ---------------------
    INSERT INTO t_dept (name, id_parent)
    VALUES ('CSS', (SELECT id_dept FROM t_dept WHERE UPPER(name)=UPPER('frontend')));
    ---------------------
    INSERT INTO t_dept (name, id_parent)
    VALUES ('Java', (SELECT id_dept FROM t_dept WHERE UPPER(name)=UPPER('backend')));
    ---------------------
    INSERT INTO t_dept (name, id_parent)
    VALUES ('SQL', (SELECT id_dept FROM t_dept WHERE UPPER(name)=UPPER('backend')));
       
/* client data */
---------------------
    
    --grodno region clients
    
    INSERT INTO t_client (id_dept, moniker, name, is_vip, town)
    VALUES ((SELECT id_dept FROM t_dept WHERE UPPER(name)=UPPER('grodno region')),
    'MySport', 'Сеть магазинов MySport', 1, 'Grodno');
    ---------------------
    INSERT INTO t_client (id_dept, moniker, name, is_vip, town)
    VALUES ((SELECT id_dept FROM t_dept WHERE UPPER(name)=UPPER('grodno region')),
    'Нелва', 'Магазин Нелва', 0, 'Slonim');
    ---------------------
    INSERT INTO t_client (id_dept, moniker, name, is_vip, town)
    VALUES ((SELECT id_dept FROM t_dept WHERE UPPER(name)=UPPER('grodno region')),
    'interm.by', 'Интернет магазин interm.by', 0, 'Dyatlovo');
    ---------------------
    INSERT INTO t_client (id_dept, moniker, name, is_vip, town)
    VALUES ((SELECT id_dept FROM t_dept WHERE UPPER(name)=UPPER('grodno region')),
    'Аделэйс', 'Магазин Аделэйс', 0, 'Grodno');
    ---------------------
    INSERT INTO t_client (id_dept, moniker, name, is_vip, town)
    VALUES ((SELECT id_dept FROM t_dept WHERE UPPER(name)=UPPER('grodno region')),
    'bitrade.by', 'Интернет-магазин Bittrade.by', 1, 'Grodno');
    ---------------------
    
    --vitebsk region clients
    
    INSERT INTO t_client (id_dept, moniker, name, is_vip, town)
    VALUES ((SELECT id_dept FROM t_dept WHERE UPPER(name)=UPPER('vitebsk region')),
    'Amaia', 'Магазин Amaia', 0, 'Vitebsk');
    ---------------------
    INSERT INTO t_client (id_dept, moniker, name, is_vip, town)
    VALUES ((SELECT id_dept FROM t_dept WHERE UPPER(name)=UPPER('vitebsk region')),
    'Reina', 'Магазин Reina', 0, 'Polotsk');
    ---------------------
    
    --brest region clients
    
    INSERT INTO t_client (id_dept, moniker, name, is_vip, town)
    VALUES ((SELECT id_dept FROM t_dept WHERE UPPER(name)=UPPER('brest region')),
    'polisan.by', 'Магазин Polisan.by', 0, 'Pinsk');
    ---------------------
    INSERT INTO t_client (id_dept, moniker, name, is_vip, town)
    VALUES ((SELECT id_dept FROM t_dept WHERE UPPER(name)=UPPER('brest region')),
    'xobbi.by', 'Магазин xobbi.by', 0, 'Brest');
    ---------------------
    INSERT INTO t_client (id_dept, moniker, name, is_vip, town)
    VALUES ((SELECT id_dept FROM t_dept WHERE UPPER(name)=UPPER('brest region')),
    'bixenon.by', 'Магазин bixenon.by', 0, 'Kobrin');
    ---------------------
    INSERT INTO t_client (id_dept, moniker, name, is_vip, town)
    VALUES ((SELECT id_dept FROM t_dept WHERE UPPER(name)=UPPER('brest region')),
    'v-breste.by', 'Магазин v-breste.by', 0, 'Brest');
    ---------------------
    
    --gomel region clients
    
    INSERT INTO t_client (id_dept, moniker, name, is_vip, town)
    VALUES ((SELECT id_dept FROM t_dept WHERE UPPER(name)=UPPER('gomel region')),
    'ShopGomel.by', 'Интернет магазин ShopGomel', 0, 'Gomel');
    ---------------------
    INSERT INTO t_client (id_dept, moniker, name, is_vip, town)
    VALUES ((SELECT id_dept FROM t_dept WHERE UPPER(name)=UPPER('gomel region')),
    'Зеон Плюс', 'ООО "Зеон Плюс"', 0, 'Rogachev');
    ---------------------
    
    --mogilev region clients
    
    INSERT INTO t_client (id_dept, moniker, name, is_vip, town)
    VALUES ((SELECT id_dept FROM t_dept WHERE UPPER(name)=UPPER('mogilev region')),
    'Балекс', 'Магазин одежды Балекс', 0, 'Mogilev');
    ---------------------
    INSERT INTO t_client (id_dept, moniker, name, is_vip, town)
    VALUES ((SELECT id_dept FROM t_dept WHERE UPPER(name)=UPPER('mogilev region')),
    'Мюон Минус', 'ОАО "Мюон Минус"', 0, 'Shklov');
    ---------------------
    
    --minsk region clients
    
    INSERT INTO t_client (id_dept, moniker, name, is_vip, town)
    VALUES ((SELECT id_dept FROM t_dept WHERE UPPER(name)=UPPER('minsk region')),
    'Lamoda', 'Интернет-магазин Lamoda.by', 1, 'Minsk');
    ---------------------
    INSERT INTO t_client (id_dept, moniker, name, is_vip, town)
    VALUES ((SELECT id_dept FROM t_dept WHERE UPPER(name)=UPPER('minsk region')),
    'MarkFormelle', 'Магазин Mark formelle', 1, 'Minsk');

/* node data */
---------------------
    INSERT INTO t_ctl_node (code, name) 
    VALUES ('clothing', 'Clothing');
    ---------------------
    INSERT INTO t_ctl_node (code, name) 
    VALUES ('shoes', 'Shoes');
    ---------------------        
    INSERT INTO t_ctl_node (id_parent, code, name) 
    VALUES ((SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('clothing')),
    'jeans', 'Jeans');
    ---------------------        
    INSERT INTO t_ctl_node (id_parent, code, name) 
    VALUES ((SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('clothing')),
    'coats', 'Coats and outwear');
    ---------------------        
    INSERT INTO t_ctl_node (id_parent, code, name) 
    VALUES ((SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('clothing')),
    'shirts', 'Shirts and tops');
    ---------------------        
    INSERT INTO t_ctl_node (id_parent, code, name) 
    VALUES ((SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('clothing')),
    'shorts', 'Shorts');
    ---------------------        
    INSERT INTO t_ctl_node (id_parent, code, name) 
    VALUES ((SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('clothing')),
    'socks', 'Socks');
    ---------------------        
    INSERT INTO t_ctl_node (id_parent, code, name) 
    VALUES ((SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('shoes')),
    'sneakers', 'Sneakers and athletic');
    ---------------------        
    INSERT INTO t_ctl_node (id_parent, code, name) 
    VALUES ((SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('shoes')),
    'boots', 'Boots');
    ---------------------        
    INSERT INTO t_ctl_node (id_parent, code, name) 
    VALUES ((SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('shoes')),
    'sandals', 'Sandals');
    ---------------------        
    INSERT INTO t_ctl_node (id_parent, code, name) 
    VALUES ((SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('shoes')),
    'slippers', 'Slippers');
    

/* model data */
---------------------
    --coats     
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Iceberg PUG9', 'Iceberg IC461EMEPUG9',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('coats')),
    'upper wear', 'jumper', 'Iceberg');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Iceberg PUG6', 'Iceberg IC461EMEPUG6',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('coats')),
    'upper wear', 'jumper', 'Iceberg');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Iceberg PUG8', 'Iceberg IC461EMEPUG8',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('coats')),
    'upper wear', 'jumper', 'Iceberg');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Ted Baker BUV5', 'Ted Baker TE019EMEBUV5',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('coats')),
    'upper wear', 'jumper', 'Ted Baker London');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Trussardi CN1', 'Trussardi TR002EMDOCN1',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('coats')),
    'upper wear', 'jumper', 'Trussardi');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Trussardi VZ1', 'Trussardi TR002EMBUVZ1',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('coats')),
    'upper wear', 'jumper', 'Trussardi');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Windsor VIA5', 'Windsor WI013EMDVIA5',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('coats')),
    'upper wear', 'jumper', 'Windsor');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Ted Baker MR6', 'Ted Baker TE019EMCUMR6',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('coats')),
    'upper wear', 'jumper', 'Ted Baker London');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Ted Baker MS3', 'Ted Baker TE019EMCUMS3',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('coats')),
    'upper wear', 'jumper', 'Ted Baker London');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Windsor EE7', 'Windsor WI013EMCPEE7',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('coats')),
    'upper wear', 'turtleneck', 'Windsor');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Ted Baker MQ5', 'Ted Baker TE019EMCUMQ5',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('coats')),
    'upper wear', 'jumper', 'Ted Baker London');
    
    --jeans
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Armani PYB4', 'Emporio Armani EM598EMDPYB4',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('jeans')),
    'bottom wear', 'jeans', 'Emporio Armani');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Armani PYB8', 'Emporio Armani EM598EMDPYB8',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('jeans')),
    'bottom wear', 'jeans', 'Emporio Armani');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Trussardi J DIA1', 'Trussardi Jeans TR016EMEDIA1',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('jeans')),
    'bottom wear', 'jeans', 'Trussardi');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Armani PYC2', 'Emporio Armani EM598EMDPYC2',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('jeans')),
    'bottom wear', 'jeans', 'Emporio Armani');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Iceberg PUJ2', 'Iceberg IC461EMEPUJ2',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('jeans')),
    'bottom wear', 'jeans', 'Iceberg');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Armani PYB7', 'Emporio Armani EM598EMDPYB7',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('jeans')),
    'bottom wear', 'jeans', 'Emporio Armani');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Windsor VIA7', 'Windsor WI013EMDVIA7',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('jeans')),
    'bottom wear', 'jeans', 'Windsor');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Armani PYC4', 'Emporio Armani EM598EMDPYC4',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('jeans')),
    'bottom wear', 'jeans', 'Emporio Armani');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Iceberg PUI9', 'Iceberg IC461EMEPUI9',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('jeans')),
    'bottom wear', 'jeans', 'Iceberg');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Armani PYC3', 'Emporio Armani EM598EMDPYC3',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('jeans')),
    'bottom wear', 'jeans', 'Emporio Armani');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Iceberg QOP1', 'Iceberg IC461EMBQOP1',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('jeans')),
    'bottom wear', 'jeans', 'Iceberg');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Iceberg PUJ1', 'Iceberg IC461EMEPUJ1',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('jeans')),
    'bottom wear', 'jeans', 'Iceberg');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Iceberg PUJ0', 'Iceberg IC461EMEPUJ0',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('jeans')),
    'bottom wear', 'jeans', 'Iceberg');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Trussardi J BZ5', 'Trussardi Jeans TR016EMDOBZ5',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('jeans')),
    'bottom wear', 'jeans', 'Trussardi');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Iceberg WW61', 'Iceberg IC461EMZWW61',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('jeans')),
    'bottom wear', 'jeans', 'Iceberg');
    
    --shirts
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Trussardi J IU2', 'Trussardi Jeans TR016EMDOIU2',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('shirts')),
    'upper wear', 'shirts', 'Trussardi');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Iceberg PUG2', 'Iceberg IC461EMEPUG2',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('shirts')),
    'upper wear', 'shirts', 'Iceberg');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Armani PYB1', 'Emporio Armani EM598EMDPYB1',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('shirts')),
    'upper wear', 'shirts', 'Emporio Armani');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Windsor VIA8', 'Windsor WI013EMDVIA8',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('shirts')),
    'upper wear', 'shirts', 'Windsor');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Windsor VIA9', 'Windsor WI013EMDVIA9',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('shirts')),
    'upper wear', 'shirts', 'Windsor');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Armani PYA5', 'Emporio Armani EM598EMDPYA5',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('shirts')),
    'upper wear', 'shirts', 'Emporio Armani');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Armani PYA8', 'Emporio Armani EM598EMDPYA8',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('shirts')),
    'upper wear', 'shirts', 'Emporio Armani');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Ted Baker BUU6', 'Ted Baker TE019EMEBUU6',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('shirts')),
    'upper wear', 'shirts', 'Ted Baker London');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Ted Baker BUV2', 'Ted Baker TE019EMEBUV2',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('shirts')),
    'upper wear', 'shirts', 'Ted Baker London');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Trussardi J IU1', 'Trussardi Jeans TR016EMDOIU1',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('shirts')),
    'upper wear', 'shirts', 'Trussardi');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Trussardi CM9', 'Trussardi TR002EMDOCM9',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('shirts')),
    'upper wear', 'shirts', 'Trussardi');
    
    --shorts
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Diesel JSF1', 'Diesel DI303EMDJSF1',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('shorts')),
    'bottom wear', 'shorts', 'Diesel');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Diesel JPZ5', 'Diesel DI303EMDJPZ5',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('shorts')),
    'bottom wear', 'shorts', 'Diesel');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Diesel JSE9', 'Diesel DI303EMDJSE9',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('shorts')),
    'bottom wear', 'shorts', 'Diesel');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Diesel JPZ6', 'Diesel DI303EMDJPZ6',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('shorts')),
    'bottom wear', 'shorts', 'Diesel');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Diesel JSF0', 'Diesel DI303EMDJSF0',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('shorts')),
    'bottom wear', 'shorts', 'Diesel');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Iceberg PUL7', 'Iceberg IC461EMEPUL7',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('shorts')),
    'bottom wear', 'shorts', 'Iceberg');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Iceberg PUJ3', 'Iceberg IC461EMEPUJ3',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('shorts')),
    'bottom wear', 'shorts', 'Iceberg');  
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Iceberg PUL8', 'Iceberg IC461EMEPUL8',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('shorts')),
    'bottom wear', 'shorts', 'Iceberg'); 
    
    --socks
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Falke Firenze Q5', 'Falke Firenze FA606FMFFLQ5',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('socks')),
    'bottom wear', 'socks', 'Falke');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Falke Swing Q0', 'Falke Swing FA606FMFFLQ0',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('socks')),
    'bottom wear', 'socks', 'Falke');   
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Polo RL VH4', 'Polo Ralph Loren PO006FMEOVH4',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('socks')),
    'bottom wear', 'socks', 'Polo Ralph Loren');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Polo RL VH1', 'Polo Ralph Loren PO006FMEOVH1',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('socks')),
    'bottom wear', 'socks', 'Polo Ralph Loren');  
    
    --sandals
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Polo RL FNL2', 'Polo Ralph Loren PO006AMEFNL2',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('sandals')),
    'shoes', 'sandals', 'Polo Ralph Loren');  
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Armani WB87', 'Emporio Armani EM598AMZWB87',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('sandals')),
    'shoes', 'sandals', 'Emporio Armani');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Trussardi J BU8', 'Trussardi Jeans TR016AMDOBU8',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('sandals')),
    'shoes', 'sandals', 'Trussardi');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Trussardi J BU9', 'Trussardi Jeans TR016AMDOBU9',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('sandals')),
    'shoes', 'sandals', 'Trussardi');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Karl Lag HVS9', 'Karl Lagerfeld KA025AMEHVS9',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('sandals')),
    'shoes', 'sandals', 'Karl Lagerfeld'); 
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Polo RL FNL1', 'Polo Ralph Loren PO006AMEFNL1',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('sandals')),
    'shoes', 'sandals', 'Polo Ralph Loren');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Polo RL FNK1', 'Polo Ralph Loren PO006AMEFNK1',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('sandals')),
    'shoes', 'sandals', 'Polo Ralph Loren');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Karl Lag HVS8', 'Karl Lagerfeld KA025AMEHVS8',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('sandals')),
    'shoes', 'sandals', 'Karl Lagerfeld');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Baldini BOU2', 'Baldini BA097AMEBOU2',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('sandals')),
    'shoes', 'sandals', 'Baldini');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Baldini BOU5', 'Baldini BA097AMEBOU5',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('sandals')),
    'shoes', 'sandals', 'Baldini');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Baldini BOU4', 'Baldini BA097AMEBOU4',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('sandals')),
    'shoes', 'sandals', 'Baldini');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Baldini BOU3', 'Baldini BA097AMEBOU3',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('sandals')),
    'shoes', 'sandals', 'Baldini');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Blauer JAD4', 'Blauer BL654AMEJAD2',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('sandals')),
    'shoes', 'sandals', 'Blauer'); 
    
    --slippers
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Diesel 57', 'Diesel 7615457',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('slippers')),
    'shoes', 'slippers', 'Diesel');
    --------------------- 
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Ash 27', 'Ash 7113427',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('slippers')),
    'shoes', 'slippers', 'Ash');
    --------------------- 
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Ash 19', 'Ash 7686919',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('slippers')),
    'shoes', 'slippers', 'Ash');
    --------------------- 
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Lacoste 12', 'Lacoste 7861812',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('slippers')),
    'shoes', 'slippers', 'Lacoste');
    
    --sneakers
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Asics GT-1000', 'Asics GT-1000 7 G-TX',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('sneakers')),
    'shoes', 'sneakers', 'Asics');
    --------------------- 
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Asics GC-5', 'Asics GEL-CONTEND 5',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('sneakers')),
    'shoes', 'sneakers', 'Asics');
    --------------------- 
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Asics GR-8', 'Asics GEL-ROCKET 8',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('sneakers')),
    'shoes', 'sneakers', 'Asics');
    --------------------- 
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Adidas VR 2.0', 'Adidas V RACER 2.0',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('sneakers')),
    'shoes', 'sneakers', 'Adidas');
    --------------------- 
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Asics P10', 'Asics PATRIOT 10',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('sneakers')),
    'shoes', 'sneakers', 'Asics');
    --------------------- 
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Adidas SB', 'Adidas SOLAR BLAZE',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('sneakers')),
    'shoes', 'sneakers', 'Adidas');
    --------------------- 
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Nike MDR2', 'Nike MD RUNNER 2',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('sneakers')),
    'shoes', 'sneakers', 'Nike');
    --------------------- 
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Adidas TTBG', 'Adidas TERREX TWO BOA GTX',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('sneakers')),
    'shoes', 'sneakers', 'Adidas');
    --------------------- 
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Adidas D9', 'Adidas DURAMO 9',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('sneakers')),
    'shoes', 'sneakers', 'Adidas');
    --------------------- 
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Nike AM THEA', 'Nike WMNS AIR MAX THEA',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('sneakers')),
    'shoes', 'sneakers', 'Nike');
    
    --boots
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Ralf Ringer PAT', 'Ralf Ringer Real PAT',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('boots')),
    'shoes', 'boots', 'Ralf Ringer');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Ralf Ringer 699', 'Ralf Ringer 427699',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('boots')),
    'shoes', 'boots', 'Ralf Ringer');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Ralf Ringer 780', 'Ralf Ringer 2764780',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('boots')),
    'shoes', 'boots', 'Ralf Ringer'); 
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Lassie 591', 'Lassie 4990591',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('boots')),
    'shoes', 'boots', 'Lassie');                   
    
COMMIT;
    
    
    
    
    
    
    
