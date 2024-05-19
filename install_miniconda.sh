# install miniconda
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ./install_conda.sh
bash ./install_conda.sh -b -p $HOME/miniconda
echo "PATH=\$PATH:$HOME/miniconda/bin" >> ~/.bashrc
rm ./install_conda.sh

