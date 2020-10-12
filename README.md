Introduction
============

Predicting career added value from college and combine statistics to decide which players to take in NFL Draft. 

USAGE
-----
You'll need Docker and the ability to run Docker as your current user.

You'll need to build the container:

    > docker build . -t proj-892-env

This Docker container is based on rocker/verse. To run rstudio server:

    > docker run -v `pwd`:/home/rstudio -p 8787:8787\
      -e PASSWORD=mypass -t proj-892-env
      
Then connect to the machine on port 8787.