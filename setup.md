* [GUI] 電源設定を修正
    Suspend時間をNeverに設定

* [GUI] psensor
    sudo apt install psensor
    [Psensor] - [Preference] - [Startup] - [Launch on session startup]
    閉じて、最後のWindowサイズを保存させる(位置は保存されないかも)

* [apt] openssh-server
    sudo apt install openssh-server

* fstabを設定
    sudo mkdir /media/xx
    sudo chmod 777 /media/xx
    sudo chown root:root /media/xx
    sudo vi /etc/fstab
        UUID=<id> /media/xx ext4 defaults 0 2
    注意：defaultではなく、defaults
          最後の<pass>行の0は起動時正常性チェックしない、1は高優先度、2は1より低優先度

* workstationをclone
    https://github.com/qian-hao-developer/workstation.git
    既存の各環境設定のパスをそのまま流用するなら、/media/ssd/workstationとして配置する

* [apt] vim
    sudo apt install vim

* デフォルトeditorを修正
    sudo update-alternatives --set editor /usr/bin/vim.basic

* sudoerへの追加
    sudo visudo
        %sudo ALL=(ALL:ALL) ALL の下に以下を追加
        hqian ALL=NOPASSWD: ALL

* [GUI] synergy
    PCのIPアドレスを静的に設定する
    ソフトのインストール及びClientとしての設定
    自動起動
        Ubuntu標準で入っているStartup Applicationsを起動し、以下を追加
            コマンド： synergy

* [apt] git
    sudo apt install git

* brew
    インストール後、bashrc上PATHを設定しないと使えないが、後述環境ファイルのリンク後に設定する

* 環境ファイルのリンク
    https://github.com/qian-hao-developer/workstation.git
    scripts配下のlink_env.shを実行する
        実行したら、env/link配下の.***のconfigファイルが~/にリンクされる

* bashrcの設定
    ~/.bashrcの最後に以下を追加する
        if [ -e "/media/ssd/workstation/env/static/.bashrc" ]; then
            source /media/ssd/workstation/env/static/.bashrc
        fi
    powerline-shellなどがpipでインストールする必要があるため、現時点でbrewが使えるようになるが、表示が変(気にせず)
    pyenvを利用しない場合、workstation内のpyenv初期化部分をコメントアウト

* [apt] gccなどビルド環境
    sudo apt install build-essential

* [apt] pip3
    sudo apt install python3-pip
    python3自体はUbuntuデフォルト入っている
    pyenvはpythonをビルドするためのパッケージが多数必要で、使いにくいので、aptからインストール

* VundleVim
    githubのHPからInstallをする(cloneのみで可能)
    上記環境ファイル(.vimrc)がすでにあるので、vi起動後に:PluginInstallを実行するのみ
    実行後、~/.vim/bundle/YouCompleteMeに入り、python3でinstall.pyを実行する
    また、ctagsをインストールする
        brew install ctags
    YouCompleteMeのRequirementでは、cmakeが必要
        sudo apt install cmake

* [pip] powerline-shell
    pip install powerline-shell
    sudo mv ~/.local/bin/powerline-shell /usr/local/bin
    configを適用
        https://github.com/qian-hao-developer/envi/tree/master/powerline-shell
        上記にあるconfig配下のpowerline-shellを、~/.config/にコピーする
    fontインストール on Windows (https://github.com/powerline/fonts.git   DejaVu Sans Mono for Powerline.ttf)

* [brew] packages
    https://github.com/qian-hao-developer/envi/blob/master/brew/listを参考
    ※tmuxもここでインストールされる

* [apt] source-highlight
    bashrc内にsourceが必要
    sudo apt install source-highlight

* tmux-powerline
    https://github.com/erikw/tmux-powerline.git
    上記clone後、.tmux.conf及び.tmux-powerlinerc内のパスを修正する

* tmux-plugin
    tpmをインストールする
        https://github.com/tmux-plugins/tpm
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    tmux上で以下を実施して.tmux.conf記載のPluginをインストールする
        prefix(ctrl-B) + I

* SSH接続用鍵の登録
    cp workstation/ssh/* ~/.ssh/
    Windows側のSSHキーはref-windows以下に配置している
    新規セットアップ時は以下を参考：
        sshキーを作成
            ssh-keygen -t rsa -b 4096
            windows用に命名する
        WindowsのC:/Users/XXX/.ssh配下にコピー
        Windowsの上記場所にconfigファイルを新規作成
            Host <ssh name>
                HostName <ip address or host name>
                User <user for ssh>
                IdentityFile ~/.ssh/<ssh private key name>
                [Port <port setting if needed>]
        Linux側に上記のpubキーを転送
            cat <pub key> >> ~/.ssh/authorized_keys
        Windows上は以下のようにSSH接続が可能
            ssh.exe <user name>@<ssh name>

* [apt] samba
    sudo apt install samba
    sudo vi /etc/samba/smb.conf
        [media]
            path = /media
            browseable = yes
            writeable = yes
    sudo pdbedit -a <user name>
    sudo systemctl restart smbd.service

* [apt] docker-engine
    https://docs.docker.com/engine/install/ubuntu/
    非特権ユーザーの設定も忘れずに

* [apt] ckermit
    sudo apt install ckermit
    sudo ln -s $(realpath workstation/bin/ker) /usr/local/bin/

* [apt] fastboot & adb
    sudo apt install fastboot adb
