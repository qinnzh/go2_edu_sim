# quadropted_msgs

四足机器人仿真使用的自定义 ROS 2 消息与服务。

## 消息

```text
msg/RobotGaitCommand.msg
msg/RobotModeCommand.msg
msg/RobotVelocity.msg
msg/RobotFootContact.msg
```

## 服务

```text
srv/RobotBehaviorCommand.srv
```

修改消息后需要重新编译：

```bash
colcon build --packages-select quadropted_msgs
source install/setup.bash
```
