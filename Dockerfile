FROM ubuntu:14.04
MAINTAINER Zhike Chan "zk.chan007@gmail.com"
ENV REFRESHED_AT 2015-08-28

ENV EKHO_VERSION 6.3
ENV EKHO_TGZ_URL http://downloads.sourceforge.net/project/e-guidedog/Ekho/6.3/ekho-6.3.tar.xz

RUN \
  buildDeps='build-essential  wget' && \
  buildLibDeps='libsndfile1-dev libpulse-dev libvorbis-dev libmp3lame-dev' && \
  set -x && \
  apt-get update && \
  apt-get install -y $buildDeps && \
  apt-get install -y $buildLibDeps && \
  mkdir ekho && \
  cd ekho && \
  wget "$EKHO_TGZ_URL"  -O ekho.tar.xz && \
  tar xf ekho.tar.xz --strip-components=1 && \
  ./configure --with-mp3lame && \
  make install && \
  ekho -t mp3 -o test.mp3 hello && \
  cd .. && \
  rm -rf ekho && \
  rm -rf /var/lib/apt/lists/* && \
  apt-get purge -y --auto-remove $buildDeps

ENTRYPOINT ["ekho"]
CMD ["-h"]