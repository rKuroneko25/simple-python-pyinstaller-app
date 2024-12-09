terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {
  host = "npipe:////.//pipe//docker_engine"
}

# Crear la red Docker
resource "docker_network" "jenkins" {
  name = "jenkins"
}

# Volumen para jenkins-docker-certs
resource "docker_volume" "jenkins_docker_certs" {
  name = "jenkins-docker-certs"
}

# Volumen para jenkins-data
resource "docker_volume" "jenkins_data" {
  name = "jenkins-data"
}

# Contenedor jenkins-docker
resource "docker_container" "jenkins_docker" {
  name       = "jenkins-docker"
  image      = "docker:dind"
  privileged = true
  restart    = "no"

  env = [
    "DOCKER_TLS_CERTDIR=/certs"
  ]

  volumes {
    volume_name    = docker_volume.jenkins_docker_certs.name
    container_path = "/certs/client"
  }

  volumes {
    volume_name    = docker_volume.jenkins_data.name
    container_path = "/var/jenkins_home"
  }

  networks_advanced {
    name    = docker_network.jenkins.name
    aliases = ["docker"]
  }

  ports {
    internal = 2376
    external = 2376
  }
}

# Contenedor jenkins-blueocean
resource "docker_container" "jenkins_blueocean" {
  name    = "jenkins-blueocean"
  image   = "myjenkins-blueocean"
  restart = "on-failure"

  env = [
    "DOCKER_HOST=tcp://docker:2376",
    "DOCKER_CERT_PATH=/certs/client",
    "DOCKER_TLS_VERIFY=1"
  ]

  volumes {
    volume_name    = docker_volume.jenkins_data.name
    container_path = "/var/jenkins_home"
  }

  volumes {
    volume_name    = docker_volume.jenkins_docker_certs.name
    container_path = "/certs/client"
    read_only      = true
  }

  networks_advanced {
    name = docker_network.jenkins.name
  }

  ports {
    internal = 8080
    external = 8080
  }

  ports {
    internal = 50000
    external = 50000
  }
}
