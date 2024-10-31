#!/bin/bash

install_sonarqube() {
    # Define the SonarQube version and download URL for Free Community Edition
    local SONARQUBE_VERSION="10.0.0.68432"  # LTS version
    local SONARQUBE_URL="https://binaries.sonarsource.com/CommercialDistribution/sonarqube-enterprise/sonarqube-enterprise-${SONARQUBE_VERSION}.zip"

    local DOWNLOAD_DIR="/tmp/sonarqube.zip"
    local INSTALL_DIR="/opt/sonarqube-${SONARQUBE_VERSION}"

    # Update package index and install necessary packages (including Java 17, required for SonarQube)
    echo "Updating package index and installing required packages..."
    sudo apt-get update
    sudo apt-get install -f
    sudo apt-get install -y unzip openjdk-17-jdk openjdk-17-jre

    # Create a dedicated user for SonarQube
    echo "Creating a dedicated user for SonarQube..."
    sudo useradd -r -s /bin/false sonar

    # Download SonarQube Free Community Edition
    echo "Downloading SonarQube..."
    wget ${SONARQUBE_URL} -O ${DOWNLOAD_DIR}

    # Check if the download was successful
    if [[ $? -ne 0 ]]; then
        echo "Failed to download SonarQube from ${SONARQUBE_URL}. Exiting."
        exit 1
    fi

    # Unzip the downloaded file
    echo "Unzipping SonarQube..."
    sudo unzip ${DOWNLOAD_DIR} -d /opt/

    # Move the SonarQube directory to the desired installation path
    sudo mv /opt/sonarqube-${SONARQUBE_VERSION} ${INSTALL_DIR}

    # Change ownership of the SonarQube directory
    echo "Changing ownership of the SonarQube directory..."
    sudo chown -R sonar:sonar ${INSTALL_DIR}

    # Set required system limits (per SonarQube documentation)
    echo "Configuring system limits for SonarQube..."
    sudo sysctl -w vm.max_map_count=524288
    sudo sysctl -w fs.file-max=131072
    sudo ulimit -n 131072
    sudo ulimit -u 8192

    # Ensure these changes are persistent across reboots
    echo "vm.max_map_count=524288" | sudo tee -a /etc/sysctl.conf
    echo "fs.file-max=131072" | sudo tee -a /etc/sysctl.conf

    echo "sonar   -   nofile   131072" | sudo tee -a /etc/security/limits.conf
    echo "sonar   -   nproc    8192" | sudo tee -a /etc/security/limits.conf

    # Create a systemd service file for SonarQube
    echo "Creating systemd service file..."
    cat <<EOL | sudo tee /etc/systemd/system/sonarqube.service
[Unit]
Description=SonarQube service
After=network.target

[Service]
Type=simple
User=sonar
Group=sonar
ExecStart=${INSTALL_DIR}/bin/linux-x86-64/sonar.sh start
ExecStop=${INSTALL_DIR}/bin/linux-x86-64/sonar.sh stop
LimitNOFILE=131072
LimitNPROC=8192
Restart=always

[Install]
WantedBy=multi-user.target
EOL

    # Reload systemd to recognize the new service
    sudo systemctl daemon-reload

    # Start and enable the SonarQube service
    echo "Starting and enabling SonarQube service..."
    sudo systemctl start sonarqube
    sudo systemctl enable sonarqube

    # Clean up
    echo "Cleaning up downloaded files..."
    rm ${DOWNLOAD_DIR}

    # Print access instructions
    local IP_ADDRESS=$(hostname -I | awk '{print $1}')
    echo "SonarQube installation is complete!"
    echo "You can access SonarQube at http://$IP_ADDRESS:9000"
}

# Call the function to install SonarQube
install_sonarqube

