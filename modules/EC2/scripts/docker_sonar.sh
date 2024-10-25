#!/bin/bash
set -e  # Exit on any error



# Create Docker network
echo "Creating Docker network 'sonarnet'..."
sudo docker network create sonarnet

# Run PostgreSQL container
echo "Running PostgreSQL container for SonarQube..."
sudo docker run -d --name sonarqube_db \
  --network sonarnet \
  -e POSTGRES_USER=sonar \
  -e POSTGRES_PASSWORD=sonar \
  -e POSTGRES_DB=sonarqube \
  postgres:13

# Run SonarQube container
echo "Running SonarQube container..."
sudo docker run -d --name sonarqube \
  --network sonarnet \
  -p 9000:9000 \
  -e SONAR_JDBC_URL=jdbc:postgresql://sonarqube_db:5432/sonarqube \
  -e SONAR_JDBC_USERNAME=sonar \
  -e SONAR_JDBC_PASSWORD=sonar \
  sonarqube:community

echo "SonarQube setup complete. Access SonarQube at http://<your-server-ip>:9000"
