# mod_pcreposix

This is another portable Fortran module for working with the Perl compatible regular expressions. It runs in Linux and was well tested in Debian 9 (4.9.0-12-amd64) with gcc version 6.3.0.

Note on _"pcreposix"_: 
+ **PCRE**: Perl-Compatible Regular Expressions
+ **POSIX**: Portable Operating System Interface, where X may stand for Unix (I guess :D)

Alright here we go. 

First, make sure that the lib _libpcreposix.a_ was installed in our system. It can be done quickly using the **apt-get** command. So far, e.g. in my computer, we have 
+ /usr/include/pcreposix.h
+ /usr/lib/x86_64-linux-gnu/libpcreposix.a

Second, this package includes the following files:
+ **c_pcreposix.c** C code wrapping the pcreposix functions
+ **f_pcreposix.f90** Fortran module binding with the C code
+ **t_pcreposix_01.f90** a testing program 
+ **t_pcreposix_gen.sh** more than 30 test cases copied from 
>> https://github.com/niklongstone/regular-expression-cheat-sheet
>> https://github.com/ZedThree/fortran_pcre
well, the latter module is excelent but this one is different.
+ **make.sh** all run after this shot: _./make.sh_

Lastly, run all the test cases by the command 
+ **./t_pcreposix_gen.sh ./t_pcreposix_01.exe**
