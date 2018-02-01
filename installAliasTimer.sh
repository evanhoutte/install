PWD=`pwd`
#BASH
[ ! -h ~/.aliases.sh ] && ln -s /home/pi/src/installdebian/aliases.sh ~/.aliases.sh
sudo [ ! -h /root/.aliases.sh ] && sudo ln -s /home/pi/src/installdebian/aliases.sh /root/.aliases.sh

[ ! -h ~/.bash_command_timer.sh ] && ln -s /home/pi/src/installdebian/bash_command_timer.sh ~/.bash_command_timer.sh
sudo [ ! -h /root/.bash_command_timer.sh ] && sudo ln -s /home/pi/src/installdebian/bash_command_timer.sh /root/.bash_command_timer.sh

echo "if [ -f ~/.bash_command_timer.sh ]; then
        . ~/.bash_command_timer.sh
fi" >> ~/.bashrc

