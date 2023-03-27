#!/bin/bash
SRC_DIRECTORY=kobuki_base_ws/src
ROS_DISTRO=humble

#Variables no modificables
ROS_SOURCE=/opt/ros/$ROS_DISTRO/setup.bash
WORK_DIRECTORY=$(pwd)/$SRC_DIRECTORY

echo "Iniciando instalación de los drivers de la kobuki con ros2"

mkdir -p $SRC_DIRECTORY

echo "Amacenando archivos fuentes en $WORK_DIRECTORY"
cd $SRC_DIRECTORY

echo "Clonando repositorios..."
# Kobuki core
git clone https://github.com/kobuki-base/kobuki_core.git
# Kobuki ros
git clone https://github.com/kobuki-base/kobuki_ros.git
# Ros interfaces
git clone https://github.com/kobuki-base/kobuki_ros_interfaces.git
# ecl_core
git clone https://github.com/stonier/ecl_core.git
# cmd_vel_mux
git clone https://github.com/kobuki-base/cmd_vel_mux.git
# ecl_lite
git clone https://github.com/stonier/ecl_lite.git
# ecl_tools
git clone https://github.com/stonier/ecl_tools.git
# velocity smoother
git clone https://github.com/kobuki-base/kobuki_velocity_smoother.git
# sophus
git clone --branch release/1.3.x https://github.com/stonier/sophus 

# Modificaciones al codigo
sed -i '42s$.*$#include <tf2_geometry_msgs/tf2_geometry_msgs.hpp>$' kobuki_ros/kobuki_auto_docking/include/kobuki_auto_docking/auto_docking_ros.hpp

#Estamos en $WORK_DIRECTORY
#Borrar antiguos shophus
rm sophus/sophus/common.hpp
rm sophus/sophus/so2.hpp
rm sophus/sophus/so2.hpp
# archivo correcto
cd sophus/sophus
wget https://raw.githubusercontent.com/SalemCiencias/fix-files-kobuki-ros2/main/common.hpp
wget https://raw.githubusercontent.com/SalemCiencias/fix-files-kobuki-ros2/main/so2.hpp
wget https://raw.githubusercontent.com/SalemCiencias/fix-files-kobuki-ros2/main/so3.hpp

cd $WORK_DIRECTORY

# composed launch
rm kobuki_ros/kobuki_node/launch/kobuki_node-composed-launch.py
cd kobuki_ros/kobuki_node/launch/
wget https://raw.githubusercontent.com/SalemCiencias/fix-files-kobuki-ros2/main/kobuki_node-composed-launch.py

cd $WORK_DIRECTORY
cd ..

source $ROS_SOURCE
rosdep install -i --from-path src --rosdistro $ROS_DISTRO -y
echo "compilando codigo"
colcon build

echo '**************'
echo 'Ejecuta: source '$(pwd)'/install/setup.bash  para tener disponbible los drivers'
echo 'ros2 launch kobuki_node kobuki_node-composed-launch.py : para lanzar el nodo controlador'