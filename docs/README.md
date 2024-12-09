# Documentación Entregable Jenkins

*Miembros: Manuel Jesús Otero Bernal y Pablo Virués Suárez*

## Prerrequisitos
Tener instalados tanto Docker como Terraform.
Terraform en windows se descarga mediante chocolatey: 

Instalacón chocolatey:
```
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = `
[System.Net.ServicePointManager]::SecurityProtocol `
-bor 3072
iex ((New-Object `
System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```
Instalacón Terraform:

```
choco install terraform
```



## Imagen Jenkins
Primero personalizamos la imagen Jenkins añadiendole el plugin blueocean mediante:

```
docker build -t myjenkis-blueocean .
```
Y para desplegarla posteriormente en Terraform utilizamos los comandos:

```
terraform init

terraform apply
```


## Jenkins

Una vez levantado el Jenkins, nos dirigimos al puerto 8080 de nuestro localhost, donde se nos pedirá la contraseña para acceder, la cual la obtenemos mediante el comando:

```
docker logs jenkins-blueocean
```


Posteriormente, nos pedirá que nos registremos y escogamos una opción de instalación.

Luego, para lanzar la pipeline Jenkins, tendrás que hacer click en crear una nueva tarea, indicando la opción de Pipeline script from SCM.
### Configuración del SCM en Jenkins

 
   - Escoge `Git` como tu Sistema de Control de Versiones.

   - Proporciona la URL de tu repositorio Git.

 
   - Define la ruta donde se encuentra el archivo `Jenkinsfile` dentro de tu repositorio, en nustro caso `docs/Jenkinsfile`. 

 
   - Indica la rama que deseas buildear, en nuestro caso `main`.


Finalmente podemos hacer click en construir ahora y ver el progreso del pipeline en la interfaz gráfica.

Una vez terminada, el resultado de este es un archivo binario addtovals que podemos descargar desde Jenkins.