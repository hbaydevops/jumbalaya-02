#!/bin/bash

sudo apt update
sudo apt install fontconfig openjdk-17-jre

sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins

install_docker() {

    # Remove any older versions of Docker
    sudo apt-get remove -y docker docker-engine docker.io containerd runc

    # Update package index and fix any broken dependencies
    sudo apt-get update -y
    sudo apt-get -f install -y

    # Install required packages
    sudo apt-get install -y ca-certificates curl gnupg

    # Add Docker's official GPG key
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo tee /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Set up Docker's stable repository
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] \
    https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    # Update the package index with the new Docker repo
    sudo apt-get update -y

    # Define Docker version and install it
    VERSION_STRING="5:26.0.0-1~ubuntu.22.04~jammy"  # Adjust version if necessary
    sudo apt-get install -y docker-ce=$VERSION_STRING docker-ce-cli=$VERSION_STRING containerd.io docker-buildx-plugin docker-compose-plugin

    # Start Docker and enable it to start on boot
    sudo systemctl start docker
    sudo systemctl enable docker

    # Test Docker installation
    sudo docker run hello-world || { echo "Docker installation failed"; exit 1; }
}

# Function to install and run SonarQube with pre-install requirements
install_sonarqube() {

    # Set system limits required by SonarQube
    echo "Setting system limits for SonarQube..."
    sysctl -w vm.max_map_count=524288

    sysctl -w fs.file-max=131072

    ulimit -n 131072

    ulimit -u 8192

    # Create a Docker network for SonarQube and PostgreSQL
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
      sonarqube:community || { echo "SonarQube container failed to start"; exit 1; }
}

# Main script execution
install_docker
install_sonarqube

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" 

sudo apt install unzip

sudo unzip awscliv2.zip  

sudo ./aws/install

curl --silent --location "https://github.com/weaveworks/eksctl/releases/download/v0.154.0/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin

curl -LO https://dl.k8s.io/release/v1.25.0/bin/linux/amd64/kubectl

sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
sudo apt-get install apt-transport-https --yes
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm

helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

echo "vm.max_map_count=524288" | sudo tee -a /etc/sysctl.conf
echo "fs.file-max=131072" | sudo tee -a /etc/sysctl.conf

sudo sysctl -p

echo "* soft nofile 131072" | sudo tee -a /etc/security/limits.conf
echo "* hard nofile 131072" | sudo tee -a /etc/security/limits.conf
echo "* soft nproc 8192" | sudo tee -a /etc/security/limits.conf
echo "* hard nproc 8192" | sudo tee -a /etc/security/limits.conf
