#include <stdio.h>
#include <stdlib.h>
#include <pcreposix.h>


int main()
{
   const char *fst1 = "%-6s%s";
   const char *fmt1 = "%-6sinteger,parameter,public :: %-13s = %2d\n" ; 
// const char *fmt2 = "%-6sinteger,parameter :: %-13s = %2d\n" ; 
   const char *fmt3 = 
      "%-6scharacter,parameter :: %-12s = achar(%3d)  ! %s\n" ; 
//
   printf( "%-6s%s\n", "!", "" );
//
//

   printf( fst1, "!", "logical,parameter :: sayout = .true.  \n" );
   printf( fst1, " ", "logical,parameter :: sayout = .false. \n" );

   printf( "%-6s%s\n", "!", "" );

   printf( fmt1, "", "ck_regexref", sizeof(regex_t *) );
   printf( fmt1, "", "ck_size_t",   sizeof(size_t)    );
   printf( fmt1, "", "ck_int",      sizeof(int)       );
   printf( fmt1, "", "ck_regoff_t", sizeof(regoff_t)  );

   printf( "%-6s%s\n", "!", "" );

   printf( fmt3, "", "ck_char_nul",     0, "NULL char" );

// printf( "%-6s%s\n", "!", "" );
//
// printf( fst1, "", "type,public :: ck_regex_t \n" );
// printf( fst1, "", "   type(ck_voidptr)            :: re_pcre \n"  );
// printf( fst1, "", "   integer(kind = ck_size_t)   :: re_nsub \n"  );
// printf( fst1, "", "   integer(kind = ck_size_t)   :: re_erroffset \n"  );
// printf( fst1, "", "end type ck_regex_t \n" );

   printf( "%-6s%s\n", "!", "" );

   printf( fst1, "", "type,public :: ck_regmatch_t \n" );
   printf( fst1, "", "   integer(kind = ck_regoff_t) :: rm_so \n"  );
   printf( fst1, "", "   integer(kind = ck_regoff_t) :: rm_eo \n"  );
   printf( fst1, "", "end type ck_regmatch_t \n" );

   printf( "%-6s%s\n", "!", "" );
   printf( "%-6s%s\n", "!", "CFLAGS in regcomp() is the bitwise-inclusive" ); 
   printf( "%-6s%s\n", "!", "   OR of zero or more of the following flags" ) ; 
   printf( "%-6s%s\n", "!", "" );

   printf( fmt1, "", "reg_extended" , REG_EXTENDED );
   printf( fmt1, "", "reg_icase"    , REG_ICASE );
   printf( fmt1, "", "reg_nosub"    , REG_NOSUB );
   printf( fmt1, "", "reg_newline"  , REG_NEWLINE );

   printf( "%-6s%s\n", "!", "" );
   printf( "%-6s%s\n", "!", "EFLAGS in regexec() is the bitwise-inclusive" ); 
   printf( "%-6s%s\n", "!", "   OR of zero or more of the following flags" ) ; 
   printf( "%-6s%s\n", "!", "" );

   printf( fmt1, "", "reg_notbol"   , REG_NOTBOL );
   printf( fmt1, "", "reg_noteol"   , REG_NOTEOL );

   printf( "%-6s%s\n", "!", "" );
   printf( "%-6s%s\n", "!", "ISTAT error is of the following values" ) ;
   printf( "%-6s%s\n", "!", "" );

   printf( fmt1, "", "reg_nomatch"  , REG_NOMATCH );
   printf( fmt1, "", "reg_badpat"   , REG_BADPAT );
   printf( fmt1, "", "reg_ecollate" , REG_ECOLLATE );
   printf( fmt1, "", "reg_ectype"   , REG_ECTYPE );
   printf( fmt1, "", "reg_eescape"  , REG_EESCAPE );
   printf( fmt1, "", "reg_esubreg"  , REG_ESUBREG );
   printf( fmt1, "", "reg_ebrack"   , REG_EBRACK );
   printf( fmt1, "", "reg_eparen"   , REG_EPAREN );
   printf( fmt1, "", "reg_ebrace"   , REG_EBRACE );
   printf( fmt1, "", "reg_badbr"    , REG_BADBR );
   printf( fmt1, "", "reg_erange"   , REG_ERANGE );
   printf( fmt1, "", "reg_espace"   , REG_ESPACE );
   printf( fmt1, "", "reg_badrpt"   , REG_BADRPT );

//
//
   printf( "%-6s%s\n", "!", "" );
   return 0;
}

///////////////////////////////////////////////////////////////////////////////
