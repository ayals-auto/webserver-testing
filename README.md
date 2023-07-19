# Installtion script for docker env

# Prerequisites
    - chmod u+x ./test.sh
    - The script should run in docker swarm ENV
        - Make sure docker is installed 
        # start swarm using the following command
        - docker swarm init --advertise-addr 127.0.0.1
        # check the node 
        - docker node ls

- Choose env to install 
    - dev
    - prod

- Options for running this script.
    # start 
        - install terraform in case it's not installed 
        - clone relevant repositories
        - init and running terraform   
    # stop  
        - runs terraform destroy
        - cleaning the files 
    # status - Troubleshooting 
        - shows if the implementation is running or not
        ./test.sh status  
        In case Terraform runs successfully but the server is not up.
        run:
            - docker service ls 
            - Check the number of replicas in REPLICAS  
            - if the number is 0 
                -  run: 
                    - docker service ps <_name of the service_>
                    - look at the error tab
                    - inspect the task run: 
                    - docker service inspect <_name of the service_>
