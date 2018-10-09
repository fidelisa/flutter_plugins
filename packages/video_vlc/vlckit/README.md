# Build libvlc for android

## Build docker container
```
docker build -t vlcandroid  .
```
## Build android ( armeabi-v7a, x86 )
```
docker run -ti --rm -v $PWD/../android/libvlc:/mnt/lib vlcandroid /build.sh
```
## Build a specific ABI
* armeabi-v7a
```
docker run -ti --rm -v $PWD/../android/libvlc:/mnt/lib vlcandroid /build.sh armeabi-v7a
```
* armeabi
```
docker run -ti --rm -v $PWD/../android/libvlc:/mnt/lib vlcandroid /build.sh armeabi
```
* armeabi-nofpu
```
docker run -ti --rm -v $PWD/../android/libvlc:/mnt/lib vlcandroid /build.sh armeabi-nofpu
```
* armeabi-v5
```
docker run -ti --rm -v $PWD/../android/libvlc:/mnt/lib vlcandroid /build.sh armeabi-v5
```
* x86
```
docker run -ti --rm -v $PWD/../android/libvlc:/mnt/lib vlcandroid /build.sh x86
```
* mips
```
docker run -ti --rm -v $PWD/../android/libvlc:/mnt/lib vlcandroid /build.sh mips
```

