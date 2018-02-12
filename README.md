# CTFd - Docker version

This project is a practice for using docker, thus I recommend to use official docker version for better logs and debugging.

### Host Environment

  - docker version: Docker for Windows, 17.12.0-ce
  - docker-compose version: 1.18.0, build 8dd22a96
  - Windows 10 Pro, Hyper-V Emulator
  
If your OS is Windows below Win 10(Win7, Win8, Win10 Home Edition), then you should use "Docker Toolbox" instead.
The difference between "Docker for Windows" and "Docker Toolbox" just a few points:

  |                 | Docker for Windows |  Docker Toolbox  | 
  | --------------- | ------------------ |  --------------  |
  | Virtual Machine |      Hyper-V       |    Virtual Box   |
  | Docker Tech     |      MobyLinux     |    Boot2Docker   |
  | Dev host        |      localhost     |    192.168.x.x   |

### CTFd Environment
  - Official Flask CTFd project - https://github.com/CTFd/CTFd
  - python 2.7 with debian-jessie version(it's big, but still smaller than ubuntu), official version(linux alpine) is lighter but more complicated(about libraries)
  - uWSGI backend webserver with 'TCP' socket connect to nginx frontend webserver, 'Unix-protocol' socket cannot communicate between different containers.

### Starts up

First, rename the 'example' infix files
```sh
cp docker-compose.example.yml docker-compose.yml
cp .env.example .env
```

Build the image, and up the containers.
```sh
$ docker-compose up
```
Verify the deployment by navigating to your server address in your preferred browser.
```sh
Hyper-V: 127.0.0.1:4000
Virtual Box: 192.168.x:x:4000
```

### Docker-compose command
Besides line command, docker-compose tool makes Docker powerful!
If your OS is linux system, then you need to install docker-compose by you own.
##### docker-compose build
Only build the image
```sh
$ docker-compose build
```
##### docker-compose up
Up all images to containers in basic mode, which all logs would show
```sh
$ docker-compose up
```
Up all or specific images to containers in a daemon mode
```sh
$ docker-compose up -d [image]
```
Up all images to containers with rebuilding
```sh
$ docker-compose up --build
```
##### docker-compose down
Stop containers and removing them
```sh
$ docker-compose down
```

### Hey, removing containers is easy, but how about the data in database?
> There is a function called "volume", which we usually call it as persistence data, with setting it in a right way, all db data would not loss until we delete the volume.

##### Volume can be used in two ways
- some-tag:/path/to/db/data
- /host/path/to/data:/container/path/to/data
The second way is also called "Bind Mount"

Notice, docker-compose is not suitable for production(not recommended) because of some security problems.
But when learning and practicing docker, you can use it for convenience.

### Docker Command(common use)

##### docker run
Creates a new container of a image, '-it' means to interactive with this container, '--rm ' means remove this container after exiting the interaction, then bash or sh is the way that you would use for interaction
```sh
docker run -it --rm [image_name|image_name] [bash|sh]
```
##### docker exec
Usually with -it, means to interactive with an existing container(go inside the container), bash or sh is the way that you would use for interaction
```sh
docker exec -it [container_name|container_id] [bash|sh]
```
##### docker stop
Stops a container
```sh
docker stop [container_name|container_id]
```
##### docker rm
Removes a container, must stop first
```sh
docker rm [container_name|container_id]
```
##### docker start
Starts a stopped container
```sh
docker start [container_name|container_id]
```
##### docker ps
Shows running containers, with '-a' show all containers(running and stopped)
```sh
docker ps -a [container_name|container_id]
```
##### docker logs
Shows logs of speficic container, especially useful when debugging 
```sh
docker logs [container_name|container_id]
```

### Essential Files

A docker project uses a tile of config files to work properly:
* [Dockerfile] - A basic config file use Uppercase-form-command 'FROM', 'RUN', 'COPY', 'EXPOSE', 'ENTRYPOINT', ...etc; It can be prefixed by a string then can be referenced by docker-compose, here I add a 'CTFd'.
* [docker-compose.yml] - 'docker-compose' is an essential tool in docker development, this config file has various of version(3.X is the latest); in 2.x version, a useful 'healthycheck' of containers is great. Like a dockerfile as mentioned above, there are many basic commands in lowercase which should be more clearly; besides, you can define many containers in just one docker-compose.yml file with all dependencies.
* [docker-entrypoint.sh] - 'entrypoint' is a command which would be executed when the container with it starts
* [.env] - A file with some external environmental variables, can be used with ${variable} in docker-compose.yml
* [server/nginx.conf] - custom nginx.conf, it would overwrite the default one in image.
* [server/uwsgi.ini] - custom uwsgi.ini, essential uwsgi settings locate here.

### Todos

 - Make the image smaller, official is less than 400MB, this is about 900MB
 - Add cluster mode with K8S or docker swarm, on GCP or AWS

License
----

MIT


**Free Software, Hell Yeah!**

[//]: # (These are reference links used in the body of this note and get stripped out when the markdown processor does its job. There is no need to format nicely because it shouldn't be seen. Thanks SO - http://stackoverflow.com/questions/4823468/store-comments-in-markdown-syntax)


   [docker-entrypoint.sh]: <https://github.com/David-Tsui/CTFd_docker/blob/master/docker-entrypoint.sh>
   [Dockerfile]: <https://github.com/David-Tsui/CTFd_docker/blob/master/CTFd.Dockerfile>
   [docker-compose.yml]: <https://github.com/David-Tsui/CTFd_docker/blob/master/docker-compose.example.yml>
   [.env]: <https://github.com/David-Tsui/CTFd_docker/blob/master/.env.example>
   [server/nginx.conf]: <https://github.com/markdown-it/markdown-it>
   [server/uwsgi.ini]: <http://ace.ajax.org>
   
