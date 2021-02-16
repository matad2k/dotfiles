make distclean

./configure \
	--enable-multibyte \
	--enable-perlinterp \
	--enable-rubyinterp \
	--with-ruby-command=/home/matad2k/.rvm/rubies/ruby-2.6.4/bin/ruby \
	--enable-pythoninterp \
	--with-python-config-dir=/usr/lib64/python2.7/config \
	--enable-python3interp \
	--with-python-command=/usr/bin/python \
	--with-python3.6-config-dir= /usr/lib64/python3.6/config-3.6m-x86_64-linux-gnu \
	--with-python3-command=/usr/bin/python3 \
	--enable-cscope \
	--enable-gui=no \
	--with-features=huge \
	--without-x \
	--enable-fontset \
	--enable-largefile \
	--with-tlib=ncurses \
	--disable-netbeans \
	--with-compiledby="Compiled By m2k"

make
sudo make install
