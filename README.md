# mod_pcreposix

This is a portable Fortran module for working with the regular expressions. It runs in Linux and was well tested in Debian 4.9.0-12-amd64, gcc version 6.3.0.

First, we make sure that the lib _libpcreposix.a_ was installd. It can be done quickly using the **apt-get** command. So far, we have (e.g. in my computer):
+ /usr/include/pcreposix.h
+ /usr/lib/x86_64-linux-gnu/libpcreposix.a

Note: 
**PCRE**: Perl-Compatible Regular Expressions
**POSIX**: Portable Operating System Interface, where X may stand for Unix (I guess :D)

Second, this package inlcudes the following files:

+ **c_pcreposix.c** C code wrapping pcreposix 
+ **f_pcreposix.f90**
+ **make.sh**
+ **t_pcreposix_01.f90**
+ **t_pcreposix_gen.sh**

Lastly, run the test by the command 
+ **./t_pcreposix_gen.sh ./t_pcreposix_01.exe**
