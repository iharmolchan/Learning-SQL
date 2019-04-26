
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
    'Зеон Плюс', 'ООО "Зеон Плюс"', 0, 'Rogachev');
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
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Lee Rider', 'Lee rider dark jeans',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('jeans')),
    'bottom wear', 'jeans', 'Lee');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Mango', 'Mango Man JUDE4',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('jeans')),
    'bottom wear', 'jeans', 'Mango Man');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Armani', 'Emporio Armani jeans size S',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('jeans')),
    'bottom wear', 'jeans', 'Armani');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Benetton', 'United Colors of Benetton',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('coats')),
    'upper wear', 'coats', 'Benetton');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Dali', 'Dali Jumper',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('coats')),
    'upper wear', 'coats', 'Dali');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Sela', 'Sela Jumper',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('coats')),
    'upper wear', 'coats', 'Sela');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Topman', 'Topman t-shirt',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('shirts')),
    'upper wear', 't-shirts', 'Topman');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Brave Soul', 'Brave Soul polo',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('shirts')),
    'upper wear', 't-shirts', 'Brave Soul');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Oodji', 'Ooodji t-shirt',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('shirts')),
    'upper wear', 't-shirts', 'Oodji');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Nike Pro', 'Men''s Nike Pro Shorts',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('shorts')),
    'bottom wear', 'shorts', 'Nike');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Umbro Basic', 'Umbro Basic Shorts',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('shorts')),
    'bottom wear', 'shorts', 'Umbro');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('MangoCoctail', 'Mango Man Coctail shorts',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('shorts')),
    'bottom wear', 'shorts', 'Mango Man');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Puma White', 'Puma Lifestyle quarters 3P',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('socks')),
    'bottom wear', 'socks', 'Puma');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Reebok act', 'Reebok act fon mid crew cocks',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('socks')),
    'bottom wear', 'socks', 'Reebok');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Nike U NK', 'Nike U NK everyday LTWT NS',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('socks')),
    'bottom wear', 'socks', 'Nike');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('New Balance', 'New Balance 574 evergreen',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('sneakers')),
    'shoes', 'sneakers', 'New Balance');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Levi''s', 'Levi''s shoes',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('sneakers')),
    'shoes', 'sneakers', 'Levi''s');
    ---------------------
    INSERT INTO t_model (moniker, name, id_node, grp, subgrp, label) 
    VALUES ('Reebok', 'Reebok classics',
    (SELECT id_ctl_node FROM t_ctl_node WHERE UPPER(code)=UPPER('sneakers')),
    'shoes', 'sneakers', 'Reebok');

/* model price data */
---------------------
    INSERT INTO t_price_model (id_model, dt_beg, dt_end, price) 
    VALUES ((SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('lee rider')),
    TO_DATE('2019/02/09', 'yyyy/mm/dd'), TO_DATE('2019/06/02', 'yyyy/mm/dd'), 56.32);
    ---------------------
    INSERT INTO t_price_model (id_model, dt_beg, dt_end, price) 
    VALUES ((SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('armani')),
    TO_DATE('2019/01/07', 'yyyy/mm/dd'), TO_DATE('2019/05/21', 'yyyy/mm/dd'), 21.15);
    ---------------------
    INSERT INTO t_price_model (id_model, dt_beg, dt_end, price) 
    VALUES ((SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('mango')),
    TO_DATE('2019/02/05', 'yyyy/mm/dd'), TO_DATE('2019/05/07', 'yyyy/mm/dd'), 12.56);
    ---------------------
    INSERT INTO t_price_model (id_model, dt_beg, dt_end, price) 
    VALUES ((SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('benetton')),
    TO_DATE('2019/01/04', 'yyyy/mm/dd'), TO_DATE('2019/05/12', 'yyyy/mm/dd'), 66.22);
    ---------------------
    INSERT INTO t_price_model (id_model, dt_beg, dt_end, price) 
    VALUES ((SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('dali')),
    TO_DATE('2019/02/28', 'yyyy/mm/dd'), TO_DATE('2019/04/28', 'yyyy/mm/dd'), 46.12);
    ---------------------
    INSERT INTO t_price_model (id_model, dt_beg, dt_end, price) 
    VALUES ((SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('sela')),
    TO_DATE('2019/01/07', 'yyyy/mm/dd'), TO_DATE('2019/04/29', 'yyyy/mm/dd'), 156.26);
    ---------------------
    INSERT INTO t_price_model (id_model, dt_beg, dt_end, price) 
    VALUES ((SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('topman')),
    TO_DATE('2019/02/21', 'yyyy/mm/dd'), TO_DATE('2019/06/15', 'yyyy/mm/dd'), 87.12);
    ---------------------
    INSERT INTO t_price_model (id_model, dt_beg, dt_end, price) 
    VALUES ((SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('brave soul')),
    TO_DATE('2019/02/16', 'yyyy/mm/dd'), TO_DATE('2019/06/1', 'yyyy/mm/dd'), 35.32);
    ---------------------
    INSERT INTO t_price_model (id_model, dt_beg, dt_end, price) 
    VALUES ((SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('oodji')),
    TO_DATE('2019/02/26', 'yyyy/mm/dd'), TO_DATE('2019/05/13', 'yyyy/mm/dd'), 21.26);
    ---------------------
    INSERT INTO t_price_model (id_model, dt_beg, dt_end, price) 
    VALUES ((SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('nike pro')),
    TO_DATE('2019/01/30', 'yyyy/mm/dd'), TO_DATE('2019/04/21', 'yyyy/mm/dd'), 65.17);
    ---------------------
    INSERT INTO t_price_model (id_model, dt_beg, dt_end, price) 
    VALUES ((SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('umbro basic')),
    TO_DATE('2019/04/02', 'yyyy/mm/dd'), TO_DATE('2019/06/17', 'yyyy/mm/dd'), 78.25);
    ---------------------
    INSERT INTO t_price_model (id_model, dt_beg, dt_end, price) 
    VALUES ((SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('mangococtail')),
    TO_DATE('2019/04/01', 'yyyy/mm/dd'), TO_DATE('2019/05/11', 'yyyy/mm/dd'), 46.54);
    ---------------------
    INSERT INTO t_price_model (id_model, dt_beg, dt_end, price) 
    VALUES ((SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('puma white')),
    TO_DATE('2019/04/6', 'yyyy/mm/dd'), TO_DATE('2019/4/30', 'yyyy/mm/dd'), 10.42);
    ---------------------
    INSERT INTO t_price_model (id_model, dt_beg, dt_end, price) 
    VALUES ((SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('reebok act')),
    TO_DATE('2019/02/10', 'yyyy/mm/dd'), TO_DATE('2019/06/05', 'yyyy/mm/dd'), 15.68);
    ---------------------
    INSERT INTO t_price_model (id_model, dt_beg, dt_end, price) 
    VALUES ((SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('nike u nk')),
    TO_DATE('2019/02/14', 'yyyy/mm/dd'), TO_DATE('2019/05/14', 'yyyy/mm/dd'), 52.89);
    ---------------------
    INSERT INTO t_price_model (id_model, dt_beg, dt_end, price) 
    VALUES ((SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('new balance')),
    TO_DATE('2019/02/17', 'yyyy/mm/dd'), TO_DATE('2019/06/22', 'yyyy/mm/dd'), 21.67);
    ---------------------
    INSERT INTO t_price_model (id_model, dt_beg, dt_end, price) 
    VALUES ((SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('levi''s')),
    TO_DATE('2019/01/15', 'yyyy/mm/dd'), TO_DATE('2019/04/27', 'yyyy/mm/dd'), 27.25);
    ---------------------
    INSERT INTO t_price_model (id_model, dt_beg, dt_end, price) 
    VALUES ((SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('reebok')),
    TO_DATE('2019/02/24', 'yyyy/mm/dd'), TO_DATE('2019/06/17', 'yyyy/mm/dd'), 13.44);

/* ware data */
---------------------
    INSERT INTO t_ware (moniker, name, id_model, sz_orig, sz_rus) 
    VALUES ('Lee Rider M', 'Lee rider dark jeans size M',
    (SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('lee rider')),
    'M', '32');
    ---------------------
    INSERT INTO t_ware (moniker, name, id_model, sz_orig, sz_rus) 
    VALUES ('Lee Rider S', 'Lee rider dark jeans size S',
    (SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('lee rider')),
    'S', '28');
    ---------------------
    INSERT INTO t_ware (moniker, name, id_model, sz_orig, sz_rus) 
    VALUES ('Lee Rider L', 'Lee rider dark jeans size L',
    (SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('lee rider')),
    'L', '36');
    ---------------------
    INSERT INTO t_ware (moniker, name, id_model, sz_orig, sz_rus) 
    VALUES ('Armani S', 'Emporio Armani jeans size S',
    (SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('armani')),
    'S', '28');
    ---------------------
    INSERT INTO t_ware (moniker, name, id_model, sz_orig, sz_rus) 
    VALUES ('Armani M', 'Emporio Armani jeans size M',
    (SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('armani')),
    'M', '34');
    ---------------------
    INSERT INTO t_ware (moniker, name, id_model, sz_orig, sz_rus) 
    VALUES ('Armani L', 'Emporio Armani jeans size L',
    (SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('armani')),
    'L', '42');
    ---------------------
    INSERT INTO t_ware (moniker, name, id_model, sz_orig, sz_rus) 
    VALUES ('Mango S', 'Mango Man JUDE4 size S',
    (SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('mango')),
    'S', '22');
    ---------------------
    INSERT INTO t_ware (moniker, name, id_model, sz_orig, sz_rus) 
    VALUES ('Mango M', 'Mango Man JUDE4 size M',
    (SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('mango')),
    'M', '26');
    ---------------------
    INSERT INTO t_ware (moniker, name, id_model, sz_orig, sz_rus) 
    VALUES ('Mango L', 'Mango Man JUDE4 size L',
    (SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('mango')),
    'L', '31');
    ---------------------
    INSERT INTO t_ware (moniker, name, id_model, sz_orig, sz_rus) 
    VALUES ('Benetton S', 'United Colors of Benetton S',
    (SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('benetton')),
    'S', '10');
    ---------------------
    INSERT INTO t_ware (moniker, name, id_model, sz_orig, sz_rus) 
    VALUES ('Benetton M', 'United Colors of Benetton M',
    (SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('benetton')),
    'M', '14');
    ---------------------
    INSERT INTO t_ware (moniker, name, id_model, sz_orig, sz_rus) 
    VALUES ('Benetton L', 'United Colors of Benetton L',
    (SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('benetton')),
    'L', '19');
    ---------------------
    INSERT INTO t_ware (moniker, name, id_model, sz_orig, sz_rus) 
    VALUES ('Dali S', 'Dali Jumper size S',
    (SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('dali')),
    'S', '19');
    ---------------------
    INSERT INTO t_ware (moniker, name, id_model, sz_orig, sz_rus) 
    VALUES ('Dali M', 'Dali Jumper size M',
    (SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('dali')),
    'M', '23');
    ---------------------
    INSERT INTO t_ware (moniker, name, id_model, sz_orig, sz_rus) 
    VALUES ('Dali L', 'Dali Jumper size L',
    (SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('dali')),
    'L', '29');
    ---------------------
    INSERT INTO t_ware (moniker, name, id_model, sz_orig, sz_rus) 
    VALUES ('Sela S', 'Sela Jumper size S',
    (SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('sela')),
    'S', '18');
    ---------------------
    INSERT INTO t_ware (moniker, name, id_model, sz_orig, sz_rus) 
    VALUES ('Sela M', 'Sela Jumper size M',
    (SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('sela')),
    'M', '24');
    ---------------------
    INSERT INTO t_ware (moniker, name, id_model, sz_orig, sz_rus) 
    VALUES ('Sela L', 'Sela Jumper size L',
    (SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('sela')),
    'L', '30');
    ---------------------
    INSERT INTO t_ware (moniker, name, id_model, sz_orig, sz_rus) 
    VALUES ('Topman S', 'Topman t-shirt size S',
    (SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('topman')),
    'S', '26');
    ---------------------
    INSERT INTO t_ware (moniker, name, id_model, sz_orig, sz_rus) 
    VALUES ('Topman M', 'Topman t-shirt size M',
    (SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('topman')),
    'M', '32');
    ---------------------
    INSERT INTO t_ware (moniker, name, id_model, sz_orig, sz_rus) 
    VALUES ('Topman L', 'Topman t-shirt size L',
    (SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('topman')),
    'L', '34');
    ---------------------
    INSERT INTO t_ware (moniker, name, id_model, sz_orig, sz_rus) 
    VALUES ('Brave Soul S', 'Brave Soul polo size S',
    (SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('brave soul')),
    'S', '26');
    ---------------------
    INSERT INTO t_ware (moniker, name, id_model, sz_orig, sz_rus) 
    VALUES ('Brave Soul M', 'Brave Soul polo size M',
    (SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('brave soul')),
    'M', '30');
    ---------------------
    INSERT INTO t_ware (moniker, name, id_model, sz_orig, sz_rus) 
    VALUES ('Brave Soul L', 'Brave Soul polo size L',
    (SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('brave soul')),
    'L', '34');
    ---------------------
    INSERT INTO t_ware (moniker, name, id_model, sz_orig, sz_rus) 
    VALUES ('Oodji S', 'Ooodji t-shirt size S',
    (SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('oodji')),
    'S', '36');
    ---------------------
    INSERT INTO t_ware (moniker, name, id_model, sz_orig, sz_rus) 
    VALUES ('Oodji M', 'Ooodji t-shirt size M',
    (SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('oodji')),
    'M', '38');
    ---------------------
    INSERT INTO t_ware (moniker, name, id_model, sz_orig, sz_rus) 
    VALUES ('Oodji L', 'Ooodji t-shirt size L',
    (SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('oodji')),
    'L', '40');
    ---------------------
    INSERT INTO t_ware (moniker, name, id_model, sz_orig, sz_rus) 
    VALUES ('Nike Pro S', 'Men''s Nike Pro Shorts size S',
    (SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('nike pro')),
    'S', '28');
    ---------------------
    INSERT INTO t_ware (moniker, name, id_model, sz_orig, sz_rus) 
    VALUES ('Nike Pro M', 'Men''s Nike Pro Shorts size M',
    (SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('nike pro')),
    'M', '34');
    ---------------------
    INSERT INTO t_ware (moniker, name, id_model, sz_orig, sz_rus) 
    VALUES ('Nike Pro L', 'Men''s Nike Pro Shorts size L',
    (SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('nike pro')),
    'L', '40');
    ---------------------
    INSERT INTO t_ware (moniker, name, id_model, sz_orig, sz_rus) 
    VALUES ('UmbroBasic S', 'Umbro Basic Shorts size S',
    (SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('umbro basic')),
    'S', '18');
    ---------------------
    INSERT INTO t_ware (moniker, name, id_model, sz_orig, sz_rus) 
    VALUES ('UmbroBasic M', 'Umbro Basic Shorts size M',
    (SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('umbro basic')),
    'M', '22');
    ---------------------
    INSERT INTO t_ware (moniker, name, id_model, sz_orig, sz_rus) 
    VALUES ('UmbroBasic L', 'Umbro Basic Shorts size L',
    (SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('umbro basic')),
    'L', '25');
    ---------------------
    INSERT INTO t_ware (moniker, name, id_model, sz_orig, sz_rus) 
    VALUES ('Puma White S', 'Puma Lifestyle quarters 3P S',
    (SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('puma white')),
    'S', '25');
    ---------------------
    INSERT INTO t_ware (moniker, name, id_model, sz_orig, sz_rus) 
    VALUES ('Puma White M', 'Puma Lifestyle quarters 3P M',
    (SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('puma white')),
    'M', '27');
    ---------------------
    INSERT INTO t_ware (moniker, name, id_model, sz_orig, sz_rus) 
    VALUES ('Puma White L', 'Puma Lifestyle quarters 3P L',
    (SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('puma white')),
    'L', '29');
    ---------------------
    INSERT INTO t_ware (moniker, name, id_model, sz_orig, sz_rus) 
    VALUES ('Nike U NK S', 'Nike U NK everyday LTWT NS S',
    (SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('nike u nk')),
    'S', '29');
    ---------------------
    INSERT INTO t_ware (moniker, name, id_model, sz_orig, sz_rus) 
    VALUES ('Nike U NK M', 'Nike U NK everyday LTWT NS M',
    (SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('nike u nk')),
    'M', '29');
    ---------------------
    INSERT INTO t_ware (moniker, name, id_model, sz_orig, sz_rus) 
    VALUES ('Nike U NK L', 'Nike U NK everyday LTWT NS L',
    (SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('nike u nk')),
    'L', '29');
    ---------------------
    INSERT INTO t_ware (moniker, name, id_model, sz_orig, sz_rus) 
    VALUES ('NewBalance S', 'New Balance 574 evergreen S',
    (SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('new balance')),
    'S', '36');
    ---------------------
    INSERT INTO t_ware (moniker, name, id_model, sz_orig, sz_rus) 
    VALUES ('NewBalance M', 'New Balance 574 evergreen M',
    (SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('new balance')),
    'M', '39');
    ---------------------
    INSERT INTO t_ware (moniker, name, id_model, sz_orig, sz_rus) 
    VALUES ('NewBalance L', 'New Balance 574 evergreen L',
    (SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('new balance')),
    'L', '42');
    ---------------------
    INSERT INTO t_ware (moniker, name, id_model, sz_orig, sz_rus) 
    VALUES ('Levi''s S', 'Levi''s shoes size S',
    (SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('levi''s')),
    'S', '38');
    ---------------------
    INSERT INTO t_ware (moniker, name, id_model, sz_orig, sz_rus) 
    VALUES ('Levi''s M', 'Levi''s shoes size M',
    (SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('levi''s')),
    'M', '40');
    ---------------------
    INSERT INTO t_ware (moniker, name, id_model, sz_orig, sz_rus) 
    VALUES ('Levi''s L', 'Levi''s shoes size L',
    (SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('levi''s')),
    'L', '41');
    ---------------------
    INSERT INTO t_ware (moniker, name, id_model, sz_orig, sz_rus) 
    VALUES ('Reebok S', 'Reebok classics size S',
    (SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('reebok')),
    'S', '41');
    ---------------------
    INSERT INTO t_ware (moniker, name, id_model, sz_orig, sz_rus) 
    VALUES ('Reebok M', 'Reebok classics size M',
    (SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('reebok')),
    'M', '41');
    ---------------------
    INSERT INTO t_ware (moniker, name, id_model, sz_orig, sz_rus) 
    VALUES ('Reebok L', 'Reebok classics size L',
    (SELECT id_model FROM t_model WHERE UPPER(moniker)=UPPER('reebok')),
    'L', '41');
    

/* ware price data */
---------------------
    INSERT INTO t_price_ware (id_ware, dt_beg, dt_end, price) 
    VALUES ((SELECT id_ware FROM t_ware WHERE UPPER(moniker)=UPPER('lee rider s')),
    TO_DATE('2019/02/09', 'yyyy/mm/dd'), TO_DATE('2019/06/02', 'yyyy/mm/dd'), 56.32);
    ---------------------
    INSERT INTO t_price_ware (id_ware, dt_beg, dt_end, price) 
    VALUES ((SELECT id_ware FROM t_ware WHERE UPPER(moniker)=UPPER('lee rider m')),
    TO_DATE('2019/02/09', 'yyyy/mm/dd'), TO_DATE('2019/06/02', 'yyyy/mm/dd'), 52.32);
    ---------------------
    INSERT INTO t_price_ware (id_ware, dt_beg, dt_end, price) 
    VALUES ((SELECT id_ware FROM t_ware WHERE UPPER(moniker)=UPPER('lee rider l')),
    TO_DATE('2019/02/09', 'yyyy/mm/dd'), TO_DATE('2019/06/02', 'yyyy/mm/dd'), 56.32);
    ---------------------
    INSERT INTO t_price_ware (id_ware, dt_beg, dt_end, price) 
    VALUES ((SELECT id_ware FROM t_ware WHERE UPPER(moniker)=UPPER('armani s')),
    TO_DATE('2019/01/07', 'yyyy/mm/dd'), TO_DATE('2019/05/21', 'yyyy/mm/dd'), 21.15);
    ---------------------
    INSERT INTO t_price_ware (id_ware, dt_beg, dt_end, price) 
    VALUES ((SELECT id_ware FROM t_ware WHERE UPPER(moniker)=UPPER('armani m')),
    TO_DATE('2019/01/07', 'yyyy/mm/dd'), TO_DATE('2019/05/21', 'yyyy/mm/dd'), 21.15);
    ---------------------
    INSERT INTO t_price_ware (id_ware, dt_beg, dt_end, price) 
    VALUES ((SELECT id_ware FROM t_ware WHERE UPPER(moniker)=UPPER('armani l')),
    TO_DATE('2019/01/07', 'yyyy/mm/dd'), TO_DATE('2019/05/21', 'yyyy/mm/dd'), 21.15);
    ---------------------
    INSERT INTO t_price_ware (id_ware, dt_beg, dt_end, price) 
    VALUES ((SELECT id_ware FROM t_ware WHERE UPPER(moniker)=UPPER('mango s')),
    TO_DATE('2019/02/05', 'yyyy/mm/dd'), TO_DATE('2019/05/07', 'yyyy/mm/dd'), 12.56);
    ---------------------
    INSERT INTO t_price_ware (id_ware, dt_beg, dt_end, price) 
    VALUES ((SELECT id_ware FROM t_ware WHERE UPPER(moniker)=UPPER('mango m')),
    TO_DATE('2019/02/05', 'yyyy/mm/dd'), TO_DATE('2019/05/07', 'yyyy/mm/dd'), 14.56);
    ---------------------
    INSERT INTO t_price_ware (id_ware, dt_beg, dt_end, price) 
    VALUES ((SELECT id_ware FROM t_ware WHERE UPPER(moniker)=UPPER('mango l')),
    TO_DATE('2019/02/05', 'yyyy/mm/dd'), TO_DATE('2019/05/07', 'yyyy/mm/dd'), 12.56);
    ---------------------
    INSERT INTO t_price_ware (id_ware, dt_beg, dt_end, price) 
    VALUES ((SELECT id_ware FROM t_ware WHERE UPPER(moniker)=UPPER('benetton s')),
    TO_DATE('2019/01/04', 'yyyy/mm/dd'), TO_DATE('2019/05/12', 'yyyy/mm/dd'), 66.22);
    ---------------------
    INSERT INTO t_price_ware (id_ware, dt_beg, dt_end, price) 
    VALUES ((SELECT id_ware FROM t_ware WHERE UPPER(moniker)=UPPER('benetton m')),
    TO_DATE('2019/01/04', 'yyyy/mm/dd'), TO_DATE('2019/05/12', 'yyyy/mm/dd'), 66.22);
    ---------------------
    INSERT INTO t_price_ware (id_ware, dt_beg, dt_end, price) 
    VALUES ((SELECT id_ware FROM t_ware WHERE UPPER(moniker)=UPPER('benetton l')),
    TO_DATE('2019/01/04', 'yyyy/mm/dd'), TO_DATE('2019/05/12', 'yyyy/mm/dd'), 71.22);
    ---------------------
    INSERT INTO t_price_ware (id_ware, dt_beg, dt_end, price) 
    VALUES ((SELECT id_ware FROM t_ware WHERE UPPER(moniker)=UPPER('dali s')),
    TO_DATE('2019/02/28', 'yyyy/mm/dd'), TO_DATE('2019/04/28', 'yyyy/mm/dd'), 46.12);
    ---------------------
    INSERT INTO t_price_ware (id_ware, dt_beg, dt_end, price) 
    VALUES ((SELECT id_ware FROM t_ware WHERE UPPER(moniker)=UPPER('dali m')),
    TO_DATE('2019/02/28', 'yyyy/mm/dd'), TO_DATE('2019/04/28', 'yyyy/mm/dd'), 46.12);
    ---------------------
    INSERT INTO t_price_ware (id_ware, dt_beg, dt_end, price) 
    VALUES ((SELECT id_ware FROM t_ware WHERE UPPER(moniker)=UPPER('dali l')),
    TO_DATE('2019/02/28', 'yyyy/mm/dd'), TO_DATE('2019/04/28', 'yyyy/mm/dd'), 46.12);
    ---------------------
    INSERT INTO t_price_ware (id_ware, dt_beg, dt_end, price) 
    VALUES ((SELECT id_ware FROM t_ware WHERE UPPER(moniker)=UPPER('sela s')),
    TO_DATE('2019/01/07', 'yyyy/mm/dd'), TO_DATE('2019/04/29', 'yyyy/mm/dd'), 156.26);
    ---------------------
    INSERT INTO t_price_ware (id_ware, dt_beg, dt_end, price) 
    VALUES ((SELECT id_ware FROM t_ware WHERE UPPER(moniker)=UPPER('sela m')),
    TO_DATE('2019/01/07', 'yyyy/mm/dd'), TO_DATE('2019/04/29', 'yyyy/mm/dd'), 156.26);
    ---------------------
    INSERT INTO t_price_ware (id_ware, dt_beg, dt_end, price) 
    VALUES ((SELECT id_ware FROM t_ware WHERE UPPER(moniker)=UPPER('sela l')),
    TO_DATE('2019/01/07', 'yyyy/mm/dd'), TO_DATE('2019/04/29', 'yyyy/mm/dd'), 156.26);
    ---------------------
    INSERT INTO t_price_ware (id_ware, dt_beg, dt_end, price) 
    VALUES ((SELECT id_ware FROM t_ware WHERE UPPER(moniker)=UPPER('topman s')),
    TO_DATE('2019/02/21', 'yyyy/mm/dd'), TO_DATE('2019/06/15', 'yyyy/mm/dd'), 87.12);
    ---------------------
    INSERT INTO t_price_ware (id_ware, dt_beg, dt_end, price) 
    VALUES ((SELECT id_ware FROM t_ware WHERE UPPER(moniker)=UPPER('topman m')),
    TO_DATE('2019/02/21', 'yyyy/mm/dd'), TO_DATE('2019/06/15', 'yyyy/mm/dd'), 84.11);
    ---------------------
    INSERT INTO t_price_ware (id_ware, dt_beg, dt_end, price) 
    VALUES ((SELECT id_ware FROM t_ware WHERE UPPER(moniker)=UPPER('topman l')),
    TO_DATE('2019/02/21', 'yyyy/mm/dd'), TO_DATE('2019/06/15', 'yyyy/mm/dd'), 87.12);
    ---------------------
    INSERT INTO t_price_ware (id_ware, dt_beg, dt_end, price) 
    VALUES ((SELECT id_ware FROM t_ware WHERE UPPER(moniker)=UPPER('brave soul s')),
    TO_DATE('2019/02/16', 'yyyy/mm/dd'), TO_DATE('2019/06/1', 'yyyy/mm/dd'), 35.32);
    ---------------------
    INSERT INTO t_price_ware (id_ware, dt_beg, dt_end, price) 
    VALUES ((SELECT id_ware FROM t_ware WHERE UPPER(moniker)=UPPER('brave soul m')),
    TO_DATE('2019/02/16', 'yyyy/mm/dd'), TO_DATE('2019/06/1', 'yyyy/mm/dd'), 35.32);
    ---------------------
    INSERT INTO t_price_ware (id_ware, dt_beg, dt_end, price) 
    VALUES ((SELECT id_ware FROM t_ware WHERE UPPER(moniker)=UPPER('brave soul l')),
    TO_DATE('2019/02/16', 'yyyy/mm/dd'), TO_DATE('2019/06/1', 'yyyy/mm/dd'), 35.32);
    ---------------------
    INSERT INTO t_price_ware (id_ware, dt_beg, dt_end, price) 
    VALUES ((SELECT id_ware FROM t_ware WHERE UPPER(moniker)=UPPER('oodji s')),
    TO_DATE('2019/02/26', 'yyyy/mm/dd'), TO_DATE('2019/05/13', 'yyyy/mm/dd'), 23.23);
    ---------------------
    INSERT INTO t_price_ware (id_ware, dt_beg, dt_end, price) 
    VALUES ((SELECT id_ware FROM t_ware WHERE UPPER(moniker)=UPPER('oodji m')),
    TO_DATE('2019/02/26', 'yyyy/mm/dd'), TO_DATE('2019/05/13', 'yyyy/mm/dd'), 21.26);
    ---------------------
    INSERT INTO t_price_ware (id_ware, dt_beg, dt_end, price) 
    VALUES ((SELECT id_ware FROM t_ware WHERE UPPER(moniker)=UPPER('oodji l')),
    TO_DATE('2019/02/26', 'yyyy/mm/dd'), TO_DATE('2019/05/13', 'yyyy/mm/dd'), 21.26);
    ---------------------
    INSERT INTO t_price_ware (id_ware, dt_beg, dt_end, price) 
    VALUES ((SELECT id_ware FROM t_ware WHERE UPPER(moniker)=UPPER('nike pro s')),
    TO_DATE('2019/01/30', 'yyyy/mm/dd'), TO_DATE('2019/04/21', 'yyyy/mm/dd'), 65.17);
    ---------------------
    INSERT INTO t_price_ware (id_ware, dt_beg, dt_end, price) 
    VALUES ((SELECT id_ware FROM t_ware WHERE UPPER(moniker)=UPPER('nike pro m')),
    TO_DATE('2019/01/30', 'yyyy/mm/dd'), TO_DATE('2019/04/21', 'yyyy/mm/dd'), 65.17);
    ---------------------
    INSERT INTO t_price_ware (id_ware, dt_beg, dt_end, price) 
    VALUES ((SELECT id_ware FROM t_ware WHERE UPPER(moniker)=UPPER('nike pro l')),
    TO_DATE('2019/01/30', 'yyyy/mm/dd'), TO_DATE('2019/04/21', 'yyyy/mm/dd'), 65.17);
    ---------------------
    INSERT INTO t_price_ware (id_ware, dt_beg, dt_end, price) 
    VALUES ((SELECT id_ware FROM t_ware WHERE UPPER(moniker)=UPPER('umbrobasic s')),
    TO_DATE('2019/04/02', 'yyyy/mm/dd'), TO_DATE('2019/06/17', 'yyyy/mm/dd'), 78.25);
    ---------------------
    INSERT INTO t_price_ware (id_ware, dt_beg, dt_end, price) 
    VALUES ((SELECT id_ware FROM t_ware WHERE UPPER(moniker)=UPPER('umbrobasic m')),
    TO_DATE('2019/04/02', 'yyyy/mm/dd'), TO_DATE('2019/06/17', 'yyyy/mm/dd'), 74.25);
    ---------------------
    INSERT INTO t_price_ware (id_ware, dt_beg, dt_end, price) 
    VALUES ((SELECT id_ware FROM t_ware WHERE UPPER(moniker)=UPPER('umbrobasic l')),
    TO_DATE('2019/04/02', 'yyyy/mm/dd'), TO_DATE('2019/06/17', 'yyyy/mm/dd'), 78.25);
    ---------------------
    INSERT INTO t_price_ware (id_ware, dt_beg, dt_end, price) 
    VALUES ((SELECT id_ware FROM t_ware WHERE UPPER(moniker)=UPPER('puma white s')),
    TO_DATE('2019/04/6', 'yyyy/mm/dd'), TO_DATE('2019/4/30', 'yyyy/mm/dd'), 10.42);
    ---------------------
    INSERT INTO t_price_ware (id_ware, dt_beg, dt_end, price) 
    VALUES ((SELECT id_ware FROM t_ware WHERE UPPER(moniker)=UPPER('puma white m')),
    TO_DATE('2019/04/6', 'yyyy/mm/dd'), TO_DATE('2019/4/30', 'yyyy/mm/dd'), 10.42);
    ---------------------
    INSERT INTO t_price_ware (id_ware, dt_beg, dt_end, price) 
    VALUES ((SELECT id_ware FROM t_ware WHERE UPPER(moniker)=UPPER('puma white l')),
    TO_DATE('2019/04/6', 'yyyy/mm/dd'), TO_DATE('2019/4/30', 'yyyy/mm/dd'), 10.42);
    ---------------------
    INSERT INTO t_price_ware (id_ware, dt_beg, dt_end, price) 
    VALUES ((SELECT id_ware FROM t_ware WHERE UPPER(moniker)=UPPER('nike u nk s')),
    TO_DATE('2019/02/14', 'yyyy/mm/dd'), TO_DATE('2019/05/14', 'yyyy/mm/dd'), 52.89);
    ---------------------
    INSERT INTO t_price_ware (id_ware, dt_beg, dt_end, price) 
    VALUES ((SELECT id_ware FROM t_ware WHERE UPPER(moniker)=UPPER('nike u nk m')),
    TO_DATE('2019/02/14', 'yyyy/mm/dd'), TO_DATE('2019/05/14', 'yyyy/mm/dd'), 52.89);
    ---------------------
    INSERT INTO t_price_ware (id_ware, dt_beg, dt_end, price) 
    VALUES ((SELECT id_ware FROM t_ware WHERE UPPER(moniker)=UPPER('nike u nk l')),
    TO_DATE('2019/02/14', 'yyyy/mm/dd'), TO_DATE('2019/05/14', 'yyyy/mm/dd'), 52.89);
    ---------------------
    INSERT INTO t_price_ware (id_ware, dt_beg, dt_end, price) 
    VALUES ((SELECT id_ware FROM t_ware WHERE UPPER(moniker)=UPPER('newbalance s')),
    TO_DATE('2019/02/17', 'yyyy/mm/dd'), TO_DATE('2019/06/22', 'yyyy/mm/dd'), 21.67);
    ---------------------
    INSERT INTO t_price_ware (id_ware, dt_beg, dt_end, price) 
    VALUES ((SELECT id_ware FROM t_ware WHERE UPPER(moniker)=UPPER('newbalance m')),
    TO_DATE('2019/02/17', 'yyyy/mm/dd'), TO_DATE('2019/06/22', 'yyyy/mm/dd'), 21.67);
    ---------------------
    INSERT INTO t_price_ware (id_ware, dt_beg, dt_end, price) 
    VALUES ((SELECT id_ware FROM t_ware WHERE UPPER(moniker)=UPPER('newbalance l')),
    TO_DATE('2019/02/17', 'yyyy/mm/dd'), TO_DATE('2019/06/22', 'yyyy/mm/dd'), 20.53);
    ---------------------
    INSERT INTO t_price_ware (id_ware, dt_beg, dt_end, price) 
    VALUES ((SELECT id_ware FROM t_ware WHERE UPPER(moniker)=UPPER('levi''s s')),
    TO_DATE('2019/01/15', 'yyyy/mm/dd'), TO_DATE('2019/04/27', 'yyyy/mm/dd'), 27.25);
    ---------------------
    INSERT INTO t_price_ware (id_ware, dt_beg, dt_end, price) 
    VALUES ((SELECT id_ware FROM t_ware WHERE UPPER(moniker)=UPPER('levi''s m')),
    TO_DATE('2019/01/15', 'yyyy/mm/dd'), TO_DATE('2019/04/27', 'yyyy/mm/dd'), 27.25);
    ---------------------
    INSERT INTO t_price_ware (id_ware, dt_beg, dt_end, price) 
    VALUES ((SELECT id_ware FROM t_ware WHERE UPPER(moniker)=UPPER('levi''s l')),
    TO_DATE('2019/01/15', 'yyyy/mm/dd'), TO_DATE('2019/04/27', 'yyyy/mm/dd'), 27.25);
    ---------------------
    INSERT INTO t_price_ware (id_ware, dt_beg, dt_end, price) 
    VALUES ((SELECT id_ware FROM t_ware WHERE UPPER(moniker)=UPPER('reebok s')),
    TO_DATE('2019/02/24', 'yyyy/mm/dd'), TO_DATE('2019/06/17', 'yyyy/mm/dd'), 11.21);
    ---------------------
    INSERT INTO t_price_ware (id_ware, dt_beg, dt_end, price) 
    VALUES ((SELECT id_ware FROM t_ware WHERE UPPER(moniker)=UPPER('reebok m')),
    TO_DATE('2019/02/24', 'yyyy/mm/dd'), TO_DATE('2019/06/17', 'yyyy/mm/dd'), 13.44);
    ---------------------
    INSERT INTO t_price_ware (id_ware, dt_beg, dt_end, price) 
    VALUES ((SELECT id_ware FROM t_ware WHERE UPPER(moniker)=UPPER('reebok l')),
    TO_DATE('2019/02/24', 'yyyy/mm/dd'), TO_DATE('2019/06/17', 'yyyy/mm/dd'), 13.44);
    
/* supply data */
---------------------
   /* INSERT INTO t_sale (num, dt, id_client, e_state, discount) 
    VALUES ('12sdsakkh3', TO_DATE('2019/03/09', 'yyyy/mm/dd'), 
    (SELECT id_client FROM t_client WHERE UPPER(moniker)=UPPER('mysport')), 'done', 0);
    ---------------------
    INSERT INTO t_sale (num, dt, id_client, e_state, discount) 
    VALUES ('1245sakkh3', TO_DATE('2019/04/01', 'yyyy/mm/dd'), 
    (SELECT id_client FROM t_client WHERE UPPER(moniker)=UPPER('mysport')), 'done', 10);
    ---------------------
    INSERT INTO t_sale (num, dt, id_client, e_state, discount) 
    VALUES ('1245swrkh6', TO_DATE('2019/04/07', 'yyyy/mm/dd'), 
    (SELECT id_client FROM t_client WHERE UPPER(moniker)=UPPER('mysport')), 'done', 30);
    ---------------------*/
                    
    
    --COMMIT;
    
    
    
    
    
    
    
