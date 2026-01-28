{{ config(
    materialized='table',
) }}



{%- set yaml_metadata -%}
source_model: "hub_customers"
src_pk: "CUSTOMER_HK"
as_of_dates_table: "as_of_date"
satellites: 
  sat_customers:
    pk:
      PK: "CUSTOMER_HK"
    ldts:
      LDTS: "LOAD_DTS"
stage_tables_ldts: 
  stg_customers: "LOAD_DTS"
src_ldts: "LOAD_DTS"
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ automate_dv.pit(
    source_model=metadata_dict["source_model"],
    src_pk=metadata_dict["src_pk"],
    as_of_dates_table=metadata_dict["as_of_dates_table"],
    satellites=metadata_dict["satellites"],
    stage_tables_ldts=metadata_dict["stage_tables_ldts"],
    src_ldts=metadata_dict["src_ldts"]

) }}


