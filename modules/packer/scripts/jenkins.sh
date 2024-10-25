#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status.

function install_jenkins() {
    # Update the package list
    echo "Updating the package list..."
    sudo apt-get update -y
    
    # Fix broken dependencies, if any
    echo "Fixing broken dependencies..."
    sudo apt-get -f install -y

    # Install required dependencies: curl, wget, gnupg, and OpenJDK 11
    echo "Installing required packages: curl, wget, gnupg, and OpenJDK 11..."
    sudo apt-get install -y curl wget gnupg openjdk-11-jdk

    # Add the Jenkins key to the keyring
    echo "Adding the Jenkins repository key..."
    curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null

    # Add Jenkins repository to the sources list
    echo "Adding the Jenkins repository..."
    echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

    # Update package index with the new Jenkins repository
    echo "Updating package index with Jenkins repository..."
    sudo apt-get update -y

    # Install Jenkins
    echo "Installing Jenkins..."
    sudo apt-get install -y jenkins

    # Start Jenkins service
    echo "Starting Jenkins service..."
    sudo systemctl start jenkins

    # Enable Jenkins to start on boot
    echo "Enabling Jenkins service to start on boot..."
    sudo systemctl enable jenkins

    # Check the status of the Jenkins service
    echo "Checking Jenkins status..."
    sudo systemctl status jenkins || echo "Jenkins failed to start. Please check the logs."
}

# Execute the Jenkins installation function
install_jenkins
