sudo mkdir -p /opt/subcollect
script_dir=$(realpath $(dirname $0))

sudo cp $script_dir/scripts /opt/subcollect/ -r
