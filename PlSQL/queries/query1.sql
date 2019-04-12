--QUERY-01 Найти товары, цены на которые отличаются от цены на модель.
    
    SELECT t_ware.id_ware, moniker, name, t_price_ware.price ware_price, t_price_model.price model_price
    from t_ware 
    INNER JOIN t_price_model
    ON t_ware.id_model = t_price_model.id_model
    INNER JOIN t_price_ware
    ON t_ware.id_ware = t_price_ware.id_ware
    WHERE t_price_ware.price!=t_price_model.price;
