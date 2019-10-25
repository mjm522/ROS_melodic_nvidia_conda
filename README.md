# Steps

A script is given to install steps 1 to 5. So if you are fresh Ubuntu install just run `$pre-install.sh`. To manually install follow the steps 1 to 5. If installing with the pre-install script, jump to step 6.

0) Clone this repository and `cd` to the directory.

1) Install docker using instructions [here](https://docs.docker.com/install/linux/docker-ce/ubuntu/). This installation instructions were tested on Ubuntu 18.04 with Docker version 19.03.3, build a872fc2f86.

2) To run docker as a non-root user, follow the post installation instruction [here](https://docs.docker.com/install/linux/linux-postinstall/).

3) Install nvidia toolkit:[Reference](https://github.com/NVIDIA/nvidia-docker)

`$ sudo apt-get update && sudo apt-get install -y nvidia-container-toolkit
 $ sudo systemctl restart docker`

4) Install nvidia-docker2: Reference](https://github.com/nvidia/nvidia-docker/wiki/Installation-(version-2.0))

`$ sudo apt-get install nvidia-docker2
 $ sudo pkill -SIGHUP dockerd`

5) Once the docker is installed there might be problem with using the sound card for the gazebo. To fix the possible errors (Refer error 1), add the sound devices to the group.

`$sudo usermod -aG audio $USER`

6) run `$./install.sh`

7) The above instruction will automatically login you to the container.

8) Once exited a new instance can be started by typing `$rosdocker` in the terminal. And to enter an already existing docker container run `$newdockterm`.


# Possible Errors

1) `AL lib: (WW) alc_initconfig: Failed to initialize backend "pulse"
   ALSA lib confmisc.c:768:(parse_card) cannot find card '0'`

This error occurs when trying to open gazebo. The issue is because of not able to access sound card. It can be fixed by `$sudo usermod -aG audio $USER` in the terminal before running the script. [Reference](https://github.com/jacknlliu/ros-docker-images/issues/7)

2) `libGL error: No matching fbConfigs or visuals found
    libGL error: failed to load driver: swrast
    X Error of failed request:  GLXBadContext`

The error occurs due to issues with not able to use nvidia drivers. The solution is to install [nvidia-toolkit]() and [nvidia-docker2](https://github.com/nvidia/nvidia-docker/wiki/Installation-(version-2.0)) by following the next two instructions.

`$sudo apt-get install nvidia-docker2
 $sudo pkill -SIGHUP dockerd`

3) `[Err] [REST.cc:205] Error in REST request libcurl: (51) SSL: no alternative certificate subject name matches target host name 'api.ignitionfuel.org'`

Solution: Update the following file `~/.ignition/fuel/config.yaml` as following; change `url: https://api.ignitionfuel.org` to `url: https://api.ignitionrobotics.org`.