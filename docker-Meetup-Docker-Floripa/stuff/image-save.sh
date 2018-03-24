#!/bin/bash

IMAGE=$1
TMP_DIR=~/tmp/docker

if [ -z "$1" ]; then
    echo "Usage: $0 [image name]"
    exit 1
fi

rm -rf $TMP_DIR && mkdir $TMP_DIR
echo "Save $IMAGE image in -> $TMP_DIR/image.tar "
echo
echo "# docker save $IMAGE > $TMP_DIR/image.tar"
docker save $IMAGE > $TMP_DIR/image.tar

echo
echo "Extract $IMAGE layers (rootfs)"
echo

cd $TMP_DIR && mkdir -p $IMAGE
echo
echo "# tar -C $IMAGE -xf image.tar"
tar -C $IMAGE -xf image.tar > /dev/null 2>&1
mkdir -p rootfs
echo
find . -name layer.tar
echo
echo "# find . -name layer.tar -exec tar -C rootfs -xvf {} \;"
find . -name layer.tar -exec tar -C rootfs -xvf {} \; > /dev/null 2>&1

echo
echo -ne "Create rootfs in -> "
cd rootfs
pwd
echo
ls

echo
echo -ne "You want a chroot? [yes/no] : "
read resp

if [ "${resp}x" = "yesx" ]; then
    echo
    echo "# sudo arch-chroot $TMP_DIR/rootfs /bin/bash"
    sudo arch-chroot $TMP_DIR/rootfs /bin/bash
    sudo arch-chroot $TMP_DIR/rootfs /bin/bash
    echo
fi
