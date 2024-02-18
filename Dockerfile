FROM centos:7.9.2009

RUN yum install kde-l10n-Chinese -y
RUN yum install glibc-common -y
RUN sh -c 'echo -e "LANG=\"zh_CN.UTF-8\"\nLC_ALL=\"zh_CN.UTF-8\"" >> /etc/locale.conf'
ENV LC_ALL zh_CN.UTF-8
ENV LANG zh_CN.UTF-8
RUN localedef -c -f UTF-8 -i zh_CN zh_CN.utf8

RUN yum install -y curl-devel expat-devel gettext-devel openssl-devel zlib-devel

RUN yum install -y perl-ExtUtils-MakeMaker

RUN yum install -y centos-release-scl

RUN yum install -y curl gnupg openssh-client wget gcc g++ cmake

RUN yum install -y GConf2-devel Xaw3d-devel devtoolset-9-gcc devtoolset-9-libgccjit-devel dbus-devel dbus-glib-devel dbus-python gcc giflib-devel gnutls-devel gpm-devel gtk+-devel gtk2-devel ImageMagick ImageMagick-devel jansson-devel libX11-devel libXft-devel libXpm-devel libjpeg-devel libpng-devel libtiff-devel libungif-devel make ncurses-devel pkgconfig texi2html texinfo

RUN yum install -y glibc-headers gcc-c++ fd expat-devel libcurl-dev libcurl-devel

RUN mkdir -p /tmp

RUN cd /tmp;  wget https://github.com/git/git/archive/v2.34.1.tar.gz; tar -xvf v2.34.1.tar.gz; rm -f v2.34.1.tar.gz; cd git-2.34.1; make configure; ./configure --prefix=/usr; make -j 10; make install

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# RUN cd /tmp;  git clone https://github.com/BurntSushi/ripgrep; cd ripgrep; cargo build --release

COPY ./emacs /tmp/emacs28.1
RUN cd /tmp/emacs28.1; ./autogen.sh; ./configure --prefix=/usr/local --without-selinux --without-x --without-dbus --without-sound && make -j 10 && make install

RUN cd /tmp; git clone https://github.com/universal-ctags/ctags.git; cd ctags; ./autogen.sh; ./configure --prefix=/usr/local; make -j 10; make install

CMD ["emacs"]
