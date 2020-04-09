#!/bin/bash

CC=gcc
FC=gfortran


if [ $# -gt 0 ]
then 
   if    [ "$1" = "clean" ] 
   then
      rm -f *.o *.mod *.exe *.a *.out
   elif  [ "$1" = "config" ] 
   then
      $CC -O3 -Wall    exe_param.c -o exe_param.exe
      if [ ! -f exe_param.exe ]
      then
         echo "ERROR: Failed to make exe_param.exe from exe_param.c. Aborted."
         exit 
      fi 
      ./exe_param.exe > tmp1.txt
      echo "!@@@@@`date +%Y-%m-%d_%H-%M-%S`" >  tmp2.txt 
      br1="0"
      while IFS= read -r line1
      do
         echo "$line1"           >>  tmp2.txt 
         if [ "$line1" = "!@@@@@BeginParam" ] 
         then 
            while IFS= read -r line2
            do
               echo "$line2"     >> tmp2.txt 
            done < tmp1.txt
            br1="1"
         fi 
         if [ "$br1" = "1" ]
         then
            break
         fi 
      done < mod_pcreposix.f90
      br1="0"
      while IFS= read -r line1
      do
         if [ "$line1" = "!@@@@@EndParam" ] 
         then 
            br1="1"
         fi 
         if [ "$br1" = "1" ]
         then
            echo "$line1"     >> tmp2.txt 
         fi 
      done < mod_pcreposix.f90
      mv tmp2.txt mod_pcreposix.f90
      rm tmp1.txt exe_param.exe 
	fi
   exit ; 
fi 

set -x 

$CC -O3 -Wall -c dep_pcreposix.c    
$FC -O3 -Wall -c mod_pcreposix.f90  
$FC -O3 -Wall t_pcreposix_01.f90 *.o -lpcreposix -o t_pcreposix_01.exe

./t_pcreposix_gen.sh ./t_pcreposix_01.exe > t_pcreposix_01.txt 
