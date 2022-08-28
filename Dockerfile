FROM fuzzers/afl:2.52

RUN apt-get update
RUN apt install -y build-essential wget git clang cmake  automake autotools-dev  libtool zlib1g zlib1g-dev libexif-dev  libjpeg-dev libpng-dev libx11-dev freeglut3-dev
RUN git clone https://github.com/erkkah/tigr.git
WORKDIR /tigr
RUN mkdir /tigrCorpus
RUN cp tigr.png /tigrCorpus
RUN cp ./examples/demo/*.png /tigrCorpus
WORKDIR /tigr/examples/demo
COPY file:0dc98c60002cf43ae4202866eb634b6ee4c9a2b9f969389a39c9ecc6b9b9f9cc in . 
RUN afl-g++ fuzz.cpp ../../tigr.c -Os -o demo -I../.. -s -lGLU -lGL -lX11


ENTRYPOINT ["afl-fuzz", "-i", "/tigrCorpus", "-o", "/tigrOut"]
CMD ["/tigr/examples/demo/demo", "@@"]
