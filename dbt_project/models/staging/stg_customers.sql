
{%- set yaml_metadata -%}
source_model:
    VAULT_DB : "customers"
derived_columns:
    LOAD_DTS: "TO_TIMESTAMP_NTZ(LOAD_DTS)"
    DATE_OF_BIRTH: "TO_DATE(DATE_OF_BIRTH)"
    CREATED_AT: "TO_TIMESTAMP_NTZ(CREATED_AT)"

hashed_columns:
    CUSTOMER_HK: "CUSTOMER_ID"

    CUSTOMER_HASHDIFF:
        is_hashdiff: true
        columns:
            - "FIRST_NAME"
            - "LAST_NAME"
            - "CUSTOMER_TYPE"
            - "DATE_OF_BIRTH"
            - "EMAIL"
            - "ADDRESS"
            - "CREATED_AT"
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}


{{ automate_dv.stage(include_source_columns=true,
                     source_model=metadata_dict["source_model"],
                     derived_columns=metadata_dict["derived_columns"],
                     null_columns=none,
                     hashed_columns=metadata_dict["hashed_columns"],
                     ranked_columns=none) }}
