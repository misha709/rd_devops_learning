FROM jenkins/jenkins:lts

USER root
RUN apt-get update \
 && apt-get install -y --no-install-recommends wget ca-certificates \
 && wget https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
 && dpkg -i packages-microsoft-prod.deb \
 && rm packages-microsoft-prod.deb \
 && apt-get update \
 && apt-get install -y --no-install-recommends dotnet-sdk-10.0 \
 && rm -rf /var/lib/apt/lists/*
USER jenkins
