# Dockerfile for statsthinking21 figures notebooks

FROM jupyter/datascience-notebook:latest


USER root
RUN apt-get update && apt-get install -y graphviz cmake
# fix user to mount shared volume and to be able to sudo
# NOTE: this must match the UID if the local user who owns the files in the shared volume
RUN usermod -u 1002 jovyan
RUN usermod -aG sudo jovyan
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER jovyan

RUN pip install \
    sidetable \
    geopandas \
    pingouin \
    semopy \
    yellowbrick \
    jupyter-book \
    graphviz

RUN echo "Installing R packages"

COPY install_R_packages.R /tmp/install_R_packages.R
RUN Rscript /tmp/install_R_packages.R

RUN mkdir /home/jovyan/work/nb

