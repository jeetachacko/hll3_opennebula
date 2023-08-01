sudo sed -i "/#\$nrconf{restart} = 'i';/s/.*/\$nrconf{restart} = 'a';/" /etc/needrestart/needrestart.conf

sudo apt update

#Install docker compose

sudo curl -L https://github.com/docker/compose/releases/download/1.28.5/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version

#Install Go

curl -O https://storage.googleapis.com/golang/go1.19.linux-amd64.tar.gz
sha256sum go1.19.linux-amd64.tar.gz
tar -xvf go1.19.linux-amd64.tar.gz
sudo mv go /usr/local

echo "export GOPATH=$HOME/go" >> ~/.profile
echo "export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin" >> ~/.profile
echo "export GOPATH=$HOME/go" >> ~/.bashrc
echo "export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin" >> ~/.bashrc

source ~/.bashrc
source ~/.profile


sudo apt-get install build-essential openssl libssl-dev pkg-config

