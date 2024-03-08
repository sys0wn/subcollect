sudo mkdir -p /opt/subcollect
script_dir=$(realpath $(dirname $0))

sudo cp $script_dir/scripts /opt/subcollect/ -r
sudo cp $script_dir/subcollect.sh /usr/bin/subcollect

if [ -n $(which amass) ]; then
    sudo apt install amass
fi
