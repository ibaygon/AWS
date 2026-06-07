# AWS Toolkit

Despliegue del sys-admin toolkit en infraestructura cloud de AWS.

Stack completo desplegado en AWS: FastAPI en EC2 t3.micro con Ubuntu 24.04,
base de datos PostgreSQL en RDS en subred privada, backups automáticos en S3 y acceso controlado mediante IAM con mínimo privilegio.

Despliegue: URL 
API pública: http://54.154.104.115/docs
Repositorio: https://github.com/ibaygon/aws

---

## Características

1. Instancia EC2 t3.micro con Docker Compose ejecutando NGINX, FastAPI y Redis en subred pública con Elastic IP fija
2. Base de datos RDS PostgreSQL 15 en subred privada, solo accesible desde la EC2 por el puerto 5432
3. Backups automáticos diarios a S3 con ciclo de vida que mueve los objetos a Glacier tras 30 días

---

## Tecnologías

### Infraestructura AWS

EC2 t3.micro — servidor virtual con Ubuntu 24.04 que ejecuta el stack Docker completo.
RDS PostgreSQL 15 — base de datos gestionada en subred privada sin acceso público.
S3 — almacenamiento de backups comprimidos con ciclo de vida automático a Glacier.

### Seguridad

IAM — usuarios y roles con mínimo privilegio. El rol rol-ec2-s3 permite a la EC2
subir backups a S3 sin credenciales manuales.
Security Groups — firewall por servicio: ec2-web-sg expone los puertos 22, 80 y 443,
rds-postgres-sg solo acepta conexiones PostgreSQL desde ec2-web-sg.
VPC — red privada aislada con subred pública para EC2 y subred privada para RDS.

**Aplicación**

FastAPI — API REST con Swagger UI accesible en /docs.
Redis — caché de resultados del parseo de logs SSH.
NGINX — proxy inverso en puerto 80 con rate limiting.

---

## Estructura del proyecto

El repositorio contiene la documentación técnica en la carpeta docs y los scripts de infraestructura en la raíz.

- docs/aws-teoria.md explica los modelos IaaS, PaaS y SaaS, el modelo de
responsabilidad compartida, los conceptos clave de AWS y el free tier.
- docs/iam-seguridad.md documenta el principio de mínimo privilegio, la diferencia entre políticas basadas en identidad y en recursos, y el uso de roles.
- docs/aws-red.md describe la arquitectura de red con VPC, subredes, Internet
Gateway y la diferencia entre IP dinámica y Elastic IP.
- docs/rds-teoria.md explica las ventajas de RDS frente a PostgreSQL en EC2.
- s3_backup.sh es el script que comprime el directorio de datos y lo sube a S3, programado en cron para ejecutarse cada día a las 2:00 AM.

---

## Descargar y ejecutar

```bash
git clone https://github.com/ibaygon/aws.git
cd aws
```

Conéctate a la EC2:

```bash
ssh -i ~/.ssh/asir-keypair.pem ubuntu@54.154.104.115
```

Levanta el stack:

```bash
cd docker
docker compose up -d
```

Ejecuta un backup manual:

```bash
/home/ubuntu/s3_backup.sh
aws s3 ls s3://asir-backups-pietro/backups/
```

---

## Desarrollado durante las prácticas en Corner Estudios — Pietro — 2026