#!/bin/bash


#
#  Tests 
#


if [ $# -lt 1 ] 
then
   echo "usage: $0  your_regex_machine "
   echo "for example "
   echo "       $0  ./t_pcreposix_01.exe "
   exit 1 ; 
fi 

cmd=$1 

   i=1 

   echo "$i ########################################################################"

   echo "$i Start of string or line:"

   $cmd  "^foam"  "foam"
   $cmd  "^foam"  "bath foam"

   ((i=i+1))

   echo "$i ########################################################################"

   echo "$i Start of string, any match mode:"
   $cmd  "\Afoam"  "foam"
   $cmd  "\Afoam"  "bath foam"

   ((i=i+1))

   echo "$i ########################################################################"

   echo "$i End of string or line:"
   $cmd  "finish$"  "finish"
   $cmd  "finish$"  "finnish"
   ((i=i+1))

   echo "$i ########################################################################"

   echo "$i End of string, any match mode:"
   $cmd  "finish\Z"  "finish"
   $cmd  "finish\Z"  "finnish"
   ((i=i+1))

   echo "$i ########################################################################"

   echo "$i Word boundary:"
   $cmd  "\bis\b"  "This island is beautiful"
   $cmd  "\bis\b"  "This island isn't beautiful"
   ((i=i+1))

   echo "$i ########################################################################"

   echo "$i Not word boundary:"
   $cmd  "\Bland"  "island"
   $cmd  "\Bland"  "peninsula"
   ((i=i+1))

   echo "$i ########################################################################"

   echo "$i Positive lookahead:"
   $cmd  "question(?=s)"  "questions"
   $cmd  "question(?=s)"  "question"
   ((i=i+1))

   echo "$i ########################################################################"

   echo "$i Negative lookahead:"
   $cmd  "answer(?!s)"  "answer"
   $cmd  "answer(?!s)"  "answers"
   ((i=i+1))

   echo "$i ########################################################################"

   echo "$i Positive look-behind:"
   $cmd  "(?<=appl)e"  "apple"
   $cmd  "(?<=appl)e"  "orange"
   ((i=i+1))

   echo "$i ########################################################################"

   echo "$i Negative look-behind:"
   $cmd  "(?<!goo)d"  "mood"
   $cmd  "(?<!goo)d"  "good"
   ((i=i+1))

   echo "$i ########################################################################"

   echo "$i Character class definition:"
   $cmd  "[axf]"  "a, x, f"
   $cmd  "[axf]"  "b"
   ((i=i+1))

   echo "$i ########################################################################"

   echo "$i Character class range:"
   $cmd  "[a-c]"  "a, b, c"
   $cmd  "[a-c]"  "d"
   ((i=i+1))

   echo "$i ########################################################################"

   echo "$i Escape in character class:"
   $cmd  "[a-f\.]"  "a, b, ."
   $cmd  "[a-f\.]"  "g"
   ((i=i+1))

   echo "$i ########################################################################"

   echo "$i Not in class:"
   $cmd  "[^abc]"  "de"
   $cmd  "[^abc]"  "a"
   ((i=i+1))

   echo "$i ########################################################################"

   echo "$i Any character except newline:"
   $cmd  "b.ttle"  "battle, bottle"
   $cmd  "b.ttle"  "bttle"
   ((i=i+1))

   echo "$i ########################################################################"

   echo "$i Whitespace:"
   $cmd  "good\smorning"  "good morning"
   $cmd  "good\smorning"  "good.morning"
   ((i=i+1))

   echo "$i ########################################################################"

   echo "$i Not whitespace:"
   $cmd  "good\Smorning"  "good.morning"
   $cmd  "good\Smorning"  "good morning"
   ((i=i+1))

   echo "$i ########################################################################"
 
   echo "$i Digit:"
   $cmd  "\d+"  "0101"
   $cmd  "\d+"  "string"
   ((i=i+1))

   echo "$i ########################################################################"

   echo "$i Not a digit:"
   $cmd  "\D+"  "string"
   $cmd  "\D+"  "0101"
   ((i=i+1))

   echo "$i ########################################################################"

   echo "$i Word character:"
   $cmd  "\w+"  "string01"
   $cmd  "\w+"  ".$?%"
   ((i=i+1))

   echo "$i ########################################################################"

   echo "$i Not a word character:"
   $cmd  "\W+"  ".$?%"
   $cmd  "\W+"  "string01"
   ((i=i+1))

   echo "$i ########################################################################"

   echo "$i Alternation:"
   $cmd  "apple|orange"  "orange, apple"
   $cmd  "apple|orange"  "melon"
   ((i=i+1))

   echo "$i ########################################################################"

   echo "$i Subpattern:"
   $cmd  "foot(er|ball)"  "footer, football"
   $cmd  "foot(er|ball)"  "footpath"
   ((i=i+1))

   echo "$i ########################################################################"

   echo "$i Non-capturing subpattern:"
   $cmd  "foot(?:er|ball)"  "footer, football"
   $cmd  "foot(?:er|ball)"  "footpath"
   ((i=i+1))

   echo "$i ########################################################################"

   echo "$i One or more:"
   $cmd  "ye+ah"  "yeah, yeeeeeah"
   $cmd  "ye+ah"  "yah"
   ((i=i+1))

   echo "$i ########################################################################"

   echo "$i Zero or more:"
   $cmd  "ye*ah"  "yeah, yeeeeeah, yah"
   $cmd  "ye*ah"  "yeh"
   ((i=i+1))

   echo "$i ########################################################################"

   echo "$i Zero or one:"
   $cmd  "yes?"  "yes, ye"
   $cmd  "yes?$"  "yesss"
   ((i=i+1))

   echo "$i ########################################################################"

   echo "$i n times exactly:"
   $cmd  "fo{2}"  "foo"
   $cmd  "fo{2}"  "fo"
   ((i=i+1))

   echo "$i ########################################################################"

   echo "$i Between n and m times:"
   $cmd  "go{2,3}d"  "good, goood"
   $cmd  "go{2,3}d"  "gooood"
   ((i=i+1))

   echo "$i ########################################################################"

   echo "$i At least n times:"
   $cmd  "go{2,}"  "goo, gooo"
   $cmd  "go{2,}"  "go"
   ((i=i+1))

   echo "$i ########################################################################"

   echo "$i ???:"
   $cmd  "^a[[:alnum:]]"  "abc"
   $cmd  "^a[[:alnum:]]"  "axy"

   ((i=i+1))


   echo "$i ########################################################################"

   echo "$i Floating point:"

   $cmd  "[-+]?[0-9]*\.?[0-9]*"  "-.23456.345.6789-.012"

   ((i=i+1))

   echo "$i ########################################################################"

   echo "$i Floating point:"

   $cmd  "[A-z]=[-+]?[0-9]*\.?[0-9]*"  "x=-0.1y=+1.2345z=.12,3.4"

   ((i=i+1))

   echo "$i ########################################################################"

   echo "$i Floating point:"

   $cmd  "[A-z]=[-+]?[0-9]*\.?[0-9]*&"  "x=-0.1&y=+1.2345&z=.12"

   ((i=i+1))

   echo "$i ########################################################################"

   echo "$i Floating point:"

   $cmd  "\b[A-z]=[-+]?[0-9]*\.?[0-9]*\b"  "what+is+this&x=-0.1&y=+1.2345&z=.12"

   ((i=i+1))

   echo "$i ########################################################################"

   echo "$i Floating point:"

   $cmd  "[-+]?([0-9]*\.[0-9]+|[0-9]+)"  "what+is+this&x=-0.1&y=+1.2345e0&z=.12"

   ((i=i+1))

   echo "$i ########################################################################"

   echo "$i Floating point:"

   $cmd  "[-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?"  "what+?&x=-0.1e-2&y=+1.2345e0&z=.12"

   ((i=i+1))

   echo "$i ########################################################################"

   echo "$i Floating point:"

   $cmd  "[-+]?[0-9]*\.?[0-9]"  "what+?&x=-0.1e-2&y=+1.2345e0&z=.12"

   ((i=i+1))

   echo "$i ########################################################################"

   echo "$i Email:"

   $cmd  "\b[A-z0-9._%+-]+@[A-z0-9.-]+\.[A-z]{2,}\b"  "viet204@gmail.com x@a.b.c"

   ((i=i+1))

   echo "$i ########################################################################"

   echo "$i Email:"

   $cmd  "\b[A-z0-9._%+-]+@[A-z0-9.-]+\.[A-z]{2,}\b"  "viet204@gmail.com x@ak.op.vn"

   ((i=i+1))

   echo "$i ########################################################################"

   echo "$i Email:"

   $cmd  "\b[A-z0-9._%+-]+@[A-z0-9.-]+\.[A-z]{2,}\b"  "viet204@gmail.com,x@ak.op.vn"

   ((i=i+1))

   echo "$i ########################################################################"

   echo "$i Email:"

   $cmd  "\b[A-z0-9._%+-]+@[A-z0-9.-]+\.[A-z]{2,}\b"  "viet204@gmail.com; x@ak.op.vn"

   ((i=i+1))

   echo "$i ########################################################################"


