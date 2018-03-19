FROM ubuntu
MAINTAINER github/briannoyama

RUN  apt-get update --fix-missing                                            &&\ 
     apt-get install -y --no-install-recommends apt-utils

#Install SDL2
COPY keyboard /etc/default/keyboard
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

ARG  VERSION=1.10
ENV  VERSION ${VERSION}
ENV  PATH=$PATH:/usr/local/go/bin

#Install Go and Revision Control
RUN  apt-get install -y --no-install-recommends curl git ca-certificates     &&\                    
     curl -o go${VERSION}.linux-amd64.tar.gz                                   \
     https://dl.google.com/go/go${VERSION}.linux-amd64.tar.gz                &&\
     tar -C /usr/local -xzf go$VERSION.linux-amd64.tar.gz                    &&\
     rm go${VERSION}.linux-amd64.tar.gz

#Install Atom IDE
RUN  curl -Lo atom-amd64.deb https://atom.io/download/deb                    &&\                    
     apt install -y ./atom-amd64.deb                                         &&\
     rm atom-amd64.deb                                                       &&\
     apm install go-plus                                                       \
     platformio-ide-terminal                                                 &&\
     go get -u golang.org/x/tools/cmd/goimports                              &&\
     go get -u golang.org/x/tools/cmd/gorename                               &&\
     go get -u github.com/sqs/goreturns                                      &&\
     go get -u github.com/nsf/gocode                                         &&\
     go get -u github.com/alecthomas/gometalinter                            &&\
     go get -u github.com/zmb3/gogetdoc                                      &&\
     go get -u github.com/zmb3/goaddimport                                   &&\
     go get -u github.com/rogpeppe/godef                                     &&\
     go get -u golang.org/x/tools/cmd/guru                                   &&\
     go get -u github.com/fatih/gomodifytags                                 &&\
     go get -u github.com/tpng/gopkgs

WORKDIR ${HOME}/go
