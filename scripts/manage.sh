# Processing the repository, initializing the terraform
echo -e "\e[1m\e[34mCloning repository...\e[0m"
git clone https://github.com/wondersalmon/terraform-webcluster.git
echo -e "\e[1m\e[34mEntering repository folder...\e[0m"
cd terraform-webcluster/terraform
echo -e "\e[1m\e[32mInitializing Terraform...\e[0m"
terraform init
echo
echo -e "\e[1m\e[36mTerraform ready to work!\e[0m"
echo "----------------------------------------"
# Starting the Project Manager
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
echo -e "\033[0;32m[OK]\033[0m Cluster started successfully"
else
echo -e "\033[0;31m[ERROR]\033[0m Error starting cluster"
exit 1
fi
}
function stop_cluster() {
  terraform destroy
  if [ $? -eq 0 ]; then
    echo -e "\033[0;32m[OK]\033[0m Cluster stopped successfully"
  else
    echo -e "\033[0;31m[ERROR]\033[0m Error stopping cluster"
    exit 1
  fi
}
function status_cluster() {
  if curl -s localhost:8080/health > /dev/null; then
    echo -e "\033[0;32m[OK]\033[0m Load balancer is healthy, cluster status: \033[0;32mGREEN\033[0m "
  else
    echo -e "\033[0;31m[ERROR]\033[0m Load balancer is unhealthy, cluster status: \033[0;31mRED\033[0m "
  fi
}
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
      echo -e "\033[95mSee ya\033[0m"
      break
      ;;
    *)
      echo -e "\033[31m Invalid option\033[0m"
      ;;
  esac
done