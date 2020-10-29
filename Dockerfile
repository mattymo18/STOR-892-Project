FROM rocker/verse
MAINTAINER Matt Johnson <Johnson.Matt1818@gmail.com>
RUN R -e "install.packages('Rtsne')"
RUN R -e "install.packages('ggfortify')"
RUN R -e "install.packages('cluster')"
RUN R -e "install.packages('pls')"
RUN R -e "install.packages('randomForest')"
RUN R -e "install.packages('gbm')"
RUN R -e "install.packages('caret')"