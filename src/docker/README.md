# docker

用于在带 NVIDIA GPU 的 Ubuntu 22.04 主机上构建 ROS 2 Humble + Gazebo 容器。

## 文件

- `Dockerfile`：基础镜像为 `osrf/ros:humble-desktop-full`，安装 Go2 仿真所需 ROS 包；
- `docker-compose.yml`：容器化启动参考；
- `cyclonedds.xml`：CycloneDDS 配置参考。

## 容器构建

```bash
cd src/docker
docker compose up -d --build
docker compose exec go2_sim bash
```

如果你不使用容器，也可以直接在 Ubuntu 22.04 宿主机按根 README 编译。
