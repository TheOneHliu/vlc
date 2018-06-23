FROM registry.videolan.org:5000/vlc-debian-win32:latest

RUN TARGET_TRIPLE=i686-w64-mingw32 \
    PATH=/opt/gcc-$TARGET_TRIPLE/bin:$PATH && \
    mkdir /build && cd /build && \
    git clone --depth=1 https://git.videolan.org/git/vlc/vlc-3.0.git && \
    cd vlc-3.0 && \
    cd extras/tools && ./bootstrap && make -j`nproc` && \
    export PATH=`pwd`/build/bin:$PATH && cd ../../ && \
    cd contrib && mkdir win32 && cd win32 && \
    ../bootstrap --host=$TARGET_TRIPLE --disable-skins2 \
        --disable-lua --disable-protobuf --disable-gettext && make -j`nproc` && \
    cd /build/vlc-3.0 && ./bootstrap && mkdir build && cd build && \
    ../configure --host=$TARGET_TRIPLE \
        --disable-lua --disable-skins2 \
        --disable-nls \
        --prefix=/prefix && \
    make -j`nproc` && make install && \

