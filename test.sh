#!/bin/bash
#GIT_REPO=<repo_name>

#########################################################
# GLobal prequisits tests
########################################################

function init_test {
    #check installtion
if 
    ! dpkg -s terraform &> /dev/null; 
    then
        #######################################################################
        # Install terraform
        #######################################################################
        apt-get install wget curl unzip software-properties-common gnupg2 -y 
        curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - 
        apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main" -y
        apt-get update -y
        apt-get install terraform -y
        apt-get install wget
        wget https://github.com/gruntwork-io/terragrunt/releases/download/v0.38.12/terragrunt_darwin_amd64
        #######################################################################
        # Install terragrunt
        #######################################################################
        apt-get install wget
        wget https://github.com/gruntwork-io/terragrunt/releases/download/v0.38.12/terragrunt_darwin_amd64
        mv terragrunt_darwin_amd64 terragrunt
        chmod u+x terragrunt
        mv terragrunt /usr/local/bin/terragrunt
    else
        echo "terraform allredy installed"
fi

}

# Check if os is linux ubuntu
function check_env {
        OS_VERSION=$(grep -E '^(NAME)=' /etc/os-release  &> /dev/null ) 
        if [ $? != 0 ]; then
            echo "this script should run only on Ubuntu"
            exit 1
        else
            if [ "${OS_VERSION:6:6}" != Ubuntu  ] ; then
                    echo "this script should run only on Ubuntu"
                    exit 1
            else
                    echo "${OS_VERSION:6:6} we are good to go"
            fi
        fi

}

#########################################################
# Initiate env creation and terraform installtion
########################################################

function start {
    echo "creating service"
    check_env
    init_test
    clone_repo
    case $1 in
        prod )
            cd main/prod ;;
        dev )
            cd main/dev;;
        *)
        echo "default create dev";;
    esac
    terraform_run

}


function clone_repo {
    echo "clone repo"
    git clone $GIT_REPO
    cd terraform_dir
}

function terraform_run {
    echo "initiating and runing terraform"
    terraform init
    terraform applay -auto-approve
}



#########################################################
# Clear env and terraform installtion
########################################################
function stop {
    echo "destroying service"
    terraform_destroy
    remove_terraform  
}

function terraform_destroy {
    echo "destroy enivroment"
    terraform destroy -y
}

function remove_terraform {
    apt-get purge terraform -y
}
########################################################################


function status {
    echo "checing service status"
    echo "#############################################################"
    echo "#  Service condition"
    echo "#############################################################"
    docker service ls
    echo "#############################################################"
    echo "#  Running node"
    echo "#############################################################"
    docker node ls
}

# choose an option 
case $1 in
    start )
        start ;;
    stop )
        stop ;;
    status )
        status ;;
    *)
       echo "you must enter a chooice, the option are: start stop status";;
esac