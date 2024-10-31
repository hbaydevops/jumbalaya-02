#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status.

function install_jenkins() {
   
    sudo apt-get update -y
    sudo apt-get -f install
    sudo apt-get install -y curl wget gnupg openjdk-17-jdk
    curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null

    echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
    sudo apt-get update -y
    sudo apt-get install -y jenkins

    sudo systemctl start jenkins
    sudo systemctl enable jenkins
    echo "Checking Jenkins status..."
    sudo systemctl status jenkins
}

# Execute the Jenkins installation function
install_jenkins


