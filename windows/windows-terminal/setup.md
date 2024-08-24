# install powerline font
1. download fonts from below
   https://github.com/powerline/fonts
2. install below:
   DejaVuSansMono: DejaVu Sans Mono for Powerline.ttf
3. set font of profile ([default] or [Windows PowerShell]) to
   DejaVu Sans Mono for Powerline
4. set font size to
   7 ~ 9 (depends on what hardware)

# package management
1.  install Scoop *recommend
    which is easy to install and uninstall (more clean env)
    https://scoop.sh/

    unsintall scoop
    $ scoop uninstall scoop
    $ del <path-to-scoop>
    *path-to-scoop: under home dir which is named "scoop"

2.  install Chocolatey
    which has problems when uninstall but has more packages

3.  install winget
    which is official tool from Microsoft but not released yet (2021/12)

# powerline related install
1.  install Nerd Font
    This font supports themes of Oh-My-Posh
    ref(Oh-My-Posh):    https://ohmyposh.dev/docs/config-fonts
    site(NF):           https://www.nerdfonts.com/font-downloads
    recommend:
        Download "Meslo LGM NF" via ref,
        Unzip it,
        Install below:
            Meslo LG M Bold Nerd Font Complete Windows Compatible.ttf
            Meslo LG M DZ Bold Italic Nerd Font Complete Mono Windows Compatible.ttf

2.  install Scoop (package management)

3.  install theme packages (oh-my-posh & posh-git)
    install via PS-Gallery
    run under PowerShell:
    ---------------------------------------------------------
        Install-Module posh-git -Scope CurrentUser
        Install-Module oh-my-posh -Scope CurrentUser
    ---------------------------------------------------------
    if above PowerShell 7, run below as well (ps7 is not the standard):
    ---------------------------------------------------------
        Install-Module -Name PSReadLine -Scope CurrentUser -Force -SkipPublisherCheck
    ---------------------------------------------------------

4.  select theme in profile
    run below under PowerShell:
    ---------------------------------------------------------
        code $PROFILE
    ---------------------------------------------------------
    profile (like .bashrc in linux) will be open in VSCode
    add below to PROFILE:
    =========================================================
    Import-Module posh-git
    Import-Module oh-my-posh
    Set-PoshPrompt -Theme Paradox
    =========================================================
    this will select Paradox theme for PowerShell
    see more themes from below:
    https://ohmyposh.dev/docs/themes

5.  select Font via setting
    add below to settings.json or select via Setting GUI
    =========================================================
    "profiles": 
    {
        "defaults": 
        {
            "font": 
            {
                "face": "MesloLGM NF",
                "size": 8
            }
        },
        ...
    =========================================================

6.  add Gruvbox background color-theme definition
    add below to settings.json
    =========================================================
    "schemes": 
    [
        ...
        {
            "background": "#282828",
            "black": "#282828",
            "blue": "#458588",
            "brightBlack": "#928374",
            "brightBlue": "#83A598",
            "brightCyan": "#8EC07C",
            "brightGreen": "#B8BB26",
            "brightPurple": "#D3869B",
            "brightRed": "#FB4934",
            "brightWhite": "#EBDBB2",
            "brightYellow": "#FABD2F",
            "cursorColor": "#FFFFFF",
            "cyan": "#689D6A",
            "foreground": "#EBDBB2",
            "green": "#98971A",
            "name": "Gruvbox Dark",
            "purple": "#B16286",
            "red": "#CC241D",
            "selectionBackground": "#FFFFFF",
            "white": "#A89984",
            "yellow": "#D79921"
        },
        ...
    =========================================================
    add below to select Gruvbox in settings.json or via GUI
    =========================================================
    "profiles": 
    {
        "defaults": 
        {
            "colorScheme": "Gruvbox Dark",
            ...
        },
        ...
    =========================================================

# install WLS (Windows Linux System)
refer: https://soundartifacts.com/ja/how-to/280-how-to-add-ubuntu-tab-to-windows-terminal-in-windows-10.html

1.  install "Ubuntu" from Microsoft Store

2.  enable "Windows Subsystem for Linux"
    https://kb.seeck.jp/archives/8788

3.  Open "Ubuntu" as admin
    this will make you create user/password in Ubuntu

4.  get GUID (uuid) of "Ubuntu"
    run below under "Ubuntu"
    ---------------------------------------------------------
        uuidgen
    ---------------------------------------------------------

5.  add tag to WindowsTerminal
    Open settings.json and add below:
    =========================================================
        "list": 
        [
            ...
            {
                "guid": "{2c4de342-38b7-51cf-b940-2309a097f518}",
                "hidden": false,
                "name": "Ubuntu",
                "source": "Windows.Terminal.Wsl"
            }
        ]
    =========================================================
    "guid" should be which we got via uuidgen
