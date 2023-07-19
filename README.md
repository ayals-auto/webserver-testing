# Installtion script for docker env

# Prerequisites
    - chmod u+x ./test.sh
    - backend bucket - required AWS credentials
        - awscli configure
    - The script should run in docker swarm ENV
        - Make sure docker is installed 
        # start swarm using the following command
        - docker swarm init --advertise-addr 127.0.0.1
        # check the node 
        - docker node ls
# Installtion
the script receives two parameters
sudo ./test.sh <start | stop >  <prod | dev | all>
- Options for running this script.
  # start 
      - install terraform in case it's not installed 
      - clone relevant repositories
      - init and running terraform   
  # stop  
      - runs terraform destroy
      - cleaning the files
  # Choose env to install 
      - dev 
      - pro
      - all - to install both clusters
  
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

# Test the solution
- curl HTTP://127.0.0.1:< 8080 | 8081 >
- curl HTTP://127.0.0.1:< 8080 | 8081 >/healthcheck
