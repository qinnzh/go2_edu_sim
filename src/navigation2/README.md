# navigation2

Nav2 启动包装包。

## 用法

先启动带传感器的仿真世界：

```bash
WORLD=warehouse.sdf SENSORS=true bash /home/appuser/go2_edu_ws/run_go2_sim_headless.sh
```

再启动导航：

```bash
source /home/appuser/go2_edu_ws/setup_env.sh
ros2 launch navigation2 go2_navigation2.launch.py
```

导航参数与 RViz 配置位于 `gazebo_sim/config` 与 `gazebo_sim/rviz`。
