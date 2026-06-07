# AWS Teoría

## Computación en la nube

La computación en la nube es el acceso bajo demanda a recursos de computación (servidores, almacenamiento, redes, bases de datos) a través de internet, pagando solo por lo que se usa. En lugar de comprar y mantener servidores físicos propios, se alquilan a un proveedor como AWS.

## IaaS, PaaS y SaaS

- IaaS (Infraestructura como servicio): el proveedor ofrece hardware virtualizado. Tú gestionas el sistema operativo, el software y las aplicaciones. Ejemplo: EC2. AWS EC2 se enmarca en este modelo.

- PaaS (Plataforma como servicio): el proveedor gestiona el sistema operativo y el entorno de ejecución. Tú solo despliegas el código. Ejemplo: AWS Elastic Beanstalk.

- SaaS (Software como servicio): el proveedor gestiona todo, incluyendo la aplicación. Tú solo la usas. Ejemplo: Gmail, Salesforce.

## Modelo de responsabilidad compartida

AWS gestiona la seguridad **de** la nube: hardware físico, instalaciones,
red global, hipervisores y servicios gestionados como RDS.

El cliente gestiona la seguridad **en** la nube: sistema operativo de la EC2, parches, configuración de grupos de seguridad, gestión de usuarios IAM, cifrado de datos y configuración de aplicaciones.

## Conceptos clave

- Región: ubicación geográfica con múltiples centros de datos. Ejemplo: eu-west-1 es Irlanda. Los datos no salen de la región salvo que lo configures explícitamente.

- Zona de disponibilidad (AZ): centro de datos independiente dentro de una región. Cada región tiene al menos tres AZ. Distribuir recursos entre AZ garantiza alta disponibilidad ante fallos físicos.

- VPC (Virtual Private Cloud): red virtual privada y aislada dentro de AWS donde viven tus recursos. Tú controlas el rango de IPs, las subredes y las reglas de red.

- Subred: segmento de una VPC con un rango de IPs propio. Puede ser pública
(con acceso a internet) o privada (sin acceso directo al exterior).

- Grupo de seguridad (Security Group): firewall virtual que controla el tráfico
de entrada y salida de recursos como EC2 o RDS mediante reglas de puerto, protocolo
e IP de origen.

- AMI (Amazon Machine Image): plantilla con el sistema operativo y la configuración base para lanzar una instancia EC2. Equivale a una imagen Docker pero para máquinas virtuales completas.

- Instancia EC2: servidor virtual que corre sobre la infraestructura de AWS. El tipo t2.micro tiene 1 vCPU y 1GB de RAM y está incluido en el free tier.

## Free Tier de AWS

Durante los primeros 12 meses desde la creación de la cuenta:

- EC2: 750 horas/mes de instancias t2.micro o t3.micro con Linux
- RDS: 750 horas/mes de instancias db.t3.micro, 20GB de almacenamiento
- S3: 5GB de almacenamiento, 20.000 peticiones GET, 2.000 peticiones PUT

## Por qué nunca usar la cuenta raíz para operaciones diarias

La cuenta raíz tiene acceso ilimitado e irrevocable a todos los recursos y
servicios de AWS, incluyendo la cancelación de la cuenta y el acceso a la
facturación. Si las credenciales raíz se comprometen, el atacante tiene control total. Por eso se crea un usuario IAM administrador para el trabajo diario y la cuenta raíz se reserva solo para tareas de gestión de la cuenta como cambiar el plan de soporte o cerrar la cuenta.

## Glacier y ciclo de vida de datos

AWS S3 Glacier es una clase de almacenamiento de muy bajo coste diseñada para datos que raramente se consultan, como backups históricos o archivos de auditoría. Tiene sentido usarlo cuando los datos deben conservarse por normativa pero no se necesitan en el día a día. Una regla de ciclo de vida automatiza el movimiento de objetos de S3 estándar a Glacier tras un número de días definido.

## Flujo de una petición HTTP hasta la base de datos

Navegador → DNS resuelve el dominio a la Elastic IP → NGINX en EC2 recibe la petición en el puerto 80 → NGINX hace proxy_pass al backend FastAPI en el puerto 8000 → FastAPI ejecuta la lógica y consulta RDS PostgreSQL en la subred privada por el puerto 5432 → RDS devuelve los datos → FastAPI construye la respuesta → NGINX la devuelve al navegador.