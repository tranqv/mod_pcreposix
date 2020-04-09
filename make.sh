#!/bin/bash

CC=gcc
FC=gfortran

set -x 


if [ $# -gt 0 ]
then 
   if [ "$1" = "clean" ] 
   then
      rm -f *.o *.mod *.exe *.a *.out
#  else 
#
	fi
   exit ; 
fi 


$CC -O3 -Wall -c dep_pcreposix.c    -o mod_pcreposix.p01.o 
$FC -O3 -Wall -c mod_pcreposix.f90  -o mod_pcreposix.p02.o 
$FC -O3 -Wall t_pcreposix_01.f90 *.o -lpcreposix -o t_pcreposix_01.exe

./t_pcreposix_gen.sh ./t_pcreposix_01.exe > t_pcreposix_01.txt 
