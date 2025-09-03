SET search_path TO olist, public;

--Sales Funnel
WITH counts AS 
	(SELECT 
        	order_status,
        	COUNT(order_id) AS orders_count
    FROM olist_orders
    GROUP BY order_status)
SELECT 
    	order_status,
    	orders_count,
    	ROUND(orders_count * 100.0 /
        	NULLIF(
            	LAG(orders_count) OVER 
				(ORDER BY CASE order_status
                    	WHEN 'created'     THEN 1
                    	WHEN 'approved'    THEN 2
                    	WHEN 'invoiced'    THEN 3
                    	WHEN 'processing'  THEN 4
                    	WHEN 'shipped'     THEN 5
                    	WHEN 'delivered'   THEN 6
                    	WHEN 'canceled'    THEN 7
                    	WHEN 'unavailable' THEN 8
                    	ELSE 9
                	END), 0),2) AS conversion_pct
FROM counts
ORDER BY CASE order_status
    WHEN 'created'     THEN 1
    WHEN 'approved'    THEN 2
    WHEN 'invoiced'    THEN 3
    WHEN 'processing'  THEN 4
    WHEN 'shipped'     THEN 5
    WHEN 'delivered'   THEN 6
    WHEN 'canceled'    THEN 7
    WHEN 'unavailable' THEN 8
    ELSE 9
END;