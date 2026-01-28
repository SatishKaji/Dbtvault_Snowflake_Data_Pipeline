
{%- set yaml_metadata -%}
source_model:
  VAULT_DB: "transaction"

derived_columns:
  LOAD_DTS: "TO_TIMESTAMP_NTZ(LOAD_DTS)"
  TRANSACTION_DATE: "TO_TIMESTAMP_NTZ(TRANSACTION_DATE)"
  AMOUNT: "TO_DECIMAL(AMOUNT, 18, 2)"

hashed_columns:
  TRANSACTION_HK: "TRANSACTION_ID"
  ACCOUNT_HK: "ACCOUNT_ID"
  TRANSACTION_ACCOUNT_HK:
    - "ACCOUNT_ID"
    - "TRANSACTION_ID"

  TRANSACTION_HASHDIFF:
    is_hashdiff: true
    columns:
      - "TRANSACTION_DATE"
      - "TRANSACTION_TYPE"
      - "AMOUNT"
      - "DESCRIPTION"

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
