#!/usr/bin/env bash
#
# Source this script inside qzh-lightnav-vln to use the isolated Go2 simulation
# workspace without touching /app (LightNav).
#
export PATH="/usr/bin:/bin:/usr/local/bin:${PATH}"
source /opt/ros/humble/setup.bash
source /home/appuser/go2_edu_ws/ROS2-Gazebo-GO2/install/setup.bash

export LD_LIBRARY_PATH="/opt/ros/humble/lib:${LD_LIBRARY_PATH}"
export GZ_SIM_RESOURCE_PATH="/home/appuser/go2_edu_ws/ROS2-Gazebo-GO2/src/gazebo_sim/models"
export GZ_SIM_SYSTEM_PLUGIN_PATH="/opt/ros/humble/lib:${LD_LIBRARY_PATH}"
export IGN_GAZEBO_SYSTEM_PLUGIN_PATH="${GZ_SIM_SYSTEM_PLUGIN_PATH}"

echo "Go2 Edu simulation environment ready."
echo "ROS_DISTRO=${ROS_DISTRO:-humble}"
echo "Workspace=/home/appuser/go2_edu_ws/ROS2-Gazebo-GO2"
