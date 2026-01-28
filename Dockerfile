
FROM apache/airflow:2.9.2
WORKDIR /opt/airflow
USER root
COPY requirements.txt .
USER airflow
RUN pip install --no-cache-dir -r requirements.txt
