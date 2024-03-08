sudo mkdir -p /opt/subcollect
script_dir=$(realpath $(dirname $0))

cp $script_dir/scripts /opt/subcollect/
cp $script_dir/ /opt/subcollect/
