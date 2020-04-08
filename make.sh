#!/bin/bash

CC=gcc
FC=gfortran

set -x 

$CC -O3 -Wall -c c_pcreposix.c
$FC -O3 -Wall -c f_pcreposix.f90 
$FC -O3 -Wall t_pcreposix_01.f90 *.o -lpcreposix -o t_pcreposix_01.exe

./t_pcreposix_gen.sh ./t_pcreposix_01.exe > t_pcreposix_01.txt 
