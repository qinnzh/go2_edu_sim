# gazebo_sim

本仓库的核心仿真包，包含世界文件、模型、Gazebo/ROS bridge 与主 launch。

## 常用 launch

普通 Go2：

```bash
ros2 launch gazebo_sim launch.py
```

带 D435i/VLP16 等扩展传感器：

```bash
ros2 launch gazebo_sim launch.py sensors:=true world:=warehouse.sdf
```

## 资源路径

Gazebo 模型目录：

```bash
export GZ_SIM_RESOURCE_PATH=<repo>/src/gazebo_sim/models
```

包内已包含：

- `models/`：Go2 相关模型、场地模型和常见物体；
- `world/`：`rmuc_2025_world.sdf`、`warehouse.sdf`、`cafe.world` 等；
- `config/`：robot control、bridge、EKf 配置；
- `launch/`：主 launch 与 robot spawn。

## 主要话题

机器人默认命名空间为 `/robot1`，主要发布相机、IMU、扫描、点云、关节状态与 TF。
