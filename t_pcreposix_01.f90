!-----------------------------------------------------------------------
!
!     Compile:
!
!gfortran -O3 -Wall t_pcreposix_01.f90 *.o -lpcreposix -o t_pcreposix_01.exe
!
!     For a pattern, search for all matched substring from a string.
!
!     Examples:               pattern     string 
!
!     ./t_pcreposix_01.exe    'is'        'This island is beautiful.'
!     ./t_pcreposix_01.exe    '\bis'      'This island is beautiful.'
!     ./t_pcreposix_01.exe    'is\b'      'This island is beautiful.'
!     ./t_pcreposix_01.exe    'is[A-z]'   'This island is beautiful.'
!     ./t_pcreposix_01.exe    '[A-z]is'   'This island is beautiful.'
!     ./t_pcreposix_01.exe \
!                             "[-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?"  \
!                                         "?&x=-0.1e-2&y=+1.2345e0&z=.12"
!
!     Author   Tran Quoc Viet 
!     Email    viet204@gmail.com
!
!-----------------------------------------------------------------------
!
      program t_pcreposix_01
   
      use  mod_pcreposix

      implicit none    
!
!     One can define as follows
!     integer(kind=ck_size_t),parameter :: maxlen = 4096
!     integer(kind=ck_size_t),parameter ::  nmatch = 100 
!     integer(kind=ck_int)       pmatch(2,nmatch)
!     character(len=maxlen)      pattern, xstring
!     integer(kind=ck_size_t)    lt_pattern, lt_xstring  
!     integer(kind=ck_int)       istat, nfound, i 
!     integer(kind=ck_regexref)  preg
!
!     Or, for simplicity, just declare as follows
!
      integer(kind=8),        parameter :: maxlen = 4096
      integer(kind=8),        parameter ::  nmatch = 100 
      integer(kind=4)            pmatch(2,nmatch)
      character(len=maxlen)      pattern, xstring
      integer(kind=8)            lt_pattern, lt_xstring  
      integer(kind=4)            istat, nfound, i 
      integer(kind=8)            preg
!
!
      if ( command_argument_count() .lt. 2 ) goto 600

      call get_command_argument( 1, pattern ) 
      call get_command_argument( 2, xstring ) 

      lt_pattern = len_trim (pattern)
      lt_xstring = len_trim (xstring)

      print *, 'pattern = ', pattern(1:lt_pattern)
      print *, 'string  = ', xstring(1:lt_xstring)
      print *   

      call  pcre_regcomp ( preg, pattern(1:lt_pattern), istat )

      if ( istat .ne. 0 ) goto 700 

      call  pcre_regexec ( &
            preg, xstring(1:lt_xstring), pmatch, nmatch, nfound )

      call  pcre_regfree ( preg )
  
      print *, 'regfree() done.'
      print 72  
!
!
      do i = 1, nfound 
         print 101,  & 
            i, pmatch(1,i), pmatch(2,i), &
            xstring( pmatch(1,i) : pmatch(2,i) )  
      enddo 

      if ( nfound .lt. 1 ) print *, 'Result: NOT FOUND.'

      print 73  
!
      STOP
!
  72  format ( 72('-') ) 
  73  format ( 72('='),/ ) 
 101  format ( 'Result ',i4,': SubSTR (', i4, ":", i4, ') = ', a )
!
!     Error trapping 
! 
 600  continue 
      print *, & 
         "ERROR: Wrong input."                     // char(10) // &
         " Usage: "                                // char(10) // &
         "  ./a.out  pattern  string "             // char(10) // & 
         " Examples:"                              // char(10) // &
      "  ./t_pcreposix_01.exe  &
      &  'is'        'This island is beautiful.'"  // char(10) // &
      "  ./t_pcreposix_01.exe  &
      &  '\bis'      'This island is beautiful.'"  // char(10) // &
      "  ./t_pcreposix_01.exe  &
      &  'is\b'      'This island is beautiful.'"  // char(10) // &
      "  ./t_pcreposix_01.exe  &
      &  'is[A-z]'   'This island is beautiful.'"  // char(10) // &
      "  ./t_pcreposix_01.exe  &
      &  '[A-z]is'   'This island is beautiful.'"  // char(10) // &
      "  ./t_pcreposix_01.exe  &
      &  '[-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?' & 
      &  '?&x=-0.1e-2&y=+1.2345e0&z=.12'"          // char(10) 

      stop 
!
 700  continue 
      print *, 'regcomp() failed, istat =', istat 
      stop 
!
      end program t_pcreposix_01
   
