# ----------------------------------
# Pterodactyl Core Dockerfile
# Environment: Mono
# Minimum Panel Version: 0.6.0
# ----------------------------------
FROM        mono:6

LABEL       author="Julian LADJANI" maintainer="julian.ladjani@outlook.com"

RUN         useradd -d /home/container -m container \
            && apt update \
            && apt install -y iproute2 ca-certificates unzip sqlite fontconfig \
            && apt-get -y install unzip && apt-get -y install wget && apt-get -y install curl \
            && wget -q https://packages.microsoft.com/config/ubuntu/19.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
            && dpkg -i packages-microsoft-prod.deb && rm packages-microsoft-prod.deb \
            && apt-get -y update \
            && apt-get -y install apt-transport-https \
            && apt-get -y update \
            && apt-get -y install dotnet-sdk-3.1

USER        container
ENV         HOME=/home/container USER=container
WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         ["/bin/bash", "/entrypoint.sh"]
