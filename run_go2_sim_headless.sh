#!/usr/bin/env bash
#
# Unitree Go2 Gazebo simulation inside qzh-lightnav-vln.
# RViz is disabled by default; set ENABLE_RVIZ=true when a display is available.
# Usage:
#   WORLD=rmuc_2025_world.sdf SENSORS=false bash run_go2_sim_headless.sh
#   DISPLAY=:0 ENABLE_RVIZ=true bash run_go2_sim_headless.sh
#
set -e
set +u

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/setup_env.sh"
set -euo pipefail

export WORLD="${WORLD:-rmuc_2025_world.sdf}"
export SENSORS="${SENSORS:-false}"
export ENABLE_RVIZ="${ENABLE_RVIZ:-false}"

WS="/home/appuser/go2_edu_ws"
REPO="${WS}/ROS2-Gazebo-GO2"
LOG_DIR="${WS}/logs"
mkdir -p "${LOG_DIR}"

cd "${REPO}"

WORLD_FILE="${REPO}/install/gazebo_sim/share/gazebo_sim/world/${WORLD}"
if [ ! -f "${WORLD_FILE}" ]; then
  echo "World file not found: ${WORLD_FILE}"
  exit 1
fi

if [ "${SENSORS}" = "true" ]; then
  LAUNCH_FILE="gazebo_go2_sensors.launch.py"
else
  LAUNCH_FILE="gazebo_go2_self.launch.py"
fi

echo "Starting Gazebo server: ${WORLD}"
ign gazebo -s -r -v2 "${WORLD_FILE}" >"${LOG_DIR}/gz_server.log" 2>&1 &
GZ_PID=$!

cleanup() {
  kill "${GZ_PID}" 2>/dev/null || true
  pkill -f "gazebo_go2_${LAUNCH_FILE}" 2>/dev/null || true
  pkill -f "ign gazebo" 2>/dev/null || true
}
trap cleanup EXIT

sleep 8

echo "Starting ROS 2 launch: ${LAUNCH_FILE} (rviz=${ENABLE_RVIZ})"
ros2 launch "gazebo_sim" "${LAUNCH_FILE}" "enable_rviz:=${ENABLE_RVIZ}"
