# Implementación de Infraestructura AWS con Terraform para una Aplicación Web Completa

Este proyecto utiliza Terraform para desplegar una infraestructura completa en AWS que soporta una aplicación web con un formulario de contacto, un servidor web Apache, PHP y notificaciones a través de SNS.


## Requisitos

- [Terraform](https://www.terraform.io/downloads.html) 0.12+
- [AWS CLI](https://aws.amazon.com/cli/) configurado con las credenciales adecuadas
- Una llave SSH para acceder a las instancias EC2

## Variables

Las siguientes variables deben ser definidas en un archivo `terraform.tfvars` o pasadas como parámetros al ejecutar Terraform:

```hcl
aws_region         = "aqui tu region"
vpc_cidr_block     = "10.0.0.0/16"
subnet_cidr_block  = "10.0.1.0/24"
ami                = "ami-08a0d1e16fc3f61ea"
instance_type      = "t2.micro"
key_name           = "vockey"
subscription_email = "tu-email@correo.com"
```
## Inicializar el Proyecto
- Clona este repositorio en tu máquina local.
- Navega al directorio del proyecto.
- Ejecuta terraform init para inicializar el proyecto y descargar los proveedores necesarios.
## Planificar y Aplicar la Infraestructura
- Ejecuta terraform plan para ver el plan de ejecución y verificar que todo esté correctamente configurado.
- Ejecuta terraform apply para aplicar los cambios y desplegar la infraestructura en AWS.
## Acceder a la Aplicación
- Una vez que Terraform complete el despliegue, puedes acceder a tu aplicación web utilizando la dirección IP pública de la instancia EC2. Esta dirección IP se muestra en la salida de Terraform.

## Notificaciones de SNS
El formulario de contacto en la aplicación web enviará notificaciones a la dirección de correo electrónico especificada utilizando Amazon SNS.

## Archivos
- vpc/main.tf
- Define la VPC, subred, gateway de internet y tabla de rutas.

- ec2/main.tf
- Define la instancia EC2, incluye el script de usuario para instalar Apache, PHP y configurar el formulario de contacto.

- security_group/main.tf
- Define el grupo de seguridad para permitir el tráfico HTTP y SSH.

- sns/main.tf
- Define el tópico SNS y la suscripción para enviar notificaciones por correo electrónico.

- main.tf
- Incluye los módulos y variables principales para el proyecto.

- outputs.tf
- Define las salidas del proyecto como la dirección IP pública de la instancia EC2 y el ARN del tópico SNS.

- variables.tf
- Define las variables utilizadas en el proyecto.

## Contribuciones
Las contribuciones son bienvenidas. Si tienes alguna sugerencia o encuentras algún problema, por favor abre un issue o envía un pull request.

