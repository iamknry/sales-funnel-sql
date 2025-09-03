SET search_path TO olist, public;

-- Avarage and Median Order Value
WITH order_totals AS (
    SELECT 
        order_id,
        SUM(price) AS order_total
    FROM olist_order_items
    GROUP BY order_id
)
SELECT 
    ROUND(AVG(order_total), 2) AS avg_order_value,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY order_total) AS median_order_value
FROM order_totals;

-- Top Payment Types by Order Value
SELECT
		oop.payment_type,
		SUM(ooi.price) AS order_value
FROM olist_order_payments AS oop
JOIN olist_order_items AS ooi
	ON ooi.order_id=oop.order_id
GROUP BY payment_type
ORDER BY order_value DESC;

--Top 10 Sellers by Order Value
SELECT
		seller_id AS sellers,
		SUM(price) AS order_value
FROM olist_order_items
GROUP BY seller_id
ORDER BY order_value DESC
LIMIT 10;
		