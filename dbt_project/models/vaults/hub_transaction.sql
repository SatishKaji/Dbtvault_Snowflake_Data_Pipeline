{%- set yaml_metadata -%}
source_model: "stg_transaction"
src_pk : "TRANSACTION_HK"
src_nk : "TRANSACTION_ID"
src_ldts : "LOAD_DTS"
src_source: "RECORD_SOURCE"
{%- endset -%}

{% set metadata = fromyaml(yaml_metadata) %}

{{ automate_dv.hub(src_pk=metadata["src_pk"],
                   src_nk=metadata["src_nk"],
                   src_ldts=metadata["src_ldts"],
                   src_source=metadata["src_source"],
                   source_model=metadata["source_model"])}}