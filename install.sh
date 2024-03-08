sudo mkdir -p /opt/subcollect
script_dir=$(realpath $(dirname $0))

sudo cp $script_dir/scripts /opt/subcollect/ -r
sudo cp $script_dir/subcollect.sh /usr/bin/subcollect


if [ "$(which amass)" == "amass not found" ]; then
    sudo apt install amass
fi

if [ "$(which puredns)" == "puredns not found" ]; then
    if ["$(which go)" == "go not found"]; then
       sudo apt install -y golang 
    git clone https://github.com/blechschmidt/massdns.git
    cd massdns
    make
    sudo make install
    go install github.com/d3mondev/puredns/v2@latest
    sudo mv ~/go/bin/puredns /usr/bin
    curl  https://raw.githubusercontent.com/trickest/resolvers/main/resolvers-trusted.txt > ~/.config/puredns/resolvers.txt
fi

if [ "$(which gotator)" == "gotator not found" ]; then
    if ["$(which go)" == "go not found"]; then
       sudo apt install -y golang 
    go install github.com/Josue87/gotator@latest
    sudo mv ~/go/bin/gotator /usr/bin
fi
