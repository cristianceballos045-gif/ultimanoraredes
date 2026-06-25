# Usamos una base estable de Debian 12
FROM debian:12-slim

# Evita bloqueos en la instalacion por solicitudes de usuario
ENV DEBIAN_FRONTEND=noninteractive

# Instalamos herramientas de red basicas, Python y utilidades
RUN apt-get update && apt-get install -y \
    iproute2 \
    iputils-ping \
    net-tools \
    curl \
    openssh-client \
    isc-dhcp-client \
    python3 \
    python3-pip \
    python3-venv \
    nano \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Creamos un entorno virtual de Python e instalamos Ansible y librerias de red
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

RUN pip3 install --no-cache-dir --upgrade pip && \
    pip3 install --no-cache-dir ansible netmiko paramiko

# Definimos el directorio de trabajo por defecto
WORKDIR /app

# Comando base para mantener el contenedor activo en GNS3
CMD ["/bin/bash"]

