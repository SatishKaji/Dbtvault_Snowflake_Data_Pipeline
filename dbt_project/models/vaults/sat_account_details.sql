{%- set yaml_metadata -%}
source_model: "stg_account_details"
src_pk: "ACCOUNT_HK"
src_hashdiff: "ACCOUNT_HASHDIFF"
src_payload:
  - "ACCOUNT_TYPE"
  - "OPEN_DATE"
  - "BRANCH_CODE"
  - "BALANCE"
  - "STATUS"
src_ldts: "LOAD_DTS"
src_source: "RECORD_SOURCE"
{%- endset -%}

{% set metadata = fromyaml(yaml_metadata) %}

{{ automate_dv.sat(src_pk=metadata["src_pk"],
                   src_hashdiff=metadata["src_hashdiff"],
                   src_payload=metadata["src_payload"],
                   src_ldts=metadata["src_ldts"],
                   src_source=metadata["src_source"],
                   source_model=metadata["source_model"]) }}