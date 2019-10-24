FROM osrf/ros:melodic-desktop-full
#ARG DEBIAN_FRONTEND=noninteractive
ENV DEBIAN_FRONTEND noninteractive

ARG conda_env=lfm
ENV PATH /opt/conda/bin:$PATH
ENV CONDA_DEFAULT_ENV $conda_env

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

RUN  apt-get update \
  && apt-get install -y wget \
  && rm -rf /var/lib/apt/lists/*

#some dependencies
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils nano

# installs avahi for local network discovery (required for using the real robot)
RUN apt-get install -y avahi-daemon avahi-utils

# Python binary dependencies, developer tools
RUN apt-get -qq install build-essential make gcc zlib1g-dev git python3 python3-dev python3-pip

# Upgrade pip3 itself
#RUN pip3 install --upgrade pip

#more packages
RUN pip3 install setuptools
#RUN pip3 install distribute

# Get installation file
RUN wget --quiet https://repo.anaconda.com/archive/Anaconda3-2019.07-Linux-x86_64.sh -O ~/anaconda.sh

# Install anaconda at /opt/conda
RUN /bin/bash ~/anaconda.sh -b -p "/opt/conda"

# Remove installation file
RUN rm ~/anaconda.sh

# Make conda command available to all users
RUN ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh

# Activate conda environment with interactive bash session
RUN echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc

RUN apt-get install -y openssh-server \ 
   					   openssh-client  \
    				   openssl

RUN mkdir $HOME/Projects

