# Banking Data Vault on Snowflake (dbt + Airflow)

This project implements a **Data Vault 2.0 architecture** for a **banking domain** using **dbt** on **Snowflake**, with **Apache Airflow** orchestrating the end-to-end data pipeline.

Core banking entities modeled:
- Customer
- Account
- Transaction


---
## Prerequisites

- A Snowflake account with the necessary permissions.
- dbt Core installed locally.
- Airflow installed (either locally or on a server).
- Docker installed.
---

## Architecture Overview
```
RAW DATA (Snowflake)
↓
STAGING (Views)
↓
DATA VAULT
├── Hubs
├── Links
└── Satellites
↓
Data Marts
```


---

## Data Vault Layers

### 1. Staging Layer
- Materialized as **views**
- Standardizes raw data
- Generates hash keys and hashdiffs
- No history stored

### 2. Hubs
- Store **unique business keys**
- One row per business key
- Insert-only
- Materialized as **incremental models**

### 3. Links
- Store **relationships** between business keys
- Insert-only
- Materialized as **incremental models**

### 4. Satellites
- Store **descriptive and historical attributes**
- New row inserted only when data changes
- Materialized as **incremental models**

---

##  Project Structure
The project follows a standard dbt structure:

```

.
├── models/
│   ├── staging/
│   ├── analytics/
│   ├── utils/
│   ├── vaults/
│
├── macros/
│
├── packages.yml
│
└── dbt_project.yml

```


---

## Technologies Used

- **Snowflake** – Cloud data warehouse  
- **dbt** – Data transformation framework  
- **dbtvault / automate_dv** – Data Vault 2.0 macros  
- **Apache Airflow** – Workflow orchestration  
- **SQL & Python** – Transformation and orchestration logic  

---

## Key Concepts Used

- Data Vault 2.0 modeling
- Hash keys and hashdiffs
- Insert-only incremental loading
- Record source tracking
- Load date auditing
- Separation of raw, staging, and vault layers

---
## Orchestration

This project is designed to be orchestrated by an external tool like Airflow. A typical Airflow DAG would look something like this:

- **dbt Deps**: A task to install required project dependencies.
- **dbt Run**: A task to run the entire dbt project.
- **dbt Test**: A task to run all tests to ensure data integrity.
