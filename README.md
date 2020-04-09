# mod_pcreposix

Another portable Fortran module for working with the Perl compatible regular expressions.

Note on _"pcreposix"_: 
+ **PCRE**: Perl-Compatible Regular Expressions
+ **POSIX**: Portable Operating System Interface, where X may stand for Unix (??? :D)

**1) Requires.** Make sure that the libs _libpcre.a_ and _libpcreposix.a_ was installed in our system. It can be done quickly using the **apt-get** command. For instance in Debian 8 (Jessie), 
+ _sudo apt-get install libpcre3 libpcre3-dev_

and one should have 
+ /usr/include/pcreposix.h
+ /usr/lib/x86_64-linux-gnu/libpcreposix.a

Further ref. for Debian, 
> https://manpages.debian.org/jessie/libpcre3-dev/index.html

> https://manpages.debian.org/jessie/libpcre3-dev/pcreposix.3.en.html

for Centos,  

> https://centos.pkgs.org/7/centos-x86_64/pcre-8.32-17.el7.x86_64.rpm.html

**2) Provides.** Files:
+ **dep_pcreposix.c**: C code wrapping the pcreposix functions
+ **mod_pcreposix.f90**: Fortran module binding with the C code
+ **t_pcreposix_01.f90**: A testing program. To compile, read its head or the **make.sh**. To know how to run, type the command  _./t_pcreposix_01.exe_ without arguments.
+ **t_pcreposix_gen.sh**: A Bash script to perform 30 test cases which are copied from 

> https://github.com/niklongstone/regular-expression-cheat-sheet

> https://github.com/ZedThree/fortran_pcre

and some other cases from 

> https://www.regular-expressions.info/examples.html

Well, the **fortran_pcre** package is excelent but this one goes without the **iso_c_binding** module. It's just simple.

+ **make.sh**: a Bash script. All the things (compiling, linking, running tests) will be executed after this command _./make.sh_

**3) Compiles.**
+ _gcc -O3 -Wall -c dep_pcreposix.c_
+ _gfortran -O3 -Wall -c mod_pcreposix.f90_
+ _gfortran -O3 -Wall t_pcreposix_01.f90 *.o -lpcreposix -o t_pcreposix_01.exe_

**4) Tests.** Run all the tests (30+ cases, or add more by yourself) by the command 
+ _./t_pcreposix_gen.sh ./t_pcreposix_01.exe_

Make sure all the Bash scripts had the executable permission, or add it in advance by using the command 
+ _chmod +x *.sh_

**5) Run all.** All run after this one shot

+ _./make.sh_

**USAGE:**

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

**UPDATE:**


+ **exe_param.c**: C code generating parameters for **mod_pcreposix.f90** in-situ.

+ **make.sh** has been changed. At the very first time, 
run 

      ./make.sh  config 

to revise **mod_pcreposix.f90** accordingly to local system, 
because the C code 
**exe_param.c**
will be compiled so as it can generate values of the parameters within the region marked by 

		!@@@@@BeginParam
		...
		!@@@@@EndParam

of this Fortran file. Just do it only one time.
In addition, run 

      ./make.sh  clean 

to clean out.


