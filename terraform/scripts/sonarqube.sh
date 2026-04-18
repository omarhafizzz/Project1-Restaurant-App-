#!/bin/bash
set -e
exec > /var/log/user-data.log 2>&1

echo "========== [1/4] System Update =========="
apt-get update -y
apt-get upgrade -y
apt-get install -y \
  curl wget \
  apt-transport-https \
  ca-certificates \
  gnupg

echo "========== [2/4] System Tuning =========="
sysctl -w vm.max_map_count=524288
sysctl -w fs.file-max=131072

cat >> /etc/sysctl.conf <<EOF
vm.max_map_count=524288
fs.file-max=131072
EOF

echo "========== [3/4] Install Docker =========="
apt-get remove -y docker docker-engine docker.io containerd runc 2>/dev/null || true

# حذف أي key قديم
rm -f /usr/share/keyrings/docker-archive-keyring.gpg
rm -f /etc/apt/sources.list.d/docker.list

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
  https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update -y
apt-get install -y \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-compose-plugin

systemctl enable docker
systemctl start docker
usermod -aG docker ubuntu

# انتظر Docker يبقى جاهز
sleep 10

echo "========== [4/4] Run SonarQube + PostgreSQL =========="
mkdir -p /opt/sonarqube

cat > /opt/sonarqube/docker-compose.yml <<'COMPOSE'
version: "3"

services:
  sonarqube:
    image: sonarqube:lts-community
    container_name: sonarqube
    restart: always
    depends_on:
      db:
        condition: service_healthy
    environment:
      SONAR_JDBC_URL: jdbc:postgresql://db:5432/sonarqube
      SONAR_JDBC_USERNAME: sonarqube
      SONAR_JDBC_PASSWORD: sonarqube123
    ports:
      - "9000:9000"
    volumes:
      - sonarqube_data:/opt/sonarqube/data
      - sonarqube_logs:/opt/sonarqube/logs
      - sonarqube_extensions:/opt/sonarqube/extensions
    ulimits:
      nofile:
        soft: 65536
        hard: 65536

  db:
    image: postgres:15
    container_name: sonarqube-db
    restart: always
    environment:
      POSTGRES_USER: sonarqube
      POSTGRES_PASSWORD: sonarqube123
      POSTGRES_DB: sonarqube
    volumes:
      - postgresql_data:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U sonarqube"]
      interval: 10s
      timeout: 5s
      retries: 5

volumes:
  sonarqube_data:
  sonarqube_logs:
  sonarqube_extensions:
  postgresql_data:
COMPOSE

docker compose -f /opt/sonarqube/docker-compose.yml up -d

echo "Waiting for SonarQube (~2 min)..."
sleep 60
COUNT=0
until curl -s http://localhost:9000/api/system/status | grep -q '"status":"UP"'; do
    echo "SonarQube not ready... ($COUNT)"
    sleep 15
    COUNT=$((COUNT+1))
    if [ $COUNT -gt 20 ]; then
        echo "SonarQube timeout - check: docker logs sonarqube"
        break
    fi
done

echo "========== ✅ Verify =========="
docker ps
curl -s http://localhost:9000/api/system/status

echo "✅ SonarQube Setup Complete!"
echo "URL    : http://$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4):9000"
echo "Default: admin / admin"