SELECT
    p.AS_OF_DATE,
    h.CUSTOMER_ID,
    s.FIRST_NAME,
    s.LAST_NAME,
    s.CUSTOMER_TYPE,
    s.DATE_OF_BIRTH,
    s.EMAIL,
    s.CREATED_AT,
    s.ADDRESS
    FROM {{ref("pit_customers")}} AS p
    JOIN {{ref("hub_customers")}} AS h
        ON p.CUSTOMER_HK = h.CUSTOMER_HK
    JOIN {{(ref("sat_customers"))}} AS s
        ON p.CUSTOMER_HK = s.CUSTOMER_HK
        AND p.SAT_CUSTOMERS_LDTS = s.LOAD_DTS