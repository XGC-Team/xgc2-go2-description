#!/usr/bin/env bash
set -euo pipefail

grep -q '^id: xgc2-ros-jazzy-go2-description$' .xgc2/product.yml
grep -q '^version: 0.1.0-1$' .xgc2/product.yml
grep -q '^kind: ros2-apt$' .xgc2/product.yml
grep -q '^  distro: jazzy$' .xgc2/product.yml
grep -q '^  distribution: noble$' .xgc2/product.yml
grep -q 'ros-jazzy-xgc2-go2-description' .xgc2/product.yml
grep -q '<name>go2_description</name>' package.xml
grep -q '<buildtool_depend>ament_cmake</buildtool_depend>' package.xml
grep -q '<build_type>ament_cmake</build_type>' package.xml
grep -q '^project(go2_description)$' CMakeLists.txt
test -f urdf/go2_visual.urdf
test -f meshes/base.dae
test -f meshes/hip.dae
test -f ASSET_SHA256SUMS
grep -q 'robot name="go2"' urdf/go2_visual.urdf
grep -q 'package://go2_description/meshes/' urdf/go2_visual.urdf
grep -q 'Head_upper_joint' urdf/go2_visual.urdf

sha256sum --check ASSET_SHA256SUMS
python3 -m unittest discover -s test -v

if git ls-files | grep -E '^(launch|rviz|config|src|include)/'; then
  echo "non-visual payload is tracked" >&2
  exit 1
fi
if grep -ERi '<(collision|inertial|transmission|gazebo)|<plugin|ros_control|ros2_control|gazebo_ros' urdf package.xml CMakeLists.txt; then
  echo "non-visual URDF or runtime integration found" >&2
  exit 1
fi
if grep -E 'filename="meshes/' urdf/go2_visual.urdf; then
  echo "relative mesh paths remain" >&2
  exit 1
fi
if grep -ERi 'enP2p1s0|2207:0019|slcan1|192\.168\.123' urdf package.xml CMakeLists.txt README.md; then
  echo "hardcoded machine topology found" >&2
  exit 1
fi

echo "Package compliance checks passed."
