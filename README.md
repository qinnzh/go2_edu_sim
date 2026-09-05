# Unitree Go2 虚拟仿真环境（ROS 2 + Gazebo）

基于 Ubuntu 22.04 + ROS 2 Humble + Gazebo Fortress/Ignition Gazebo 6 的 Unitree Go2 四足机器人虚拟仿真工作区。

本仓库包含：

- Go2 的 URDF/Xacro 模型与网格文件；
- Gazebo 世界、场景资源和相机/LiDAR/IMU 仿真；
- 四足步态与速度控制 Python 节点；
- 建图（cartographer）、导航（Nav2）相关 launch；
- A10 持久容器 `qzh-lightnav-vln` 内可直接使用的进入/启动脚本。

## 目录

```text
go2_edu_sim/
├── setup_env.sh                 # 加载 ROS 2 Humble 与独立工作区
├── run_go2_sim_headless.sh      # 启动 Gazebo + ROS 节点
├── images/                      # 上游示例图片
├── src/
│   ├── cartographer/            # Cartographer 建图 launch
│   ├── docker/                  # Dockerfile / compose 参考
│   ├── gazebo_sim/              # 世界、模型、主 launch
│   ├── go1_description/         # GO1 描述（兼容上游保留）
│   ├── go2_description/         # GO2 描述与 xacro
│   ├── navigation2/             # Nav2 launch 包装
│   ├── quadropted_controller/   # 四足步态/速度控制节点
│   └── quadropted_msgs/         # 自定义消息与服务
└── README.md
```

## 环境要求

已在以下环境验证：

```text
Ubuntu 22.04
ROS 2 Humble
Gazebo Fortress / Ignition Gazebo 6
```

容器内环境变量需要保证：

- `/opt/ros/humble/setup.bash` 已被 source；
- 本仓库的 `install/setup.bash` 已被 source；
- `GZ_SIM_RESOURCE_PATH` 指向 `src/gazebo_sim/models`；
- `GZ_SIM_SYSTEM_PLUGIN_PATH` / `IGN_GAZEBO_SYSTEM_PLUGIN_PATH` 包含 `/opt/ros/humble/lib`。

可直接使用仓库根目录的 `setup_env.sh` 完成以上配置：

```bash
source /home/appuser/go2_edu_ws/setup_env.sh
```

## 编译

```bash
cd /home/appuser/go2_edu_ws/ROS2-Gazebo-GO2
source /opt/ros/humble/setup.bash
export PATH=/usr/bin:/bin:/usr/local/bin:$PATH
colcon build --symlink-install
```

注意：如果系统默认 `python3` 指向其他版本或虚拟环境，编译时应优先让 ROS 使用 `/usr/bin/python3`。

## 启动仿真

默认无图形 headless 启动：

```bash
bash /home/appuser/go2_edu_ws/run_go2_sim_headless.sh
```

启动带传感器版本并切换世界：

```bash
WORLD=warehouse.sdf SENSORS=true bash /home/appuser/go2_edu_ws/run_go2_sim_headless.sh
```

## RViz 可视化

A10 或跳板机没有图形桌面时，需要先把显示接到容器。显示可用后执行：

```bash
DISPLAY=:0 ENABLE_RVIZ=true bash /home/appuser/go2_edu_ws/run_go2_sim_headless.sh
```

RViz 会加载 `go2_self.rviz` 或传感器版配置，能看到 `robot1` 命名空间下的 Go2 模型、TF、激光和里程计。

## 关键话题

默认机器人的 ROS 命名空间为 `/robot1`。

```text
/robot1/color/camera_info
/robot1/color/image_raw
/robot1/cmd_vel
/robot1/odom
/robot1/odometry/filtered
/robot1/scan
/robot1/scan/points
/robot1/joint_states
/robot1/foot_contact
/robot1/robot_mode
/robot1/robot_velocity
/clock
```

## 控制机器人

仿真启动后，可在另一个终端执行键盘遥操作：

```bash
source /home/appuser/go2_edu_ws/setup_env.sh
ros2 run teleop_twist_keyboard teleop_twist_keyboard \
  --ros-args -r /cmd_vel:=/robot1/cmd_vel
```

也可使用行为服务切换状态：

```bash
ros2 service call /robot1/robot_behavior_command \
  quadropted_msgs/srv/RobotBehaviorCommand \
  "{command: 'walk'}"
```

## 包说明

`src` 下每个包都有单独 README：

- [src/cartographer](src/cartographer/README.md)
- [src/docker](src/docker/README.md)
- [src/gazebo_sim](src/gazebo_sim/README.md)
- [src/go1_description](src/go1_description/README.md)
- [src/go2_description](src/go2_description/README.md)
- [src/navigation2](src/navigation2/README.md)
- [src/quadropted_controller](src/quadropted_controller/README.md)
- [src/quadropted_msgs](src/quadropted_msgs/README.md)

## 上游来源

仿真主体整理自：

```text
https://github.com/yanyuze1/ROS2-Gazebo-GO2
```

仓库保留了上游的模型、世界、launch 与示例图片。新增内容包括容器适配脚本、部署说明和各包 README。

## 已验证

实际启动后已看到以下关键话题：

```text
/clock
/robot1/color/camera_info
/robot1/color/image_raw
/robot1/odom
/robot1/odometry/filtered
/robot1/scan
/robot1/scan/points
/robot1/joint_states
/robot1/cmd_vel
/robot1/tf
/robot1/tf_static
```

相机图像话题实测约 `6 Hz`。

## 维护提示

当前改动写入容器可写层。服务器重启后容器会停留在停止状态，用以下命令恢复即可，无需重建镜像：

```bash
docker start qzh-lightnav-vln
docker exec -it qzh-lightnav-vln bash
```

注意：不要在未确认空间和权限的情况下随意删除其他用户或系统的容器/镜像。本环境与 LightNav 服务共用同一容器，但不共用工作区。
