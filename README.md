# Dart_Flutter_Cookbooks

### 🚀 Project Initiative

A project developed in Flutter and Dart to demonstrate knowledge.

## ❤️ Contribution

Contributions are welcome! To contribute, favorite the project and give your opinion about it!

## 🐬 Improve the Project.

Help improve the project! Fork it and develop your creativity!

>https://github.com/KauaHenSilva/dart_docker_redis_back_end


## 📋 Prerequisites (Installation Docker) (Linux)

The project was developed in the Ubuntu environment, so the commands may vary according to the operating system. The project uses the following dependencies: 

### Docker
  
  ```bash
  $ sudo apt-get -y install docker
  ```


## 📋 Prerequisites (Installation Local) (Linux)

The project was developed in the Ubuntu environment, so the commands may vary according to the operating system. The project uses the following dependencies: 


### Dart
  
  ```bash
  $ sudo apt-get update && sudo apt-get install apt-transport-https
  $ wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo gpg  --dearmor -o /usr/share/keyrings/dart.gpg
  $ echo 'deb [signed-by=/usr/share/keyrings/dart.gpg arch=amd64] https://storage.googleapis.com/download.dartlang.org/linux/debian stable main'  | sudo tee /etc/apt/sources.list.d/dart_stable.list
  $ sudo apt-get -y install dart
  $ sudo apt-get update && sudo apt-get install dart

  ```

# Running the sample

## Running with the Dart SDK

You can run the example with the [Dart SDK](https://dart.dev/get-dart)
like this:

1. **Clone this repository:**

  ```bash
  $ git clone https://github.com/KauaHenSilva/dart_docker_redis_back_end
  ```

2. **Navigate to the project directory:**

  ```bash
  $ cd dart_docker_redis_back_end
  ```

3. **Run project:**

  ```
  $ dart run bin/server.dart
  Server listening on port 8080
  ```

4. **Test:**

  And then from a second terminal:
  ```
  $ curl http://0.0.0.0:8080/clientes
  []
  ```

You should see the logging printed in the first terminal:
```
2021-05-06T15:47:08.392928  0:00:00.001216 GET     [200] /clientes
```


## Running with Docker

If you have [Docker Desktop](https://www.docker.com/get-started) installed, you
can build and run with the `docker` command:

1. **Clone this repository:**

  ```bash
  $ git clone https://github.com/KauaHenSilva/dart_docker_redis_back_end
  ```

2. **Navigate to the project directory:**

  ```bash
  $ cd dart_docker_redis_back_end
  ```

3. **Run project:**

  ```
  $ docker build . -t myserver
  $ docker run -it -p 8080:8080 myserver
  Server listening on port 8080
  ```

4. **Test:**
  ```
  $ curl http://0.0.0.0:8080/clientes
  []
  ```

You should see the logging printed in the first terminal:
```
2021-05-06T15:47:08.392928  0:00:00.001216 GET     [200] /clientes
```

## Running with Docker Compose

If you have [Docker Desktop](https://www.docker.com/get-started) installed, you
can build and run with the `docker` command:

1. **Clone this repository:**

  ```bash
  $ git clone https://github.com/KauaHenSilva/dart_docker_redis_back_end
  ```

2. **Navigate to the project directory:**
  ```bash
  $ cd dart_docker_redis_back_end
  ```

3. **Run project:**
  ```
  $ docker-compose up
  Server listening on port 8080
  ```

4. **Test:**
  ```
  $ curl http://0.0.0.0:8080/clientes
  []
  ```

You should see the logging printed in the first terminal:
```
2021-05-06T15:47:08.392928  0:00:00.001216 GET     [200] /clientes
```

## Running with Docker Swarm

If you have [Docker Desktop](https://www.docker.com/get-started) installed, you
can build and run with the `docker` command:

1. **Clone this repository:**

  ```bash
  $ git clone https://github.com/KauaHenSilva/dart_docker_redis_back_end
  ```

2. **Navigate to the project directory:**

  ```bash
  $ cd dart_docker_redis_back_end
  ```

3. **Run project:**
  ```
  $ docker swarm init
  $ docker stack deploy --compose-file docker-stack.yml <name-project>
  
  ```
4. **Test:**
  ```
  $ curl http://0.0.0.0:8080/clientes
  []
  ```

