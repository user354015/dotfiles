#!/bin/fish

################
##            ##
##  ALIASES   ##
##            ##
################

### REMOVE ASAP !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# alias hx "echo no"

## Temporary fix for helix to reset cursor
function hx
    command helix $argv
    printf '\033[0 q'
end

## Greatly improved clear function. Yes. It's that simple.
function clear
    printf '\033[0 q'
    command clear
end

#alias clear '/bin/clear; neofetch --ascii_distro artix' #--source /home/$USER/Graphics/ArchLinux_Ascii.art'
function neo
    command clear
    command fastfetch
    # command neofetch
end

## Debug upload command:
alias debug "nc termbin.com 9999"

## Download a song and store it in ~/Music:
#alias watch "peerflix -l -k"

## Git Clone Abbr.
abbr gc "git clone"

## Make cat look better
# abbr cat bat

## Rsync with proper flags:
abbr rrsync 'rsync -avxHAX --progress'

## Better `ls` using `eza`:
alias ls "eza -l --git --icons=never --git-ignore --group-directories-first --no-permissions --grid"

## Include my prefered flags in bat:
alias bat "bat -pP"

## Better `tree` using `eza`:
alias tree "eza --tree --level=2"

## A better way to untar files:
abbr untar "tar -xvzf"

## So I don't forget:
# abbr grep rg
# abbr find fd

## Continue wget downloaded files:
alias wget 'wget -q'

## Fun alias:
alias please sudo

## Fixing `Broken` mkdir command:
alias mkdir 'mkdir -p'

################
##            ##
##  FUNCTIONS ##
##            ##
################

## Command not found:
function fish_command_not_found
    __fish_default_command_not_found_handler $argv
end

################
##            ##
##  KEYBINDS  ##
##            ##
################

################
##            ##
##  STARTUP   ##
##            ##
################

if test "$TERM" = linux
    command /bin/echo -e "
	\e]P0#232136
	\e]P1#eb6f92
	\e]P2#9ccfd8
	\e]P3#f6c177
	\e]P4#3e8fb0
	\e]P5#c4a7e7
	\e]P6#ea9a97
	\e]P7#e0def4
	\e]P8#393552
	\e]P9#eb6f92
	\e]PA#9ccfd8
	\e]PB#f6c177
	\e]PC#3e8fb0
	\e]PD#c4a7e7
	\e]PE#ea9a97
	\e]PF#e0def4
	"
    # get rid of artifacts
    /bin/clear
end

set fish_greeting

starship init fish | source
zoxide init fish | source
thefuck --alias | source

if test "$TERM" = xterm-ghostty
    neo
end

if test "$TERM" = xterm-256color
    neo
end

function say
    if test (count $argv) -eq 0
        echo "Usage: speak 'text to say'"
        return 1
    end

    set text (string join " " $argv)

    echo $text | piper-tts \
        --model ~/.piper_models/en_US/en_US-lessac-medium.onnx \
        --output-raw | play -t raw -r 22050 \
        -e signed -b 16 -c 1 -
end
