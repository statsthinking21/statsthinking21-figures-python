# Dockerfile for statsthinking21 figures notebooks

FROM jupyter/datascience-notebook:latest

COPY install_R_packages.R /tmp/install_R_packages.R
RUN Rscript /tmp/install_R_packages.R

RUN pip install \
    sidetable \
    geopandas \
    pingouin

USER root

RUN usermod -u 1002 jovyan

USER jovyan

RUN mkdir /home/jovyan/work/nb


