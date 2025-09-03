SET search_path TO olist, public;

-- Average Delivery Time and Late Delivery Share
SELECT
  ROUND(AVG((oo.order_delivered_customer_date::date - oo.order_purchase_timestamp::date))::numeric, 2) AS avg_delivery_days,
  ROUND(100.0 * SUM(CASE WHEN oo.order_delivered_customer_date > oo.order_estimated_delivery_date THEN 1 ELSE 0 END)
    / NULLIF(COUNT(*), 0),2) AS late_delivery_rate_pct
FROM olist_orders oo
WHERE oo.order_delivered_customer_date IS NOT NULL
  AND oo.order_estimated_delivery_date IS NOT NULL;

-- Monthly Order Delivery Volume
SELECT
  DATE_TRUNC('month', order_delivered_customer_date)::date AS delivered_month,
  COUNT(*) AS orders_cnt
FROM olist_orders
WHERE order_delivered_customer_date IS NOT NULL
GROUP BY delivered_month
ORDER BY delivered_month;