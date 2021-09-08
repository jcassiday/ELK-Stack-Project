# ELK-Stack-Project

## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

https://gt.bootcampcontent.com/jcassiday/elk-stack-project/-/blob/main/Diagrams/NetworkTopology.png

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the YAML playbook files may be used to install only certain pieces of it, such as Filebeat.

    install-elk.yml
    metricbeat-playbook.yml
    filebeat-playbook.yml


This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application. The cloud enviroment has two web servers, load balancer, and jumpbox in the same resourse and security group. The web servers have an availability set with each other and no public IP because the load balancer will provide it. The load balancer has a backend pool with the web servers and a health probe. The Elk Stack will have its own zone and security group but have a peer-to-peer connection to the East zone.

Load balancing ensures that the application will be highly available, in addition to restricting requests to the network.
- What aspect of security do load balancers protect?
  Load balancers protect the web servers from DDOS attacks by redirecting networking traffic.
  Load balancers help ensure availability.
  
  What is the advantage of a jump box?
  The jump box provides a single node to access the systems so that no one can access the systems without going through the jump box. The jump box then can be monitored for any malicious activity.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the logs and system traffic.
- What does Filebeat watch for?
  Filebeat collects data about the file system.

- What does Metricbeat record?
  Metricbeat collects machine metrics, such as uptime.
 
The configuration details of each machine may be found below.
_Note: Use the [Markdown Table Generator](http://www.tablesgenerator.com/markdown_tables) to add/remove values from the table_.

| Name                 | Function      | IP Address   | Operating System                      |
|----------------------|---------------|--------------|---------------------------------------|
| Jump-Box-Provisioner | Gateway       | 10.0.0.4     | Linux (ubuntu 18.04)                  |
| Web-1                | DVWA          | 10.0.0.7     | Linux (ubuntu 18.04)                  |
| Web-2                | DVWA          | 10.0.0.6     | Linux (ubuntu 18.04)                  |
| Red-Team-LoadB       | Load Balancer | 40.76.66.171 | Backend pool(Name: Red-Team-back-end) |
| ELK-Stack            | ELK           | 10.1.0.4     | Linux (ubuntu 18.04)                  |


### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jump box machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- My Public IP Address: Personal

Machines within the network can only be accessed by SSH.
- Jump box: 168.62.167.112

A summary of the access policies in place can be found in the table below.

| Name                 | Publicly Accessible | Allowed IP Addresses                     |
|----------------------|---------------------|------------------------------------------|
| Jump-Box-Provisioner | Yes/No              | My Public IP                             |
| Web-1                | No                  | Docker Container on Jump-Box-Provisioner |
| Web-2                | No                  | Docker Container on Jump-Box-Provisioner |
| Red-Team-LoadB       | No                  | None                                     |
| ELK-Stack            | No                  | Docker Container on Jump-Box-Provisioner |


### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...
-  It allows user to install/configure multiple programs on multiple systems with a single command.

The playbook implements the following tasks:
  1. Install docker.io
  2. Install python3-pip
  3. Install Docker module
  4. Use more memory: sysctl -w vm.max_map_count="262144"
  5. download and launch a docker elk container

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

https://gt.bootcampcontent.com/jcassiday/elk-stack-project/-/blob/main/Diagrams/docker-ps.jpg

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
  1. 10.0.0.6
  2. 10.0.0.7

We have installed the following Beats on these machines:
  1. Filebeat
  2. Metricbeat

These Beats allow us to collect the following information from each machine:
- Filebeat is a lightweight shipper for forwarding and centralizing log data. Installed as an agent on your servers, Filebeat monitors the log files or locations that you specify, collects log events, and forwards them either to Elasticsearch or Logstash for indexing.

- Metricbeat is a lightweight shipper that you can install on your servers to periodically collect metrics from the operating system and from services running on the server.

### Setup ssh
ssh-keygen in Git-Bash on local computer 
cd into .ssh/id_rsa.pub(Your Public key) and copy and paste ssh key to Azure Jumpbox Password key
ssh -i .ssh/id_rsa azadmin@168.62.167.112
sudo apt install docker.io
sudo docker pull cyberxsecurity/ubuntu:bionic and cyberxsecurity/ansible
docker run -ti cyberxsecurity/ansible:latest bash to launch a ansible container and connect to its command line.
Do ssh-keygen, copy ssh Public key, and paste it to Azure Webservers Password key 

### Update Ansible files
Update the hosts file to include webserver IP's
    [webservers]
    #alpha.example.org
    #beta.example.org
    #192.168.1.100
    #192.168.1.110
    10.0.0.6 ansible_python_interpreter=/usr/bin/python3
    10.0.0.7 ansible_python_interpreter=/usr/bin/python3

    Update ansible.cfg file
    remote_user = azadmin

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned:

### For ELK Server

    Open command prompt in Git-Bash to establish ssh link to cloud enviroment
    ssh -i .ssh/id_rsa azadmin@168.62.167.112
    sudo docker container list -a (to see what is running)
    sudo docker start fervent_allen
    sudo docker attach fervent_allen
    cd /etc/ansible
    Copy the install-elk.yml file to /etc/ansible.
    Update the hosts file to include ELKServer IP
    
    10.0.0.7 ansible_python_interpreter=/usr/bin/python3

    [elk]
    <ELK-server_Private_IP> ansible_python_interpreter=/usr/bin/python3
    Run the playbook, and navigate to HTTP://20.98.74.199:5601 to check that the installation worked as expected.
    https://gt.bootcampcontent.com/jcassiday/elk-stack-project/-/blob/main/Diagrams/kibana-home.jpg   


### For Filebeat

    Open command prompt in Git-Bash to establish ssh link to cloud enviroment
    ssh -i .ssh/id_rsa azadmin@168.62.167.112
    sudo docker container list -a (to see what is running)
    sudo docker start fervent_allen
    sudo docker attach fervent_allen
    cd /etc/ansible
    Copy the install-filebeat.yml file to /etc/ansible.
    Copy the filebeat-config.yml in the /etc/ansible/files and Update the file(See below)
    **output.elasticsearch:**
    hosts: ["10.1.0.4:9200"]
    **setup.kibana:**
    host: "10.1.0.4:5601"
    Run the playbook, and navigate to HTTP://20.98.74.199:5601
    Click Add Log Data.
    Choose System Logs.
    Click on the DEB tab under Getting Started.
    On the same page, scroll to Step 5: Module Status and click Check Data.
    Scroll to the bottom of the page and click Verify Incoming Data.
    https://gt.bootcampcontent.com/jcassiday/elk-stack-project/-/blob/main/Diagrams/confirm-filebeat.jpg


### For Metricbeat

    Repeat the same steps you did for filebeat to install metricbeat.
    Run the playbook, and navigate to HTTP://20.98.74.199:5601
    Click Add Metric Data.
    Choose Docker Metric.
    Click on the DEB tab under Getting Started.
    On the same page, scroll to Step 5: Module Status and click Check Data.
    Scroll to the bottom of the page and click Verify Incoming Data.
    https://gt.bootcampcontent.com/jcassiday/elk-stack-project/-/blob/main/Diagrams/confirm-metricbeat.jpg
    
You will need to ensure all files are properly placed before running the ansible-playbooks.
