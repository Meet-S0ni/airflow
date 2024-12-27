# Set environment variables
ENV AIRFLOW_HOME=/usr/local/airflow \
    PYTHONUNBUFFERED=1 \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    AIRFLOW__CORE__EXECUTOR=SequentialExecutor \
    AIRFLOW__CORE__LOAD_EXAMPLES=False

# Install system dependencies
RUN yum update -y && \
    yum install -y \
    gcc \
    gcc-c++ \
    make \
    python3 \
    python3-pip \
    python3-devel \
    libpq-devel \
    wget \
    unzip \
    which \
    libffi-devel \
    openssl-devel \
    shadow-utils \
    && yum clean all

# Create Airflow directories
RUN mkdir -p ${AIRFLOW_HOME}/dags ${AIRFLOW_HOME}/logs ${AIRFLOW_HOME}/plugins

# Set working directory
WORKDIR ${AIRFLOW_HOME}

# Upgrade pip and install Airflow
RUN pip3 install --upgrade pip setuptools wheel
RUN pip3 install apache-airflow==2.7.1 \
    apache-airflow[postgres,redis,celery]==2.7.1

# Expose Airflow port
EXPOSE 8080

# Add entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Default command to start Airflow
CMD ["/entrypoint.sh"]
