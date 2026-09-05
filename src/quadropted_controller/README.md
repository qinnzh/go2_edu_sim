# quadropted_controller

四足机器人高层控制与里程计节点，全部使用 Python 实现。

## 包含节点

- `robot_controller_gazebo.py`：Gazebo 中的步态/速度控制；
- `QuadrupedOdometryNode.py`：基于 IMU/关节状态的里程计；
- `cmd_vel_pub.py`：将 `/robot1/cmd_vel` 转成底层控制输入；
- `robot_mode.py`：机器人模式切换。

## 接口

订阅：

```text
/robot1/cmd_vel
```

发布：

```text
/robot1/odom
/robot1/robot_velocity
/robot1/robot_mode
/robot1/foot_contact
```

服务：

```text
/robot1/robot_behavior_command
```
