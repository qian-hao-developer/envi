Import-Module posh-git
Import-Module oh-my-posh

# set PS theme to oh-my-posh supplies
# need to install Nerd Font to supply display
Set-PoshPrompt -Theme cloud-native-azure
# not save duplicated history
Set-PSReadlineOption -HistoryNoDuplicates
# disable bell alarm
Set-PSReadlineOption -BellStyle None
