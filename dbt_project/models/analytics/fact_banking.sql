SELECT
    ht.transaction_id,
    hc.customer_id,
    ha.account_id,
    st.transaction_date,
    st.transaction_type,
    st.amount,
    st.description

    FROM {{ref('sat_transaction')}} AS st
    JOIN {{ref('hub_transaction')}} AS ht
        ON st.transaction_hk = ht.transaction_hk
    JOIN {{ref('link_account_transaction')}} AS lat
        ON ht.transaction_hk = lat.transaction_hk
    JOIN {{ref('hub_account_details')}} AS ha
        ON lat.account_hk = ha.account_hk
    JOIN {{ref('link_account_customer')}} AS lac
        ON ha.account_hk = lac.account_hk
    JOIN {{ref('hub_customers')}} AS hc
        ON lac.customer_hk = hc.customer_hk

