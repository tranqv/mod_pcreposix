# mod_pcreposix

This is another portable Fortran module for working with the Perl compatible regular expressions. It runs in Linux and was well tested in Debian 9 (4.9.0-12-amd64) with gcc version 6.3.0.

Note on _"pcreposix"_: 
+ **PCRE**: Perl-Compatible Regular Expressions
+ **POSIX**: Portable Operating System Interface, where X may stand for Unix (I guess :D)

Alright here we go. 

First, make sure that the lib _libpcreposix.a_ was installed in our system. It can be done quickly using the **apt-get** command. So far, e.g. in my computer, we should have 
+ _/usr/include/pcreposix.h_
+ _/usr/lib/x86_64-linux-gnu/libpcreposix.a_

Second, this package includes the following files:
+ **c_pcreposix.c**: C code wrapping the pcreposix functions
+ **f_pcreposix.f90** Fortran module binding with the C code
+ **t_pcreposix_01.f90** a testing program. To compile, read its head or the **make.sh**. To know how to run, type the command  _./t_pcreposix_01.exe_ without arguments.
+ **t_pcreposix_gen.sh** a Bash script to perform more than 30 test cases which are copied from 

> https://github.com/niklongstone/regular-expression-cheat-sheet

and 

> https://github.com/ZedThree/fortran_pcre

and some others from 

> https://www.regular-expressions.info/examples.html

Well, the **fortran_pcre** package is excelent but this one is different since it goes without the _iso_c_binding_ module.

+ **make.sh** a Bash script. All the things (compiling, linking, running tests) will be executed after this command _./make.sh_

Lastly, run all the tests (30+ cases) by the command 
+ **./t_pcreposix_gen.sh ./t_pcreposix_01.exe**
Make sure all the Bash scripts have executable privilege, or add it using the _ chmod +x_ command.
