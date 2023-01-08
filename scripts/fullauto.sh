#!/bin/bash
# Check if Terraform is already installed
if command -v terraform > /dev/null; then
  echo "Terraform is already installed"
 else

# Check if package manager is available
if command -v apt-get > /dev/null; then
  # Install Terraform using apt-get
  echo "Ubuntu/Debian-based distrib detected. Installation is being done using apt"
  sleep 1s
  wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
  sudo apt update && sudo apt install terraform
elif command -v dnf > /dev/null; then
  # Install Terraform using dnf
  echo "Fedora-based distrib detected. Installation is being done using dnf"
  sleep 1s
  sudo dnf install -y dnf-plugins-core
  sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo
  sudo dnf -y install terraform
elif command -v yum > /dev/null; then
  # Install Terraform using yum
  echo "CentOS/RHEL-based distrib detected. Installation is being done using yum"
  sleep 1s
  sudo yum install -y yum-utils
  sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
  sudo yum -y install terraform
elif command -v pacman > /dev/null; then
  # Install Terraform using pacman
  echo "Arch-based distrib detected. Installation is being done using pacman"
  sleep 1s
  sudo pacman -S terraform
elif command -v brew > /dev/null; then
  # Install Terraform using Homebrew
  echo "Homebrew detected. Installation is being done using brew"
  sleep 1s
  brew tap hashicorp/tap
  brew install hashicorp/tap/terraform
	fi
fi
sleep 1s
echo -e "\033[0;32mGetting started with the project\033[0m"
sleep 2s
################ Git pull & terraform init #################
echo -e "\e[1m\e[34mCloning repository...\e[0m"
git clone https://github.com/wondersalmon/average-terraform-project.git

echo -e "\e[1m\e[34mEntering repository folder...\e[0m"
cd average-terraform-project/terraform

echo -e "\e[1m\e[32mInitializing Terraform...\e[0m"
terraform init

sleep 1s
echo
echo -e "\e[1m\e[36mTerraform ready to work!\e[0m"
echo "----------------------------------------"
####################### Magic of bash ###########################
function start_cluster() {
if [ -z "$webserver_version" ]; then
webserver_version=latest
fi
if [ -z "$loadbalancer_version" ]; then
loadbalancer_version=latest
fi
if [ -z "$webservers_count" ]; then
webservers_count=3
fi
terraform apply -var "webservers_count=$webservers_count" -var "webserver_version=$webserver_version" -var "loadbalancer_version=$loadbalancer_version"
if [ $? -eq 0 ]; then
echo -e "\033[0;32m[OK]\033[0m Cluster started successfully (づ｡◕‿‿◕｡)づ"
else
echo -e "\033[0;31m[ERROR]\033[0m Error starting cluster ༼ つ ◕_◕ ༽つ"
exit 1
fi
}

function stop_cluster() {
  terraform destroy
  if [ $? -eq 0 ]; then
    echo -e "\033[0;32m[OK]\033[0m Cluster stopped successfully ( ͡° ͜ʖ ͡°)"
  else
    echo -e "\033[0;31m[ERROR]\033[0m Error stopping cluster ಠ_ಥ"
    exit 1
  fi
}

function status_cluster() {
  if curl -s localhost:8080/health > /dev/null; then
    echo -e "\033[0;32m[OK]\033[0m Load balancer is healthy, cluster status: \033[0;32mGREEN\033[0m (⌐■_■)"
  else
    echo -e "\033[0;31m[ERROR]\033[0m Load balancer is unhealthy, cluster status: \033[0;31mRED\033[0m ╚(ಠ_ಠ)=┐"
  fi
}

############################ Wonders of choice ##################################
echo -e "\033[1mChoose Your Destiny:\033[0m "
select option in "Start cluster" "Stop cluster" "Check status" "Quit"; do
  case $option in
    "Start cluster")
       echo -e "Enter the \033[1mwebserver version\033[0m (leave blank for default version):"
      read webserver_version
      echo -e "Enter the \033[1mloadbalancer version\033[0m (leave blank for default version):"
      read loadbalancer_version
      echo -e "Enter the \033[1mnumber of webservers\033[0m: (3 by default)"
      read webservers_count
      start_cluster $webserver_version $loadbalancer_version $webservers_count
      break
      ;;
    "Stop cluster")
      stop_cluster
      break
      ;;
    "Check status")
      status_cluster
      break
      ;;
    "Quit")
      echo -e "\033[95mSee ya\033[0m♥‿♥"
      break
      ;;
    *)
      echo -e "\033[31m Invalid option\033[0m"
      ;;
  esac
done
