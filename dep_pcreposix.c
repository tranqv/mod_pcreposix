////////////////////////////////////////////////////////////////////////////////
//
// Compile:
//    gcc -O3 -Wall -c c_pcreposix.c
//
// Good ref.: 
//    https://pubs.opengroup.org/onlinepubs/9699919799/functions/regcomp.html
//
// Author   Tran Quoc Viet 
// Email    viet204@gmail.com
//
// Here I use intptr_t integer to store "regex_t *" for simplicity (I dont care
// the "regex_t" data structure in practice). The casting types is very fast. 
// Check it out!
//
////////////////////////////////////////////////////////////////////////////////

#include <stdint.h>
#include <pcreposix.h>

////////////////////////////////////////////////////////////////////////////////

/*
   int   regcomp ( 
         regex_t *restrict preg, const char *restrict pattern, int cflags);

   Upon successful completion, the regcomp() function shall 
      return 0. 
   Otherwise, it shall 
      return an integer value 
   indicating an error as described in <regex.h>, and the content of preg is 
   undefined. If a code is returned, the interpretation shall be as given in 
   <regex.h>.

   pcreposix_regcomp is defined in #include <pcreposix.h>
*/


void  c_regcomp_intptr_ ( 
      intptr_t *preg_ref, const char *pattern, int *cflags, int *istat ) 
{
   regex_t *preg = (regex_t *) malloc( sizeof(regex_t *) ) ; 
   *istat = pcreposix_regcomp ( preg, pattern, *cflags ) ;
   *preg_ref = (intptr_t) (regex_t *) (preg) ; 
}

////////////////////////////////////////////////////////////////////////////////

/*
   int   regexec (
         const regex_t *preg, const char *string, 
         size_t nmatch, regmatch_t pmatch[restrict], int eflags );

   pcreposix_regexec is defined in #include <pcreposix.h>
*/

void  c_regexec_intptr_ ( 
      const intptr_t *preg_ref, const char *string, size_t *nmatch,  
      regmatch_t *pmatch, int *eflags, int *istat )
{
   *istat = pcreposix_regexec ( 
            (regex_t *) (*preg_ref), string, *nmatch, pmatch, *eflags ) ;
}

////////////////////////////////////////////////////////////////////////////////
/*
   size_t regerror(int errcode, const regex_t *restrict preg,
          char *restrict errbuf, size_t errbuf_size);

   pcreposix_regerror is defined in #include <pcreposix.h>
*/

void  c_regerror_intptr_ ( 
      int *errcode, const intptr_t *preg_ref, char *errbuf, 
      size_t *errbuf_size, size_t *ires )
{
   *ires =  pcreposix_regerror ( 
            *errcode, (regex_t *) (*preg_ref), errbuf, *errbuf_size );
}

////////////////////////////////////////////////////////////////////////////////
/*
   void  regfree(regex_t *preg);

   pcreposix_regfree is defined in #include <pcreposix.h>
*/

void c_regfree_intptr_ ( intptr_t *preg_ref )
{
   pcreposix_regfree ( (regex_t *) (*preg_ref) ) ;
}

////////////////////////////////////////////////////////////////////////////////
