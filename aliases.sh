#export EDITOR='vim'
alias in='sudo apt-get install -y'
alias out='sudo apt-get purge'
alias q='exit'
alias up='sudo apt-get update && sudo apt-get -y dist-upgrade'
alias d='wget -c'
alias c='clear'
alias cl='sudo apt-get clean;sudo apt-get -y autoremove --purge; sudo apt-get -y purge `deborphan`'
alias m='mount | column -t'
alias l='ls -lah --color'
alias sl='sudo ls -lah --color'
alias ll='ls -lah --color'
alias h='htop'
alias df='df -h'
alias grep='grep --color'
alias v='vim -O'
#alias ga='git add -A'
#alias gs='git status'
#alias gb='git branch -a'
#alias gd='git diff'
#alias gdc='git diff --cached'
#alias gdn='git diff --name-only'
#alias gdv='git difftool --tool=vimdiff --no-prompt'
#alias gl='git log'
#alias gln='git log --name-only'
#alias gll='git log --graph --oneline --decorate --all --remotes=origin'
#alias gc='git checkout'
#alias gp='git pull'
#alias gg='git grep -i'
#alias gcp='git cherry-pick'
#alias gr='git remote -v'
#alias gf='git fetch'
#alias ri='repo info'
#alias rs='repo sync -j8'
#alias ru='repo upload'
#alias ra='repo abandon'
#alias rp='repo prune'
#alias rd='repo diff'
#alias t='tree -Ca -I ".git*" --noreport'
alias lsbig='ls -lhS **/** | head'
alias ws='sudo wireshark -i eth0 -k > /dev/null 2>&1 &'
alias beep='aplay -q /usr/share/orage/sounds/Spo.wav > /dev/null 2>&1'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias hs='history | tail -n50'
alias s='sudo !!'
alias dm='sudo dmesg -cH'
alias bw='wget http://test-debit.free.fr/image.iso -O /dev/null'
alias sv='sudo vim -O'
alias sudo='sudo '
alias n='sudo netstat -lptnu'

function mkc() {
  mkdir -p $1 && cd $1
}

function vd() {
  vimdiff <(xxd $1) <(xxd $2)
}

function g() {
  x-www-browser "http://google.com/search?q=$*" > /dev/null 2>&1 &
}

function f () {
find -type f -iname "*$**" -or -type d -iname "*$**" -and -not -path "*.git*" 2>/dev/null | egrep -i --color "$*"
}

function un () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar -I lbzip2 -xf $1     ;;
      *.tar.gz)    tar -I pigz -xf $1     ;;
      *.tar.xz)    tar -xf $1     ;;
      *.tgz)    	 tar -I pigz -xf $1     ;;
      *.bz2)       pbzip2 -d $1   ;;
      *.rar)       unrar e $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xf $1      ;;
      *.tbz2)      tar xjf $1     ;;
      *.tgz)       tar xzf $1     ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *.lzma)      lzma -d -k $1  ;;
      *)     echo "'$1' cannot be extracted ()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

function cz () {
  tar -I pigz -cf "`basename $1`.tar.gz" $1
}

function databackup () {
  function exit_backup() {
    echo "** Trapped CTRL-C"
    sudo umount /media/backup
  }
  #trap exit_backup INT
  sudo fsck -y /dev/disk/by-label/data_backup
  sudo mount /media/backup &&\
  rsync -av --info=progress2 --exclude 'lost+found' --exclude '.Trash-*' --delete-after /media/data/ /media/backup/ &&\
  sync &&\
  sudo umount /media/backup
}

function srvsave () {
  rsync --delete-after --rsync-path="sudo rsync" -aAX --info=progress2 --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found"} srv.sav:/ /media/data/info/os/srv-backup
}

function kc () {
  sudo apt-get purge $(for tag in "linux-image" "linux-headers"; do dpkg-query -W -f'${Package}\n' "$tag-[0-9]*.[0-9]*.[0-9]*" | sort -V | awk 'index($0,c){exit} //' c=$(uname -r | cut -d- -f1,2); done)
}

function vl() {
  dir=$(realpath "$1")
  editor "$dir"/$(ls -t $dir | head -1)
}

function la() {
  dir=$(realpath "$1")
  echo "$dir"/$(ls -t $dir | head -1)
}

function sms() {
  num="$1"
  msg="$2"
  curl -X POST http://pi/RaspiSMS/smsAPI/ -d "email=api@api.org&password=api&numbers=$num" --data-urlencode "text=$msg"
}

function gls() {
  git log --all --grep="$1"
}
