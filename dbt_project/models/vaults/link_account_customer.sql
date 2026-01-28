{%- set yaml_metadata -%}
source_model: "stg_account_details"
src_pk: "ACCOUNT_CUSTOMER_HK"
src_fk:
  - "ACCOUNT_HK"
  - "CUSTOMER_HK"
src_ldts: "LOAD_DTS"
src_source: "RECORD_SOURCE"
{%- endset -%}

{% set metadata = fromyaml(yaml_metadata) %}

{{ automate_dv.link(src_pk=metadata["src_pk"],
                    src_fk=metadata["src_fk"],
                    src_ldts=metadata["src_ldts"],
                    src_source=metadata["src_source"],
                    source_model=metadata["source_model"]) }}