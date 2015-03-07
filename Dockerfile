FROM dockerfile/ubuntu
MAINTAINER Zhike Chan "zk.chan007@gmail.com"
ENV REFRESHED_AT 2015-3-7

RUN \
  apt-get update && \
  apt-get install -qqy \
    libsndfile1-dev \
    libpulse-dev \
    libvorbis-dev \
    libmp3lame-dev & \
  wget http://iweb.dl.sourceforge.net/project/e-guidedog/Ekho/6.0/ekho-6.0.tar.xz && \
  tar xvf ekho-6.0.tar.xz && \
  cd ekho-6.0 && \
  ./configure --with-mp3lame && \
  make install && \
  ekho -t mp3 -o test.mp3 hello && \
  cd .. && \
  rm ekho-6.0.tar.xz && \
  rm -rf ekho-6.0 && \
  rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["ekho"]
CMD ["-h"]