# Ubuntu 18.04 ベースのDockerイメージ
FROM ubuntu:18.04

# timezoneを設定
ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 必要なパッケージをインストール
RUN apt update && \
    apt install -y tzdata wget curl build-essential libssl-dev libffi-dev \
    libbz2-dev libreadline-dev libsqlite3-dev zlib1g-dev

# Python 3.10 のダウンロード & インストール
WORKDIR /usr/src
RUN wget https://www.python.org/ftp/python/3.10.11/Python-3.10.11.tgz && \
    tar xvf Python-3.10.11.tgz && \
    cd Python-3.10.11 && \
    ./configure --enable-optimizations --enable-shared --with-tcltk && \
    make altinstall && \
    rm -rf /usr/src/Python-3.10.11*

# Python のライブラリパスを設定
ENV LD_LIBRARY_PATH=/usr/local/lib

# python3.10を、python3として呼び出せるように設定
RUN update-alternatives --install /usr/bin/python3 python3 /usr/local/bin/python3.10 1

# Python のバージョン確認
RUN python3 --version

# pipのインストール
RUN wget https://bootstrap.pypa.io/get-pip.py && \
    python3 get-pip.py && \
    rm get-pip.py

# pip のバージョン確認
RUN python3 -m pip --version

# Poetry のインストール
RUN curl -sSL https://install.python-poetry.org | python3 -

# Poetry のパスを適用
ENV PATH="/root/.local/bin:$PATH"

# Poetry のバージョン確認
RUN poetry --version

# Python バージョン確認
CMD ["python3", "--version"]