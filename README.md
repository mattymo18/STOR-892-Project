NFL Draft Analysis
==================

Introduction
------------

This prject will use college statistics and nfl combine data to predict a players career added value statistic. This statistics is taken from pro-football-reference.com and is useful for assesing a players career regardless of the position played. This single number takes all contributions made by the player into account, the higher career added value a player has the better they were during their entire career in the NFL.

Using this model, general managers can predict incoming players value and decide who to take in the draft.

Data
----

Data is taken from and analysis previously done by Sean J. Taylor found here: https://seanjtaylor.github.io/learning-the-draft/ <br />
Specifically the cleaned dataset "training" is used in this analysis. 



USAGE
-----
You'll need Docker and the ability to run Docker as your current user.

You'll need to build the container:

    > docker build . -t proj-892-env

This Docker container is based on rocker/verse. To run rstudio server:

    > docker run -v `pwd`:/home/rstudio -p 8787:8787\
      -e PASSWORD=mypass -t proj-892-env
      
Then connect to the machine on port 8787.