FROM crystallang/crystal:1.1.0

ENV DEBIAN_FRONTEND=noninteractive
    # wget https://github.com/llvm/llvm-project/releases/download/llvmorg-10.0.0/clang+llvm-10.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz -O llvm-10.tar.xz && \
    # tar -xvf /home/junk/llvm-10.tar.xz && \
    # LLVM_CONFIG=../llvm-10/bin/llvm-config

RUN apt-get update && \
    apt-get install -y g++ git make wget tar llvm-10 lldb-10 llvm-10-dev libllvm10 llvm-10-runtime && \
    rm -rf /var/lib/apt/lists/*

#RUN wget https://github.com/crystal-lang/crystal/releases/download/1.1.0/crystal-1.1.0-1-linux-x86_64.tar.gz -O crystal-1.1.0.tar.gz && \
#    tar -xf crystal-1.1.0.tar.gz

RUN git clone https://github.com/crystal-lang/crystal.git && \
    cd crystal && git checkout 1.1.1 && \
    make clean crystal && \
    cp bin/crystal /usr/local/bin

WORKDIR /app
EXPOSE 5001
