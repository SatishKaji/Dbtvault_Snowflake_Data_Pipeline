SELECT
    p.AS_OF_DATE,
    h.ACCOUNT_ID,
    s.ACCOUNT_TYPE,
    s.OPEN_DATE,
    s.BRANCH_CODE,
    s.BALANCE,
    s.STATUS,
    FROM {{ref("pit_account_details")}} AS p
    JOIN {{ref("hub_account_details")}} AS h
        ON p.ACCOUNT_HK = h.ACCOUNT_HK
    JOIN {{(ref("sat_account_details"))}} AS s
        ON p.ACCOUNT_HK = s.ACCOUNT_HK
        AND p.SAT_ACCOUNT_DETAILS_LDTS = s.LOAD_DTS