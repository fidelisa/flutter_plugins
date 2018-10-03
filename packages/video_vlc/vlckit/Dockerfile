FROM ubuntu:latest

MAINTAINER Yann-Cyril Pelud <ypelud@gmail.com>

ENV ANDROID_SDK_TOOLS_REV="4333796" \
    ANDROID_NDK_TOOLS_REV="r14b"

ENV ANDROID_SDK=/opt/android-sdk-linux
ENV ANDROID_NDK=/opt/android-ndk

ENV PATH ${PATH}:${ANDROID_SDK}/platform-tools/:${ANDROID_NDK_HOME}:${ANDROID_SDK}/ndk-bundle:${ANDROID_SDK}/tools/bin/

RUN apt-get update && \
    apt-get install -y automake ant autopoint cmake build-essential libtool \
    patch pkg-config protobuf-compiler ragel subversion unzip git \
    openjdk-8-jre openjdk-8-jdk flex wget python && \
    rm -rf /var/lib/apt/lists/*

RUN    mkdir -p ${ANDROID_SDK} \
    && wget --quiet --output-document=${ANDROID_SDK}/android-sdk.zip https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS_REV}.zip \
    && unzip -qq ${ANDROID_SDK}/android-sdk.zip -d ${ANDROID_SDK} \
    && rm ${ANDROID_SDK}/android-sdk.zip \
    && mkdir -p $HOME/.android \
    && echo 'count=0' > $HOME/.android/repositories.cfg


ENV JAVA_OPTS="--add-modules java.xml.bind"

RUN    yes | sdkmanager --licenses > /dev/null \ 
    && yes | sdkmanager --update 

RUN wget --quiet --output-document=./android-ndk.zip https://dl.google.com/android/repository/android-ndk-${ANDROID_NDK_TOOLS_REV}-linux-x86_64.zip \
    && unzip -qq ./android-ndk.zip -d /opt \
    && rm ./android-ndk.zip \
    && mv /opt/android-ndk-r14b ${ANDROID_NDK}

RUN git clone https://code.videolan.org/videolan/vlc-android.git


COPY build.sh ./


