FROM fuzzers/afl:2.52

RUN apt-get update
RUN apt install -y build-essential wget git clang cmake  automake autotools-dev  libtool zlib1g zlib1g-dev libexif-dev  libjpeg-dev libpng-dev libx11-dev freeglut3-dev
RUN git clone https://github.com/erkkah/tigr.git
WORKDIR /tigr
RUN mkdir /tigrCorpus
RUN cp tigr.png /tigrCorpus
RUN cp ./examples/demo/*.png /tigrCorpus
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/png/mozilla/012-dispose-none.png
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/png/ImageMagick/arc.png
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/png/ImageMagick/arc.png
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/png/ImageMagick/gray10.png
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/png/ImageMagick/crosshatch30.png
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/png/ImageMagick/gray100.png
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/png/ImageMagick/hexagons.png
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/png/ImageMagick/horizontal.png
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/png/ImageMagick/hs_cross.png
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/png/ImageMagick/left30.png
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/png/ImageMagick/left45.png
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/png/ImageMagick/horizontal2.png
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/png/ImageMagick/horizontal3.png
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/png/ImageMagick/objects.png
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/png/ImageMagick/red-ball.png
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/png/ImageMagick/t-shirt.png
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/png/ImageMagick/vertical.png
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/png/ImageMagick/wizard.png
RUN cp *.png /tigrCorpus
WORKDIR /tigr/examples/demo
COPY file:0dc98c60002cf43ae4202866eb634b6ee4c9a2b9f969389a39c9ecc6b9b9f9cc  . 
RUN afl-g++ fuzz.cpp ../../tigr.c -Os -o demo -I../.. -s -lGLU -lGL -lX11


ENTRYPOINT ["afl-fuzz", "-i", "/tigrCorpus", "-o", "/tigrOut"]
CMD ["/tigr/examples/demo/demo", "@@"]
