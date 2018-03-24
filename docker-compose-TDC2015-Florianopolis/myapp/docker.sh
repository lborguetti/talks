#!/bin/bash
# Luciano Antonio Borguetti Faustino <lucianoborguetti@gmail.com>
# TDC 2015

# VARS
OPT=${1}

# Building myapp container image
function BuildContainers(){

    # Build image
    docker build -t myapp .

}

# Creating and linking myapp and myredis containers
function StartContainers(){

    # Run redis in backgroud
    docker run -d --name myredis redis

    # Run myapp container and link with myredis
    docker run --rm --name myapp --link myredis:myredis -v `pwd`:/myapp -p 5000:5000 myapp

}


# Stoping myapp and myredis containers
function StopContainers(){

    # Stop myapp container
    docker stop myapp

    # Stop myredis container
    docker stop myredis

}

# Removing myapp and myredis containers
function RemoveContainers(){

    # Remove myapp container
    docker rm myapp

    # Remove myredis container
    docker rm myredis

}

# Remove myapp container image
function RemoveImages(){

    # Remove myapp image
    docker rmi myapp

}

function ShowHelp(){

    echo "${0} [COMMAND]

    Commands:
    build     Build or rebuild services
    rebuild   Rebuild services
    help      Get help on a command
    rm        Remove stopped containers
    run       Run a one-off command
    start     Start services
    stop      Stop services
    restart   Restart services
    up        Create and start containers"

}

# Reading OPT and ...
case ${OPT} in
    up)
        BuildContainers
        StartContainers
        ;;
    start)
        StartContainers
        ;;
    stop)
        StopContainers
        ;;
    restart)
        StopContainers
        StartContainers
        ;;
    rm)
        RemoveContainers
        ;;
    build)
        BuildContainers
        ;;
    rebuild)
        StopContainers
        RemoveContainers
        RemoveImages
        BuildContainers
        ;;
    help)
        ShowHelp
        ;;
    *)
        ShowHelp
        ;;
esac
