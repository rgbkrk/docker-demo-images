# Designed to be run as 
# 
# docker run -it -p 9999:8888 ipython/latest

FROM debian:jessie

MAINTAINER Jupyter Project <ProjectJupyter@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y git wget build-essential python-dev ca-certificates bzip2 && apt-get clean

# We run our docker images with a non-root user as a security precaution.
# jovyan is our user
RUN useradd -m -s /bin/bash jovyan

ENV CONDA_DIR /home/jovyan/.conda/bin

# Install conda for the jovyan user only (this is a single user container)
RUN echo 'export PATH=$CONDA_DIR:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda3-3.9.1-Linux-x86_64.sh && \
    /bin/bash /Miniconda3-3.9.1-Linux-x86_64.sh -b -p /home/jovyan/.conda && \
    rm Miniconda3-3.9.1-Linux-x86_64.sh && \
    $CONDA_DIR/conda install --yes conda==3.10.1

RUN chown -R jovyan:jovyan /home/jovyan

EXPOSE 8888

USER jovyan
ENV HOME /home/jovyan
ENV SHELL /bin/bash
ENV USER jovyan
ENV PATH $CONDA_DIR:$PATH

RUN conda install ipython-notebook

CMD ipython notebook
