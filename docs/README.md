# Documentación Entregable Jenkins

*Miembros: Manuel Jesús Otero Bernal y Pablo Virués Suárez*

## Prerrequisitos
Tener instalados tanto Docker como Terraform, éste último en windows se descarga mediante el comando de chocolatey 

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

Una vez levantado el Jenkins, nos dirigimos al puerto 8080 de nuestro localhost, donde se nos pedirá la contraseña para acceder.

Posteriormente, nos pedirá que nos registremos y escogamos una opción de instalación.

Luego, para lanzar la pipeline Jenkins, tendrás que hacer click en crear una nueva tarea, indicando la opción de Pipeline script from SCM.
Y tendremos que escoger como SCM a Git, incluir la url de nuestro repositoro, indicar el path donde se encuentra nuestro Jenkisfile en el repo, y la rama a buildear.

Finalmente podemos hacer click en construir ahora y ver el progreso del pipeline en la interfaz gráfica.

Una vez terminada, el resultado de este es un archivo binario de la compilación de la librería de calc.py 