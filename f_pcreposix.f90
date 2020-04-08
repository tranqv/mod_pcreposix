!-----------------------------------------------------------------------
!
!     Compile:
!
!        gfortran -O3 -Wall -c f_pcreposix.f90 
!
!-----------------------------------------------------------------------
!
      module mod_pcreposix 
!
      implicit none 
!
      private 
!
!     logical,parameter  :: sayout = .true. 
      logical,parameter  :: sayout = .false. 
!
      integer,parameter,public :: ck_regexref   =  8 
      integer,parameter,public :: ck_size_t     =  8
      integer,parameter,public :: ck_int        =  4
      integer,parameter,public :: ck_regoff_t   =  4
!
      type, public :: ck_regmatch_t 
         integer(kind = ck_regoff_t)  :: rm_so 
         integer(kind = ck_regoff_t)  :: rm_eo 
      end type ck_regmatch_t 
!
      character,parameter :: ck_char_nul =  char(0)   ! private
!
!     CFLAGS in regcomp() is the bitwise-inclusive
!        OR of zero or more of the following flags
!     
      integer,parameter,public :: reg_extended  =  0
      integer,parameter,public :: reg_icase     =  1
      integer,parameter,public :: reg_nosub     = 32
      integer,parameter,public :: reg_newline   =  2
!     
!     EFLAGS in regexec() is the bitwise-inclusive
!        OR of zero or more of the following flags
!     
      integer,parameter,public :: reg_notbol    =  4
      integer,parameter,public :: reg_noteol    =  8
!     
!     ISTAT error is of the following values
!     
      integer,parameter,public :: reg_nomatch   = 17
      integer,parameter,public :: reg_badpat    =  3
      integer,parameter,public :: reg_ecollate  =  7
      integer,parameter,public :: reg_ectype    =  8
      integer,parameter,public :: reg_eescape   =  9
      integer,parameter,public :: reg_esubreg   = 15
      integer,parameter,public :: reg_ebrack    =  6
      integer,parameter,public :: reg_eparen    = 11
      integer,parameter,public :: reg_ebrace    =  5
      integer,parameter,public :: reg_badbr     =  2
      integer,parameter,public :: reg_erange    = 12
      integer,parameter,public :: reg_espace    = 14
      integer,parameter,public :: reg_badrpt    =  4
!
!     ... add more constants as you want
!
      public :: pcre_regcomp
      interface pcre_regcomp
         module procedure pcre_regcomp_intptr_0 
         module procedure pcre_regcomp_intptr_1 
      end interface 
!
      public :: pcre_regexec
      interface pcre_regexec
         module procedure pcre_regexec_intptr_0 
         module procedure pcre_regexec_intptr_1 
      end interface 
!
      public :: pcre_regerror
      interface pcre_regerror
         module procedure pcre_regerror_intptr_0 
      end interface 
!
      public :: pcre_regfree
      interface pcre_regfree
         module procedure pcre_regfree_intptr_0 
      end interface 
!
!-----------------------------------------------------------------------
      contains
!-----------------------------------------------------------------------
!
      subroutine  pcre_regcomp_intptr_0 ( &
                  preg_ref, pattern, cflags, istat ) 
! 
      implicit none
!
      integer(kind=ck_regexref)     preg_ref
      character(len=*)              pattern 
      integer(kind=ck_int)          cflags
      integer(kind=ck_int)          istat 
      external                      c_regcomp_intptr 
!
!
      call  c_regcomp_intptr ( &
            preg_ref, pattern//ck_char_nul, cflags, istat ) 
!
      end subroutine pcre_regcomp_intptr_0
!
!-----------------------------------------------------------------------
!
      subroutine  pcre_regexec_intptr_0 ( &
                  preg_ref, str, nmatch, pmatch, eflags, istat )
! 
      implicit none
!
      integer(kind=ck_regexref)  preg_ref
      character(len=*)           str    
      integer(kind=ck_size_t)    nmatch
      type(ck_regmatch_t)        pmatch (nmatch)
      integer(kind=ck_int)       eflags
      integer(kind=ck_int)       istat 
      external                   c_regexec_intptr
!
      integer(kind=ck_size_t)    i
!
!
      call  c_regexec_intptr ( &
            preg_ref, str//ck_char_nul, nmatch,pmatch,eflags,istat )
!
      if ( istat .eq. 0 ) then 
         do i = 1, nmatch
            if ( pmatch(i) % rm_so .ne. pmatch(i) % rm_eo ) then 
               pmatch(i) % rm_so = pmatch(i) % rm_so + 1 
            else 
               pmatch(i) % rm_so = -1
               pmatch(i) % rm_eo = -1 
               istat = -1 
            endif 
         enddo
      endif 
!
      end subroutine pcre_regexec_intptr_0
!
!-----------------------------------------------------------------------
!
      subroutine  pcre_regerror_intptr_0 ( &
                  errcode, preg_ref, errbuf, errbuf_size, ires ) 
! 
      implicit none
!
      integer(kind=ck_int)       errcode 
      integer(kind=ck_regexref)  preg_ref
      character(len=*)           errbuf 
      integer(kind=ck_size_t)    errbuf_size
      integer(kind=ck_size_t)    ires
      external                   c_regerror_intptr
!
!
      call  c_regerror_intptr ( &
            errcode, preg_ref, errbuf, errbuf_size, ires ) 
!
!     Here we need to remove the NULL at the end of output strings.
!
      end subroutine pcre_regerror_intptr_0
!
!-----------------------------------------------------------------------
!
      subroutine  pcre_regfree_intptr_0 ( preg_ref ) 
!
      implicit none
!
      integer(kind=ck_regexref)  preg_ref
      external                   c_regfree_intptr
!
!
      call  c_regfree_intptr ( preg_ref ) 
!
      end subroutine pcre_regfree_intptr_0
!
!-----------------------------------------------------------------------
!
!     Common framework in practice
!
!     1. call *regcomp* ( preg, pattern, istat ) 
!     2. call *regexec* ( preg, str, pmatch, nmatch, nfound ) 
!     3. call *regfree* ( preg ) 
!
!-----------------------------------------------------------------------
!
      subroutine  pcre_regcomp_intptr_1 ( preg_ref, pattern, istat ) 
! 
      implicit none
!
      integer(kind=ck_regexref)     preg_ref
      character(len=*)              pattern 
      integer(kind=ck_int)          istat 
!
      integer(kind=ck_int)          cflags
!
!
      cflags = 0 
      call  pcre_regcomp_intptr_0 ( preg_ref, pattern, cflags, istat ) 
!
      end subroutine pcre_regcomp_intptr_1
!
!-----------------------------------------------------------------------
!
      subroutine  pcre_regexec_intptr_1 ( &
                  preg_ref, str, pmatch, nmatch, nfound )
!
      implicit none
!
      integer(kind=ck_regexref)  preg_ref
      character(len=*)           str    
      integer(kind=ck_size_t)    nmatch
      integer(kind=ck_int)       pmatch (2,nmatch)
      integer(kind=ck_int)       nfound 
!
      type(ck_regmatch_t)        tmp_pmatch (1)
      integer(kind=ck_size_t)    nm, i
      integer(kind=ck_int)       eflags, istat, lb, rb, lm, rm 
!
!
      nm = 1
      eflags = 0
      i  = 0 
      lb = 1 
      rb = len_trim(str)
      nfound = 0 
!
      do i = 1, nmatch 
 
         if ( i .gt. 1 ) eflags = reg_notbol  
 
         call  pcre_regexec_intptr_0 ( &
               preg_ref, str(lb:rb), nm, tmp_pmatch, eflags, istat )
 
         if ( istat .ne. 0  ) exit 
         nfound = nfound + 1 

         lm = tmp_pmatch(1) % rm_so + lb - 1 
         rm = tmp_pmatch(1) % rm_eo + lb - 1 
!
!HINT:   If you do not want it to report every step, set sayout = .false.
!        and re-compile this file and then your program.
!
         if (sayout) print 100,  &
            eflags, istat, & 
            lb, rb, str(lb:rb), &  
            i, tmp_pmatch(1) % rm_so, tmp_pmatch(1) % rm_eo, &
            lm, rm, str(lm:rm)
!
!        Correcting from local index to global index for external uses:
!
         pmatch(1,i) = lm 
         pmatch(2,i) = rm 
!
         lb = rm + 1 
!
         if ( lb .gt. rb ) exit 
!
      enddo
!
 100  format ( 'regexec(): eflags =', i4, ', istat =', i4, /, & 
               "STR (",i4,":",i4,")=", a, / &
               'for i =',i4,': matched.', /, 5x, &
               'offset = (', i4, ":", i4, ') --> ', &
               'STR (', i4, ":", i4, ') =', 2x, a, /, 72('-') ) 
!
      end subroutine pcre_regexec_intptr_1
!
!-----------------------------------------------------------------------
      end module mod_pcreposix 
!-----------------------------------------------------------------------
