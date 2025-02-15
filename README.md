# ubuntu18.04_python3.10_tkinter
ubuntu18.04とpython3.10とtkinterをwsl上で扱うためのdockerfileを作成するためのレポジトリ

## podmanを使用して、イメージをビルドする
- podman build . -t localhost/ubuntu18.04_python3.10.11:latest

## コンテナを作成する
- podman run -d -it --name test -v .:/usr/src/ localhost/ubuntu18.04_python3.10.11 /bin/bash

## コンテナに入る
- podman exec -it test /bin/bash

## コンテナを削除する
- podman stop test
- podman rm test

## メモ：
- python3.10をpython3に設定する
    - https://qiita.com/piyo_parfait/items/5abbe4bee2495a62acdc
    - update-alternatives --install /usr/bin/python3 python3 /usr/local/bin/python3.10 1