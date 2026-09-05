# cartographer

Cartographer 建图相关 launch 文件。

## 用法

先在另一个终端启动 Go2 仿真：

```bash
bash /home/appuser/go2_edu_ws/run_go2_sim_headless.sh
```

再启动建图：

```bash
source /home/appuser/go2_edu_ws/setup_env.sh
ros2 launch cartographer go2_cartographer.launch.py
```

通过键盘遥控机器人移动，即可逐步建立栅格地图。

## 保存地图

```bash
ros2 run nav2_map_server map_saver_cli -t map -f warehouse_map
```

地图文件会生成到当前目录。
