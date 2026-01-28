
{%- set yaml_metadata -%}
source_model:
  VAULT_DB: "account_details"

derived_columns:
  LOAD_DTS: "TO_TIMESTAMP_NTZ(LOAD_DTS)"
  OPEN_DATE: "TO_DATE(OPEN_DATE)"
  BALANCE: "TO_DECIMAL(BALANCE, 18, 2)"

hashed_columns:
  ACCOUNT_HK: "ACCOUNT_ID"
  CUSTOMER_HK: "CUSTOMER_ID"
  ACCOUNT_CUSTOMER_HK:
    - "ACCOUNT_ID"
    - "CUSTOMER_ID"

  ACCOUNT_HASHDIFF:
    is_hashdiff: true
    columns:
      - "ACCOUNT_TYPE"
      - "OPEN_DATE"
      - "BRANCH_CODE"
      - "BALANCE"
      - "STATUS"
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ automate_dv.stage(
    include_source_columns=true,
    source_model=metadata_dict["source_model"],
    derived_columns=metadata_dict["derived_columns"],
    null_columns=none,
    hashed_columns=metadata_dict["hashed_columns"],
    ranked_columns=none
) }}
