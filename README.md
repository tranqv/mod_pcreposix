# mod_pcreposix

Another portable Fortran module for working with the Perl compatible regular expressions.

Note on _"pcreposix"_: 
+ **PCRE**: Perl-Compatible Regular Expressions
+ **POSIX**: Portable Operating System Interface, where X may stand for Unix (I guess :D)

**1) Requires.** Make sure that the lib _libpcreposix.a_ was installed in our system. It can be done quickly using the **apt-get** command. For instance, in Debian 8 (Jessie), 
+ _sudo apt-get install libpcre3 libpcre3-dev_

and one should have 
+ _/usr/include/pcreposix.h_
+ _/usr/lib/x86_64-linux-gnu/libpcreposix.a_

Ref., for Debian, 
> https://manpages.debian.org/jessie/libpcre3-dev/index.html

> https://manpages.debian.org/jessie/libpcre3-dev/pcreposix.3.en.html

for Centos,  

> https://centos.pkgs.org/7/centos-x86_64/pcre-8.32-17.el7.x86_64.rpm.html

**2) Provides.** Files:
+ **c_pcreposix.c**: C code wrapping the pcreposix functions
+ **f_pcreposix.f90**: Fortran module binding with the C code
+ **t_pcreposix_01.f90**: A testing program. To compile, read its head or the **make.sh**. To know how to run, type the command  _./t_pcreposix_01.exe_ without arguments.
+ **t_pcreposix_gen.sh**: A Bash script to perform 30 test cases which are copied from 

> https://github.com/niklongstone/regular-expression-cheat-sheet

> https://github.com/ZedThree/fortran_pcre

and some other cases from 

> https://www.regular-expressions.info/examples.html

Well, the **fortran_pcre** package is excelent but this one is different since it goes without the _iso_c_binding_ module.

+ **make.sh** a Bash script. All the things (compiling, linking, running tests) will be executed after this command _./make.sh_

**3) Tests.** Run all the tests (30+ cases, or add more by yourself) by the command 
+ **./t_pcreposix_gen.sh ./t_pcreposix_01.exe**
Make sure all the Bash scripts have the executable permission, or add it using the _chmod +x_ command.


**4) Usage.** Common framework in practice

     1. call pcre_regcomp ( preg, pattern, istat ) 
     2. call pcre_regexec ( preg, str, pmatch, nmatch, nfound ) 
     3. call pcre_regfree ( preg ) 
   
   where 
   
     preg     integer(kind=8)
     pattern  character(len=*)
     istat    integer(kind=4)
     str      character(len=*)
     pmatch   integer(kind=4), dimension(2,nmatch)
     nmatch   integer(kind=4)
     nfound   integer(kind=4)

The package was well tested in Debian 9 (4.9.0-12-amd64) with gcc version 6.3.0.

Report on any bug of this code at viet204@mail.com.
