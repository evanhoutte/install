sudo dphys-swapfile swapoff
#sudo dphys-swapfile swapon
sudo update-rc.d -f dphys-swapfile remove


echo "# Add this line to /etc/fstab
sudo nano /etc/fstab
# les fichiers de log et tempo passent en RAM
tmpfs   /tmp            tmpfs   defaults,noatime,mode=1777,size=10m     0       0
tmpfs   /var/spool      tmpfs   defaults,noatime,mode=1777              0       0
tmpfs   /var/tmp        tmpfs   defaults,noatime,mode=1777,size=10m     0       0
tmpfs   /var/log        tmpfs   defaults,noatime,mode=0755,size=10m     0       0


Attention toutefois avec le répertoire /var/spool. En effet ce répertoire contient le répertoire crontab qui gère tous les appelle à cron. Cron permet de définir des taches qui seront lancées à un instant donné, ou lancées périodiquement. Le fait que le répertoire crontab soit en ram détruira à chaque reboot du Raspberry la listes des taches programmées.

Donc si vous utilisez cron sur votre Raspberry, ne mettez pas /var/spool dans la ram.
"
