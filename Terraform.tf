provider "aws" {
region = "us-east-2"
shared_credentials_file = "~/.aws."
profile = "CodeweaverNG"
}

resource "aws_key_pair" "terraform-demo" {
  key_name   = "terraform-demo"
  public_key = "${file("terraform-demo.pub")}"
}


resource "aws_instance" "web" {
  ami           = "ami-0e82959d4ed12de3f"
  instance_type = "t3.micro"
  key_name = "${aws_key_pair.terraform-demo.key_name}"
  user_data = <<EOF
  #! /bin/bash
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
    sudo systemctl start docker
    sudo systemctl enable docker
    #Pull Docker Images
    sudo docker pull kibana:6.4.2
    sudo docker pull nginx
    sudo docker pull mysql
    #creating Docker Network
    sudo docker network create ArcaNetwork
        #Creating containers 
       sudo docker run -d --name ContainerA  -p 5601:5601 kibana:6.4.2
        sudo docker run --name ContainerC --net ArcaNetwork -e MYSQL_ROOT_PASSWORD=ArcaPayment -d mysql:latest
        sudo docker run -it --rm -d -p 8080:80 --name ContainerB nginx --net ArcaNetwork
        #Inspecting ArcaNetwork to confirm Container Association
        sudo Docker network inspect ArcaNetwork
        #Pinging Containers (containerA, ContainerB, ContainerC)
        sudo docker exec -ti  containerA ping ContainerB
        sudo docker exec -ti  containerA ping ContainerC
  EOF
  tags = {
    Name = "Ubuntu Instance created by Terraform"
  }
}