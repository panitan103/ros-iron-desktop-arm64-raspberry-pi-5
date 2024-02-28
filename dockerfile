FROM ros:iron-ros-base-jammy

# install ros2 packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-iron-desktop=0.10.0-3* \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*