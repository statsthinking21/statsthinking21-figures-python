# Dockerfile for statsthinking21 figures notebooks

FROM python:3.9-buster

# apt-get installs

RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    vim \
    wget \
    default-jre \
    gfortran \
    pandoc \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# pip installs

RUN pip install \
    nibabel \
    jupyter \
    numpy \
    pandas \
    scikit-learn\
    matplotlib \
    scipy \
    seaborn \
    xlrd \
    statsmodels
    
# install R and necessary packages
RUN wget https://cran.r-project.org/src/base/R-4/R-4.1.3.tar.gz && tar zxf R-4.1.3.tar.gz -C /
RUN apt-get update && apt-get install -y libpcre2-dev 
WORKDIR /R-4.1.3
RUN ./configure --enable-R-shlib=yes && make && make install
RUN rm -rf /R-4.1.3*

RUN pip install \
    rpy2
RUN pip install \
    jupyterlab

# environment setup
ENV C_INCLUDE_PATH /usr/local/lib/R/include
ENV LD_LIBRARY_PATH /usr/local/lib/R/lib

WORKDIR /analysis
# CMD ["jupyter lab"]
