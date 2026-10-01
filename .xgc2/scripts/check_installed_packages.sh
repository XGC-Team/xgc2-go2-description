#!/usr/bin/env bash
set -eo pipefail

source /opt/ros/noetic/setup.bash
set -u

dpkg -s ros-noetic-xgc2-go2-description >/dev/null
package_path="$(rospack find go2_description)"
test "${package_path}" = /opt/ros/noetic/share/go2_description
test -f "${package_path}/meshes/base.dae"
test -f "${package_path}/meshes/hip.dae"
test -f "${package_path}/urdf/go2_visual.urdf"
test -f "${package_path}/ASSET_SHA256SUMS"

(
  cd "${package_path}"
  sha256sum --check ASSET_SHA256SUMS
)

python3 - "${package_path}/urdf/go2_visual.urdf" <<'PY'
import sys
import xml.etree.ElementTree as ET

root = ET.parse(sys.argv[1]).getroot()
assert root.attrib["name"] == "go2"
assert len(root.findall("link")) == 29
assert len(root.findall("joint")) == 28
for tag in ("collision", "inertial", "transmission", "gazebo", "plugin"):
    assert not root.findall(f".//{tag}"), tag
PY

echo "Installed package check passed."
