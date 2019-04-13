FROM ubuntu
MAINTAINER github/briannoyama

RUN  apt-get update --fix-missing                                            &&\
     apt-get install -y --no-install-recommends apt-utils

ENV DEBIAN_FRONTEND noninteractive
#Install SDL2

RUN  apt-get install -y --no-install-recommends                                \
     mesa-utils                                                                \
     xserver-xorg-video-all                                                    \
     libsdl2-dev                                                               \
     libsdl2-ttf-dev                                                           \
     libsdl2-image-dev                                                         \
     libsdl2-mixer-dev                                                         \
     libsdl2-net-dev                                                           \
     gcc                                                                       \
     dbus                                                                    &&\
     dbus-uuidgen > /etc/machine-id

ARG  VERSION=1.12
ENV  VERSION ${VERSION}
ENV  PATH=$PATH:/usr/local/go/bin

#Install Go and Revision Control
RUN  apt-get install -y --no-install-recommends curl git ca-certificates     &&\
     curl -o go${VERSION}.linux-amd64.tar.gz                                   \
     https://dl.google.com/go/go${VERSION}.linux-amd64.tar.gz                &&\
     tar -C /usr/local -xzf go$VERSION.linux-amd64.tar.gz                    &&\
     rm go${VERSION}.linux-amd64.tar.gz

#Install Vim IDE
COPY .vimrc /usr/share/nvim/sysinit.vim
RUN  apt-get install -y software-properties-common python3-dev               &&\
     add-apt-repository ppa:neovim-ppa/stable                                &&\
     apt-get update                                                          &&\
     apt-get install -y neovim                                               &&\
     curl -fLo root/.local/share/nvim/site/autoload/plug.vim --create-dirs     \
     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim     &&\
     nvim --headless +PlugInstall +qa                                        &&\
     tar -zcvf go.tar.gz /root/go                                            &&\
     rm -R /root/go

WORKDIR /root/go

# sudo docker build golang_env -t go_env 
