# Average-terraform-project

![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white) ![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white) ![Nginx](https://img.shields.io/badge/nginx-%23009639.svg?style=for-the-badge&logo=nginx&logoColor=white)

This project uses Terraform and Docker to create a cluster of web servers and a load balancer for round-robin load balancing. The web servers serve a static page that displays a message "**Hello from web-server (1..X)**". The project also includes a health endpoint on both the web servers and load balancer that returns the name of the component. The project supports setting different versions for the web servers and load balancer.

### Installation

#### Fully automatic installation

1. Download and run the script `fullauto.sh`  by running the command `curl https://raw.githubusercontent.com/wondersalmon/average-terraform-project/main/scripts/fullauto.sh >> fullauto.sh && chmod +x fullauto.sh && ./fullauto.sh` in the terminal.
2. The script will check if Terraform is installed, and if not, it will install it based on your package manager.
3. The script will then download the project, go to the project folder, initialize Terraform, and display a menu for working with the project.

Then the script will download the project, go to the folder with the project and initialize the terraform, and displays the menu for working with the project.

#### Semi-automatic installation

1. Run the script `manager.sh` by running the command`curl https://raw.githubusercontent.com/wondersalmon/average-terraform-project/main/scripts/manage.sh >> manage.sh && chmod +x manage.sh && ./manage.sh` in the terminal.
2. The script will download the project, initialize Terraform, and display a menu for working with the project.

#### Manual install

1. Clone the repository by running the command `git clone https://github.com/wondersalmon/average-terraform-project.git` in the terminal.
2. Navigate to the project folder `cd average-terraform-project/terraform`
3. Initialize Terraform by running the command `terraform init`

#### Working with the cluster

The cluster can be managed using the following Terraform commands:

- To launch the cluster, run the command `terraform apply`.
- To launch the cluster with custom parameters, run the command `terraform apply -var "webservers_count=$webservers_count" -var "webserver_version=$webserver_version" -var "loadbalancer_version=$loadbalancer_version"` (specify custom parameters instead of variable values).
- To delete the cluster, run the command `terraform destroy`.
- To check the status of the cluster, run the command `curl -s localhost:8080/health`.

### Cluster manager overview

In addition to manual management, the project includes a Cluster Manager that allows you to start, stop, and check the status of the cluster. The Cluster Manager can be accessed by running the script `manager.sh` after the project has been installed.

Note: `fullauto.sh` script will install Terraform, download the project and run `manager.sh` script.

### Conclusion

This project provides a convenient and straightforward way to set up a cluster of web servers and a load balancer using Terraform and Docker. The project also includes a health endpoint and support for different versions of the web servers and load balancer. The Cluster Manager also makes it easy to start, stop, and check the status of cluster.
