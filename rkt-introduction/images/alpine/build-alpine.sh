mirror=http://dl-cdn.alpinelinux.org/alpine
version=v${1}
apk_tools_version=2.7.1-r1
chroot_dir=rootfs

mkdir -p ./build
cd ./build

wget ${mirror}/${version}/main/x86_64/apk-tools-static-${apk_tools_version}.apk
tar -xzf apk-tools-static-*.apk

./sbin/apk.static -X ${mirror}/${version}/main -U --allow-untrusted --root ${chroot_dir} --initdb add alpine-base

mknod -m 666 ${chroot_dir}/dev/full c 1 7
mknod -m 666 ${chroot_dir}/dev/ptmx c 5 2
mknod -m 644 ${chroot_dir}/dev/random c 1 8
mknod -m 644 ${chroot_dir}/dev/urandom c 1 9
mknod -m 666 ${chroot_dir}/dev/zero c 1 5
mknod -m 666 ${chroot_dir}/dev/tty c 5 0

echo -e 'nameserver 8.8.8.8\nnameserver 8.8.4.4' > ${chroot_dir}/etc/resolv.conf
mkdir -p ${chroot_dir}/root

mkdir -p ${chroot_dir}/etc/apk
echo "${mirror}/${version}/main" > ${chroot_dir}/etc/apk/repositories

cd ..
