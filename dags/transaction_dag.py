
import pendulum
from airflow import DAG
from airflow.operators.bash import BashOperator

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': pendulum.duration(minutes=5),
}

with DAG(
    dag_id='dbtvault_snowflake_etl',
    default_args=default_args,
    description='A DAG to run dbt models on Snowflake',
    schedule=None, 
    start_date = pendulum.datetime(2026, 1, 1, tz="Europe/Berlin"),
    catchup=False,
    tags=['dbtvault', 'snowflake', 'etl'],
) as dag:
    


    dbt_deps_task = BashOperator(
        task_id="dbt_deps",
        bash_command="dbt deps",
        cwd="/opt/airflow/dbt_project",
     )
    
    dbt_test_task = BashOperator(
        task_id="dbt_test",
        bash_command="dbt test",
        cwd="/opt/airflow/dbt_project",
    )

    dbt_run_staging = BashOperator(
        task_id="dbt_run_staging",
        bash_command="dbt run --models models/staging",
        cwd="/opt/airflow/dbt_project",
        trigger_rule='all_success'
    )
    
    dbt_run_utils = BashOperator(
        task_id="dbt_run_utils",
        bash_command="dbt run --models models/utils",
        cwd="/opt/airflow/dbt_project",
        trigger_rule='all_success'
    )

    dbt_run_vaults = BashOperator(
        task_id="dbt_run_vaults",
        bash_command="dbt run --models models/vaults",
        cwd="/opt/airflow/dbt_project",
        trigger_rule='all_success'
    )

    dbt_run_analytics = BashOperator(
        task_id="dbt_run_analytics",
        bash_command="dbt run --models models/analytics",
        cwd="/opt/airflow/dbt_project",
        trigger_rule='all_success'
    )

    dbt_deps_task  >> dbt_run_staging >> dbt_run_utils >> dbt_run_vaults >> dbt_run_analytics >> dbt_test_task

