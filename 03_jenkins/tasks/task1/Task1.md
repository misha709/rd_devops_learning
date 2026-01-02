
#### [Back to Readme](../../Readme.md)

## Task 1: Deploy Jenkins

### Step 1
Fork the GitHub project to your personal account - https://github.com/spring-guides/gs-spring-boot


### Step 2
 - Create a working directory with a docker-compose.yml file.
 - Copy the following code to docker-compose.yml:
```yaml
services:
  jenkins-docker:
    image: docker:dind
    container_name: jenkins-docker
    privileged: true
    environment:
      - DOCKER_TLS_CERTDIR=/certs
    networks:
      jenkins:
        aliases:
          - docker
    volumes:
      - jenkins-docker-certs:/certs/client
      - jenkins-data:/var/jenkins_home
    ports:
      - "2376:2376"
    command: ["--storage-driver", "overlay2"]

  jenkins:
    image: jenkins/jenkins:latest
    container_name: jenkins
    restart: on-failure
    environment:
      - DOCKER_HOST=tcp://docker:2376
      - DOCKER_CERT_PATH=/certs/client
      - DOCKER_TLS_VERIFY=1
    networks:
      - jenkins
    ports:
      - "8080:8080"
      - "50000:50000"
    volumes:
      - jenkins-data:/var/jenkins_home
      - jenkins-docker-certs:/certs/client:ro
    depends_on:
      - jenkins-docker

volumes:
  jenkins-docker-certs:
  jenkins-data:
networks:
  jenkins:
    driver: bridge
```

### Step 3
- Run Docker (assuming it's already installed)
- Inside the working directory (where docker-compose.yml is located), open a terminal and run the following command:
`docker-compose up -d`
- Run the `docker ps` command to verify that 2 containers are running and healthy. The result should be similar to the image below:
  ![Docker PS Result](images/docker_ps_result.png)

### Step 4
- Open a browser and go to http://localhost:8080/
 ![Jenkins Login](images/jenkins_login.png)
- To get the password, open a terminal and run the following command:
 `docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword`
- Enter the password in the "Administrator password" field and install the suggested plugins
- Set your username and password
- After completing all steps, you should see the home screen:
  ![Jenkins Home](images/jenkins_home.png)