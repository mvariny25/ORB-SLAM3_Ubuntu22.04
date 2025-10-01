# echo "Configuring and building Thirdparty/DBoW2 ..."

# cd Thirdparty/DBoW2
# mkdir build
# cd build
# cmake .. -DCMAKE_BUILD_TYPE=Release
# make -j15

# cd ../../g2o

# echo "Configuring and building Thirdparty/g2o ..."

# mkdir build
# cd build
# cmake .. -DCMAKE_BUILD_TYPE=Release
# make -j15

# cd ../../Sophus

# echo "Configuring and building Thirdparty/Sophus ..."

# mkdir build
# cd build
# cmake .. -DCMAKE_BUILD_TYPE=Release
# make -j15

# cd ../../../

# echo "Uncompress vocabulary ..."

# cd Vocabulary
# tar -xf ORBvoc.txt.tar.gz
# cd ..

# echo "Configuring and building ORB_SLAM3 ..."

# mkdir build
# cd build
# cmake .. -DCMAKE_BUILD_TYPE=Release
# make -j15
#!/bin/bash

set -e  # stop on first error

# Paths
ORB_SLAM3_DIR=~/colcon_ws/orb_src/ORB_SLAM3
OPENCV_DIR=~/colcon_ws/orb_src/opencv/build  # where you built OpenCV 4.12

# Clean any previous builds
rm -rf $ORB_SLAM3_DIR/build
rm -rf $ORB_SLAM3_DIR/Thirdparty/DBoW2/build
rm -rf $ORB_SLAM3_DIR/Thirdparty/g2o/build
rm -rf $ORB_SLAM3_DIR/Thirdparty/Sophus/build

# Build DBoW2
echo "Building Thirdparty/DBoW2 ..."
cd $ORB_SLAM3_DIR/Thirdparty/DBoW2
mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DOpenCV_DIR=$OPENCV_DIR
make -j$(nproc)

# Build g2o
echo "Building Thirdparty/g2o ..."
cd $ORB_SLAM3_DIR/Thirdparty/g2o
mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DOpenCV_DIR=$OPENCV_DIR
make -j$(nproc)

# Build Sophus
echo "Building Thirdparty/Sophus ..."
cd $ORB_SLAM3_DIR/Thirdparty/Sophus 
mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
make -j$(nproc)
make install

# Build ORB-SLAM3
echo "Building ORB-SLAM3 ..."
cd $ORB_SLAM3_DIR
mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DOpenCV_DIR=$OPENCV_DIR
make -j$(nproc)
