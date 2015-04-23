# Designed to be run as 
# 
# docker run -it -p 9999:8888 ipython/latest

FROM debian:jessie

MAINTAINER Jupyter Project <ProjectJupyter@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y git wget build-essential python-dev ca-certificates bzip2 && apt-get clean

RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda3-3.9.1-Linux-x86_64.sh && \
    /bin/bash /Miniconda3-3.9.1-Linux-x86_64.sh -b -p /opt/conda && \
    rm Miniconda3-3.9.1-Linux-x86_64.sh && \
    /opt/conda/bin/conda install --yes conda==3.10.1

EXPOSE 8888

# We run our docker images with a non-root user as a security precaution.
# jovyan is our user
RUN useradd -m -s /bin/bash jovyan

USER jovyan
ENV HOME /home/jovyan
ENV SHELL /bin/bash
ENV USER jovyan
ENV PATH /opt/conda/bin:$PATH

