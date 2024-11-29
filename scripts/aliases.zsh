#!/usr/bin/env bash

#   -------------------------------
#   1. MAKE TERMINAL BETTER
#   -------------------------------

# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
	colorflag="--color"
	export LS_COLORS='no=00:fi=00:di=01;31:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'
else # macOS `ls`
	colorflag="-G"
	export LSCOLORS='gxDxBxCxfxhxHxehEhGxGh'
fi

alias l="ls -lF ${colorflag}"									# l: 		List all files colorized in long format
alias la="ls -laF ${colorflag}"									# la:		List all files colorized in long format, including dot files
alias lsd="ls -lF ${colorflag} | grep --color=never '^d'"		# lsd:		List only directories
alias ls="command ls ${colorflag}" 								# ls:		Always use color output for `ls`
alias ll='ls -FGlAhpa'                       					# ll:		Preferred 'ls' implementation
alias grep='grep --color=auto'									# grep:		Always enable colored `grep` output # Note: `GREP_OPTIONS="--color=auto"` is deprecated, hence the alias usage.
alias fgrep='fgrep --color=auto' 								# fgrep: 	Always enable colored
alias egrep='egrep --color=auto'								# egrep: 	Always enable colored


#   -------------------------------
#   2. NETWORKING
#   -------------------------------

alias myip='dig +short myip.opendns.com @resolver1.opendns.com'     # myip:         Public facing IP Address
alias localip="ipconfig getifaddr en0"								# localip		Show IP Address from en0
alias netCons='lsof -i'                             				# netCons:      Show all open TCP/IP sockets
alias flushDNS='dscacheutil -flushcache'            				# flushDNS:     Flush out the DNS Cache
alias lsock='sudo /usr/sbin/lsof -i -P'             				# lsock:        Display open sockets
alias lsockU='sudo /usr/sbin/lsof -nP | grep UDP'   				# lsockU:       Display only open UDP sockets
alias lsockT='sudo /usr/sbin/lsof -nP | grep TCP'   				# lsockT:       Display only open TCP sockets
alias ipInfo0='ipconfig getpacket en0'              				# ipInfo0:      Get info on connections for en0
alias ipInfo1='ipconfig getpacket en1'              				# ipInfo1:      Get info on connections for en1
alias openPorts='sudo lsof -i | grep LISTEN'        				# openPorts:    All listening connections
alias showBlocked='sudo ipfw list'                  				# showBlocked:  All ipfw rules inc/ blocked IPs

#   ii:  display useful host related informaton
#   -------------------------------------------------------------------
ii() {
	echo -e "\nYou are logged on ${RED}$HOST"
	echo -e "\nAdditionnal information:$NC " ; uname -a
	echo -e "\n${RED}Users logged on:$NC " ; w -h
	echo -e "\n${RED}Current date :$NC " ; date
	echo -e "\n${RED}Machine stats :$NC " ; uptime
	echo -e "\n${RED}Current network location :$NC " ; scselect
	echo -e "\n${RED}Public facing IP Address :$NC " ;myip
	echo
}


#   ---------------------------------------
#   3. SYSTEMS OPERATIONS & INFORMATION
#   ---------------------------------------

alias week='date +%V'										# week:		Get week number
command -v hd > /dev/null || alias hd="hexdump -C" 			# hd:		Canonical hex dump; some systems have this symlinked
command -v md5sum > /dev/null || alias md5sum="md5"			# md5:		macOS has no `md5sum`, so use `md5` as a fallback
command -v sha1sum > /dev/null || alias sha1sum="shasum"	# shasum:	macOS has no `sha1sum`, so use `shasum` as a fallback

# 	emptytrash: Empty the Trash on all mounted volumes and the main HDD.
# 	Also, clear Apple’s System Logs to improve shell startup speed.
# 	Finally, clear download history from quarantine. https://mths.be/bum
#   -------------------------------------------------------------------
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

#   finderShowHidden:   Show hidden files in Finder
#   finderHideHidden:   Hide hidden files in Finder
#   -------------------------------------------------------------------
alias finderShowHidden="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias finderHideHidden="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

#   hidedesktop:   Hide all desktop icons  (useful when presenting)
#   showdesktop:   Show all desktop icons 
#   -------------------------------------------------------------------
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

#   spoton:   Disable Spotlight
#   spoton:   Enable Spotlight
#   -------------------------------------------------------------------
alias spotoff="sudo mdutil -a -i off"
alias spoton="sudo mdutil -a -i on"

#   ---------------------------------------
#   4. MEDIA
#   ---------------------------------------

#	grayscalepdf: grayscale a pdf
#   -------------------------------------------------------------------
alias grayscalepdf="gs -o output.pdf -sDEVICE=pdfwrite -sProcessColorModel=DeviceGray -sColorConversionStrategy=Gray -dProcessColorModel=/DeviceGray -dCompatibilityLevel=1.4"

#   ---------------------------------------
#   5. WORK
#   ---------------------------------------

#	workspacegh: navigates to Github workspace folder
#   -------------------------------------------------------------------
alias workspacegh="cd ~/Documents/Workspace/github"

#	workspacegl: navigates to Gitlab workspace folder
#   -------------------------------------------------------------------
alias workspacegl="cd ~/Documents/Workspace/gitlab"

#   ---------------------------------------
#   6. PROGRAMMING
#   ---------------------------------------

GOCOVPATH="$HOME/go/coverage"
#alias gocov='go test ./... -covermode=atomic -coverprofile $GOCOVPATH/codecov.out.tmp -coverpkg=./... -count=1  -race -timeout=30m -shuffle=on && 
#cat $GOCOVPATH/codecov.out.tmp | grep -v "mocks.go" > $GOCOVPATH/codecov.out &&
#go tool cover -html=$GOCOVPATH/codecov.out -o $GOCOVPATH/codecov.html && 
#open $GOCOVPATH/codecov.html'
alias gocov="$HOME/.dotfiles/gocov_script.zsh"
#   ---------------------------------------
#   7. MISC
#   ---------------------------------------

alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"	# akf:	Lock the screen (when going AFK)

#	Kill all the tabs in Chrome to free up memory
#	[C] explained: http://www.commandlinefu.com/commands/view/402/exclude-grep-from-your-grepped-output-of-ps-alias-included-in-description
#   -------------------------------------------------------------------
alias chromekill="ps ux | grep '[C]hrome Helper --type=renderer' | grep -v extension-process | tr -s ' ' | cut -d ' ' -f2 | xargs kill"

alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'		# chrome: 	Google Chrome
alias reload="exec ${SHELL} -l"														# reload:	Reload the shell (i.e. invoke as a login shell)
alias path='echo -e ${PATH//:/\\n}'													# path:		Print each PATH entry on a separate line
