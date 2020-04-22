DIR=/usr/local/sbin

#if [ $(id -u) -ne "0" ]
#then
#    echo "ERROR: Please run as root"
#    exit 1
#fi

sudo install -m 755 -g root -o root -T scripts/sx1301_reset.sh $DIR/sx1301_reset
sudo sx1301_reset
make clean
make
