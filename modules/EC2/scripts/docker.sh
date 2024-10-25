#!/bin/bash

# Function to install Docker version 24
install_docker() {

    # Remove any older versions of Docker
    sudo apt-get remove -y docker docker-engine docker.io containerd runc

    # Update package index
    sudo apt-get update -y
    sudo apt-get -f install

    # Install required packages
    sudo apt-get install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        software-properties-common

    # Set up the Docker repository
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list

    # Update package index again after adding Docker repo
    sudo apt-get update -y
    sudo apt-get -f install

    # Install Docker
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io

    # Start Docker and enable it to start on boot
    sudo systemctl start docker
    sudo systemctl enable docker
}

# Function to install and run SonarQube
install_sonarqube() {
    # Create a Docker network
    echo "Creating Docker network 'sonarnet'..."
    docker network create sonarnet

    # Run PostgreSQL container
    echo "Running PostgreSQL container..."
    docker run -d --name sonarqube_db \
      --network sonarnet \
      -e POSTGRES_USER=sonar \
      -e POSTGRES_PASSWORD=sonar \
      -e POSTGRES_DB=sonarqube \
      postgres:13

    # Run SonarQube container
    echo "Running SonarQube container..."
    docker run -d --name sonarqube \
      --network sonarnet \
      -p 9000:9000 \
      -e SONAR_JDBC_URL=jdbc:postgresql://sonarqube_db:5432/sonarqube \
      -e SONAR_JDBC_USERNAME=sonar \
      -e SONAR_JDBC_PASSWORD=sonar \
      sonarqube:community

}

# Main script execution
install_docker
install_sonarqube
