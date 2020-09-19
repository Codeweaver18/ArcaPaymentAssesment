
#perequisite
sudo apt-get update
sudo apt-get install docker
    sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get install docker-ce docker-ce-cli containerd.io


#Pull Docker Images
docker pull kibana:6.4.2
docker pull nginx
docker pull mysql

#creating Docker Network

docker network create ArcaNetwork

#Creating containers 

docker run -d --name ContainerA  -p 5601:5601 kibana:6.4.2
docker run --name ContainerC --net ArcaNetwork  -p 3306:3306 -e MYSQL_ROOT_PASSWORD=ArcaPayment -d mysql:latest
docker run -it --rm -d -p 8080:80 --name ContainerB nginx --net ArcaNetwork


#Inspecting ArcaNetwork to confirm Container Association
Docker network inspect ArcaNetwork


#Pinging Containers (containerA, ContainerB, ContainerC)
docker exec -ti  containerA ping ContainerB
docker exec -ti  containerA ping ContainerC
