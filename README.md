# Installtion script for docker env

Prequisites
- chmod u+x ./test.sh
- The script should run in docker swarm ENV
    1. Make sure docker is installed 
    2. start swarm using the following ommand
     - docker swarm init --advertise-addr 127.0.0.1
    3. check the node 
        - docker node ls


- Choose env to install 
    - dev
    - prod
- There are tree option for running this script.
    # start 
        - install terraform in case it's not installed 
        - clone relevant repositories
        - init and running terraform   
    # stop  
        - runs terraform destroy
        - cleaning the files 
    # status
        - shows if the implamention runing or not


# Troubleshooting 

show ENV condition.
./test.sh status  
In case terraform run succesfuly but the server is not up.
run:
    docker service ls 
    - Check the number of replicas in REPLICAS  
    - if the number is 0 
        -  run: 
            docker service ps <_name of the service_>
        look at the error tab
        to inspect the task run 
        docker service inspect <_name of the service_>