# go2_description

Unitree Go2 的 URDF、Xacro 与网格文件。

主要文件：

```text
urdf/go2_description.urdf
xacro/robot.xacro                 # 普通 Go2
xacro/robot_VLP_D435i.xacro       # 带 LiDAR/D435i 的 Go2
config/ros_control.yaml
meshes/
dae/
launch/description.launch.py
```

普通描述预览：

```bash
source /home/appuser/go2_edu_ws/setup_env.sh
ros2 launch go2_description description.launch.py
```

机器人关节由 `quadropted_controller` 与 `gz_ros2_control` 驱动。
