sudo mkdir -p /opt/subcollect
script_dir=$(realpath $(dirname $0))

sudo $script_dir/scripts /opt/subcollect/ -r
