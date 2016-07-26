###############################################################################
# Installation & Reference
# https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/
# https://linuxconfig.org/how-to-share-data-between-a-docker-container-and-host-system-using-volumes
# https://docs.docker.com/machine/install-machine/

###############################################################################
# RUNNING COMMANDS
# docker build -t loitd/ubuntubase
# docker push loitd/ubuntubase
# docker run -p 5000:5000 -p 28017:27017 -v $PWD/app:/app -it --rm loitd/ubuntubase
## run the mongod on docker
# screen -S mongodb
# /usr/bin/mongod

# from a repo. Recommend debian
FROM loitd/ubuntubase:latest
# set env
ENV abc=hello
MAINTAINER Loitd Name <"loitranduc@gmail.com">
#RUN apt-get update -y && apt-get install -y python-pip python-dev build-essential vim curl wget python3.5 lsb-release telnet screen
RUN apt-get install -y vim curl wget python3.5 lsb-release telnet screen 

###############################################################################
# Install MongoDB
#Step 1:  Import the MongoDB public key 
#RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10

#Step 2: Generate a file with the MongoDB repository url
# to install mongodb 3.0
#RUN echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb.list
# To install mongodb 2.6
#RUN echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/mongodb.list

#Step 3: Refresh the local database with the packages
#RUN apt-get update && apt-get install -y mongodb-org

#RUN mkdir -p /data/db

###############################################################################
# Expose some ports
# Even exposed, you still need to map ports for your local can reach the services.
# Expose port 27017 - MongoDB from the container to the host
EXPOSE 27017
# expose port 5000 for flask
EXPOSE 5000
# copy or add the same but copy is prefered. copy local files into the container
COPY . /app
# volume: to expose any storage, config, file/folders created by docker container.
# VOLUME ["/data"] 
VOLUME /root/dockerapp:/app
# set working dir
WORKDIR /app

###############################################################################
# Run some pip for python
RUN pip install --upgrade pip
RUN pip install -r requirements.txt
RUN pip install virtualenv
# set image main command. docker run python
#ENTRYPOINT ["python"]
# CMD ["exe", "param1", "param2"]
#CMD ["app.py"]
