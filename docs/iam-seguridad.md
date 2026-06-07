# IAM y seguridad

## Principio de mínimo privilegio

Un usuario o servicio solo debe tener los permisos estrictamente necesarios para
su función. Si un atacante compromete una cuenta con permisos mínimos, el daño está limitado a esa función concreta. Si la cuenta tiene permisos de administrador, el atacante tiene acceso total. En AWS esto se aplica creando políticas específicas en lugar de asignar AdministratorAccess a todo.

## Políticas basadas en identidad vs políticas basadas en recursos

- Política basada en identidad se adjunta a un usuario, grupo o rol de IAM
y define qué acciones puede realizar esa identidad. Ejemplo: permitir a un usuario leer objetos de S3.

-  Política basada en recursos se adjunta directamente al recurso y define
quién puede acceder a él. Ejemplo: una política de bucket S3 que permite acceso solo desde una VPC concreta. Se usan cuando necesitas controlar el acceso entre cuentas de AWS distintas.

## Roles de IAM vs usuarios de IAM

- Un usuario tiene credenciales permanentes (contraseña y access keys) asociadas a una persona. 
- Un rol es una identidad temporal que se asume por un tiempo
limitado y genera credenciales de corta duración automáticamente.

Las instancias EC2 usan roles en lugar de usuarios porque no hay una persona detrás que gestione las credenciales. El rol se asocia a la instancia y AWS rota las credenciales automáticamente. Guardar access keys de un usuario directamente en una EC2 es una mala práctica porque si alguien accede al servidor obtiene credenciales permanentes.