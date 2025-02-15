# ubuntu18.04_python3.10_tkinter
- ubuntu18.04とpython3.10とtkinterをwsl上で扱うためのdockerfileを作成し、コンテナを作成するためのリポジトリ。
- 動作環境はWSL＋Ubuntu18.04

## podmanを使用して、イメージをビルドする
- podman build . -t localhost/ubuntu18.04_python3.10.11:latest

## コンテナを作成する（WSL上で動かすとき）
```
podman run -d -it --name test \
    -v .:/usr/src/ \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e DISPLAY="$DISPLAY"  \
    localhost/ubuntu18.04_python3.10.11 \
    /bin/bash
```

## コンテナに入る
- podman exec -it test /bin/bash

## tkinterの動作確認(コンテナ上で実行する)
- python3
- import tkinter
- tkinter._test()

## コンテナを削除する
- podman stop test
- podman rm test

## メモ：
- python3.10をpython3に設定するには？
    - 以下の情報をDockerfileに含める。
        - `update-alternatives --install /usr/bin/python3 python3 /usr/local/bin/python3.10 1`
    - 参考：https://qiita.com/piyo_parfait/items/5abbe4bee2495a62acdc
    
- tkinterをインストールするには？
    - apt install時に、tk-devもインストールしておく
    - 参考：https://stackoverflow.com/questions/5459444/tkinter-python-may-not-be-configured-for-tk
    
- _tkinter.TclError: no display name and no $DISPLAY environment variableへ対処するには？
    - (wsl上)で以下を実行する。
         - sudo apt install x11-apps
         - xeyesの動作確認
            - `xeyes`
                - 上記を実行すると、windowsの画面上にxeyesのウィンドウが表示される。
            - ウィンドウが表示されたら、tkinterも問題なく動くようになっているため、xeyesを閉じる。
    - コンテナを作成するときのコマンドに、以下を入れる
        - `-v /tmp/.X11-unix:/tmp/.X11-unix \`
        - `-e DISPLAY="$DISPLAY"  \`
    - 参考：
        - https://qiita.com/seigot/items/83bc1bb32c04ca36c97f
        - https://qiita.com/hoto17296/items/7c1ba10c1575c6c38105
        - https://zenn.dev/holliy/articles/51012ef059aa9f