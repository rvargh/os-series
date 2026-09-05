FROM randomdude/gcc-cross-x86_64-elf

RUN apt-get update 
RUN apt-get upgrade -y
RUN apt-get install -y grub-common grub-pc-bin xorriso nasm

VOLUME /root/env
WORKDIR /root/env




#docker run --rm -it -v "$(pwd)":/root/env os-compiler