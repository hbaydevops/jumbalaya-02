#!/bin/bash

# Update package list and install required dependencies
echo "Updating package list and installing prerequisites..."
sudo apt-get update
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Add Docker's official GPG key
echo "Adding Docker’s official GPG key..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Set up the Docker repository
echo "Setting up Docker repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update the package list again
echo "Updating package list..."
sudo apt-get update

# Install a specific version of Docker (25.0 in this case)
echo "Installing Docker version 25.0..."
sudo apt-get install -y docker-ce=5:25.0.* docker-ce-cli=5:25.0.* containerd.io docker-buildx-plugin docker-compose-plugin

# Verify Docker installation
echo "Verifying Docker installation..."
docker --version

# Enable Docker service and start it
echo "Enabling and starting Docker..."
sudo systemctl enable docker
sudo systemctl start docker

# Test Docker with a simple Hello World container
echo "Testing Docker with 'hello-world' container..."
sudo docker run hello-world

echo "Docker 25.0 installation completed."
