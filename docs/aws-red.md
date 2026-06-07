# Arquitectura de red en AWS

## VPC

Una VPC es una red virtual privada y aislada dentro de AWS. Todos los recursos deben vivir dentro de una VPC. Aísla el tráfico de red entre distintos clientes de AWS aunque compartan la misma infraestructura física.

## Subred pública vs subred privada

Una **subred pública** tiene una ruta al Internet Gateway, lo que permite que los recursos reciban tráfico desde internet. Aquí vive la instancia EC2 con NGINX.

Una **subred privada** no tiene ruta al Internet Gateway. Los recursos solo son accesibles desde dentro de la VPC. Aquí vive RDS PostgreSQL, que nunca debe exponerse directamente a internet.

## IP pública dinámica vs Elastic IP

Una IP pública dinámica se asigna al lanzar la instancia y cambia cada vez que se reinicia. Una Elastic IP es una IP fija reservada en tu cuenta que permanece aunque reinicies la instancia. Es necesaria cuando necesitas un DNS o un firewall externo apuntando siempre a la misma IP.

## Arquitectura

La infraestructura vive dentro de una VPC (10.0.0.0/16) en la región eu-west-1. Todo el tráfico de internet entra por el Internet Gateway y llega a la subred pública (10.0.1.0/24) donde está la EC2 con una Elastic IP fija. La EC2 ejecuta NGINX, FastAPI y Redis dentro de Docker.

La base de datos PostgreSQL en RDS vive en la subred privada (10.0.2.0/24) y no tiene acceso directo desde internet. Solo acepta conexiones desde el grupo de seguridad de la EC2 por el puerto 5432.