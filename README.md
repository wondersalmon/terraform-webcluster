# Average-terraform-project
*Project files will be uploaded as they are ready.*

![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white) ![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white) ![Nginx](https://img.shields.io/badge/nginx-%23009639.svg?style=for-the-badge&logo=nginx&logoColor=white)
### Task:
 This exercise should be performed locally using Terraform and Docker. Using Terraform and any docker provider, create the following cluster:
> 1. Run X web-servers that serves a single static page with a message: Hello from web-server (1..X)
> 2. Run a load-balancer in front of the web-servers that performs round-robin load balancing
> 3. On both web-servers and load-balancer, add a health endpoint returning the name of the component (web-server-(1..X) / load-balancer).
> 4. Create support for setting different versions for the web-server and load-balancer
> 5. Write a shell script for install(using git pull from GitHub)/start/stop/status of the cluster

### Preparation:
#### Make sure you have docker and curl installed on your computer, install them if needed.

You can check the installation in the terminal with the commands `docker --version` for docker and `curl --version` for curl. 
If the programs are installed - the terminal will tell you the version of the program, if not - it will report an error



### Installation:
#### Fully automatic installation:
Download and run the script `fullauto.sh` (command `./fullauto.sh` in the terminal).

The script will check if terraform is installed, and if not, it will install itself depending on your package manager.

Then the script will download the project, go to the folder with the project and initialize the terraform, and displays the menu for working with the project.
#### Semi-automatic installation:
Run the script `manager.sh` using `./manager.sh` command if you are sure that terraform is already installed on your computer.

In this script, the terraform installation functionality has been cut out - it only downloads the project, initializes the terraform and displays the menu for working with the project.

Scripts are located in the scripts folder. You can download and run them manually or use a terminal command to download and run the script immediately.

Command to run the automatic installation: 

`curl https://raw.githubusercontent.com/wondersalmon/average-terraform-project/main/scripts/fullauto.sh >> fullauto.sh && chmod +x fullauto.sh && ./fullauto.sh`

Command to start semi-automatic installation: 

`curl https://raw.githubusercontent.com/wondersalmon/average-terraform-project/main/scripts/manage.sh >> manage.sh && chmod +x manage.sh && ./manage.sh`

#### Manual install:
1. Copy git clone repository `https://github.com/wondersalmon/average-terraform-project.git`

2. Go to the project folder `cd average-terraform-project/terraform`

3. Run command `terraform init`

##### Working with the cluster manually:
<details><summary>Command List:</summary>

   - Launching a cluster - `terraform apply`

   - Launching a cluster with custom parameters `terraform apply -var "webservers_count=$webservers_count" -var "webserver_version=$webserver_version" -var "loadbalancer_version=$loadbalancer_version"`
(Specify custom parameters instead of variable values)
   - Deleting a cluster of `terraform destroy`
   - Check status `curl -s localhost:5000/health`

</details>

### Cluster manager overview:
1.`Start Cluster` allows you to start a cluster with custom parameters (version of the web server and load balancer and number of web servers) or (if no parameters have been entered) starts the cluster with default parameters.

The servers are using the `NGINX` image. **Use Dockertags to specify the version** (you can find a list of possible tags in [Dockerhub](https://hub.docker.com/_/nginx)).

2.`Stop cluster` destroy the cluster by `terraform destroy`.

3.`Check status` displays the balancer's health status.
### Testing:
You can check the work of the balancer and health endpoints with commands in the terminal
```bash
    curl localhost:8080
    curl localhost:8080/health
    curl localhost:700X # Where X is the webserver number
    curl localhost:700X/health # Where X is the webserver number
```
