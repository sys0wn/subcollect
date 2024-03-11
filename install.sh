#!/bin/bash

sudo mkdir -p /opt/subcollect
script_dir=$(realpath $(dirname $0))

printf "\n\nCopying scripts to /opt/subcollect\n\n"

sudo cp $script_dir/scripts /opt/subcollect/ -r

printf "\n\nAdding subcollect to PATH\n\n"

sudo cp $script_dir/subcollect.sh /usr/bin/subcollect



printf "\n\nChecking for dependencies (and installing them)\n\n"

cat $script_dir/wordlists/* | sudo tee /opt/subcollect/allDNSWordlists.txt  > /dev/null

amass_path=$(which amass)

if [ -n "$amass_path" ]; then
    printf "amass is already installed at $amass_path."
else
    sudo apt-get install amass
fi



puredns_path=$(which puredns)

if [ -n "$puredns_path" ]; then
    printf "puredns is already installed at $puredns_path."
else

    go_path=$(which go)

    if [ -n "$go_path"]; then
        printf "go is already installed at $go_path."
    else
        sudo apt install -y golang
    fi
    
    git clone https://github.com/blechschmidt/massdns.git
    cd massdns
    make
    sudo make install
    go install github.com/d3mondev/puredns/v2@latest
    sudo mv ~/go/bin/puredns /usr/bin
    curl  https://raw.githubusercontent.com/trickest/resolvers/main/resolvers-trusted.txt > ~/.config/puredns/resolvers.txt
fi



gotator_path=$(which gotator)

if [ -n "$gotator_path" ]; then
    printf "gotator is already installed at $gotator_path."
else
    go_path=$(which go)

    if [ -n "$go_path"]; then
        printf "go is already installed at $go_path."
    else
        sudo apt install -y golang
    fi
    
    go install github.com/Josue87/gotator@latest
    sudo mv ~/go/bin/gotator /usr/bin
fi



dpwg_path=$(which dpwg)

if [ -n "$dpwg_path" ]; then
    printf "dpwg is already installed at $dpwg_path."
    git clone https://github.com/sys0wn/dpwg
    chmod +x dpwg/dpwg.py 
    sudo cp dpwg/dpwg.py /opt/subcollect/scripts/dpwg.py
else
    git clone https://github.com/sys0wn/dpwg
    chmod +x dpwg/dpwg.py 
    sudo cp dpwg/dpwg.py /opt/subcollect/scripts/dpwg.py
    echo "python3 /opt/subcollect/scripts/dpwg.py $1 $2" | sudo tee /usr/bin/dpwg
fi

duplicut_path=$(which duplicut)

if [ -n "$duplicut_path" ]; then
    printf "duplicut is already installed at $duplicut_path."
else
    git clone https://github.com/nil0x42/duplicut
    cd duplicut/ && make
    sudo mv duplicut /usr/bin/duplicut
fi
