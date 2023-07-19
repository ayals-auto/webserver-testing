#!/bin/bash
GIT_REPO="https://github.com/ayals-auto/webserver-testing.git"
ENV=$2

#########################################################
# GLobal prerequisites tests
########################################################

function init_test {
    #check installation
if
    ! dpkg -s terraform &> /dev/null;
    then
        #######################################################################
        # Install terraform
        #######################################################################
        apt-get -qq install wget curl unzip software-properties-common gnupg2 -y
        curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
        apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main" -y
        apt-get update -y
        apt-get -qq install terraform  -y
        #######################################################################
        # Install terragrunt
        #######################################################################
        wget https://github.com/gruntwork-io/terragrunt/releases/download/v0.48.4/terragrunt_linux_amd64
        mv terragrunt_linux_amd64 terragrunt
        chmod u+x terragrunt
        mv terragrunt /usr/local/bin/terragrunt
    else
        echo "terraform allredy installed"
fi

}

# Check if the os is Linux ubuntu
function check_env {
        OS_VERSION=$(grep -E '^(NAME)=' /etc/os-release  &> /dev/null )
        if [ $? != 0 ]; then
            echo "This script should run only on Ubuntu"
            exit 1
        else
            if  [ "${OS_VERSION:6:6}" -eq "Ubuntu"  ]; then
                    echo "This script should run only on Ubuntu"
                    exit 1
            else
                    echo "${OS_VERSION:6:6} we are good to go"
            fi
        fi

}

function choose_env() {
        echo "choose env $ENV"
        if [[ "$ENV" == "prod" ]]
        then
        cd  webserver-testing/main/prod
        elif [[ "$ENV" ==  "dev" ]]
        then
         echo "changing to dev"
         cd  webserver-testing/main/dev
        elif [[ "$ENV" == "all" ]]
        then
        cd  webserver-testing/main
        else
                echo " please choose env to install"
                exit 1
        fi
}

#########################################################
# Initiate env creation and terraform installation
########################################################

function start {
    echo "creating service"
    check_env
    clone_repo
    choose_env
        pwd
    init_test
    terraform_run

}


function clone_repo {
    echo "clone repo"
    git clone $GIT_REPO
}

function terraform_run {
    echo "initiating and running terraform"
    if [[ "$ENV" != "all" ]]
    then
        terragrunt init
        terragrunt apply -auto-approve
   else
       terragrunt run-all apply -auto-approve
   fi
}



#########################################################
# Clear env and terraform installtion
########################################################

function terraform_destroy {
    echo "destroy enivroment"
    if [[ "$ENV" != "all" ]]
    then
        terragrunt destroy -auto-approve
        rm main/$ENV/.terraform.lock.hcl
        rm -R main/$ENV/.terragrunt-cache/
    else

        terragrunt run-all destroy -auto-approve
        rm main/.terraform.lock.hcl
        rm -R main/.terragrunt-cache/

    fi
}

function stop {
    echo "destroying service"
    choose_env
    terraform_destroy
    remove_terraform
    rm /usr/local/bin/terragrunt
   }

function remove_terraform {
    apt-get purge terraform -y
}
########################################################################


function status {
    echo "checking service status"
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
       echo "You must enter a choice, the options are: start stop status";;
esac
