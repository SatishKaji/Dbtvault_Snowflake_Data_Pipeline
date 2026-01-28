{%- set yaml_metadata -%}
source_model: "stg_customers"
src_pk: "CUSTOMER_HK"
src_hashdiff: "CUSTOMER_HASHDIFF"
src_payload:
  - "FIRST_NAME"
  - "LAST_NAME"
  - "CUSTOMER_TYPE"
  - "DATE_OF_BIRTH"
  - "EMAIL"
  - "ADDRESS"
  - "CREATED_AT"

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
