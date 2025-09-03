SET search_path TO olist, public;

-- Summary Metrics: Orders, Unique Customers, Sellers
SELECT
	COUNT(oo.order_id) AS number_of_orders,
	COUNT(DISTINCT oo.customer_id) AS number_of_unique_customers,
	COUNT(DISTINCT ooi.seller_id) AS number_of_sellers
FROM olist_orders AS oo
LEFT JOIN olist_order_items AS ooi
	ON oo.order_id=ooi.order_id;