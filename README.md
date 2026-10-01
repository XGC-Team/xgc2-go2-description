# go2_description

Reusable **visual** ROS description assets for **Unitree Go2** (`go2`).

Package layout follows `b2arx_description`: meshes + visual URDF only. No
controllers, Gazebo plugins, or hardcoded machine USB/serial topology.

This is a productized vendor snapshot. It is not an accepted XGC low-polygon
visual default.

| Item | Value |
|------|--------|
| ROS package | `go2_description` |
| Visual URDF | `urdf/go2_visual.urdf` |
| Robot name | `go2` |
| Canonical source | go2.urdf |
| Debian package | `ros-jazzy-xgc2-go2-description` |

Meshes and kinematics remain Unitree's (BSD-3-Clause). Mesh paths use
`package://go2_description/meshes/...`.

## Build

```bash
source /opt/ros/jazzy/setup.bash
colcon build --packages-select go2_description
source install/setup.bash
ros2 pkg prefix go2_description
```

## Install

```
sudo apt update
sudo apt install ros-jazzy-xgc2-go2-description
```

## Use

```text
$(ros2 pkg prefix go2_description)/share/go2_description/urdf/go2_visual.urdf
```

Joint states and TF still come from drivers; this package only supplies
description assets.
