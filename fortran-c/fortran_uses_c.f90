program fortran_uses_c
  use iso_c_binding
  use flibc, only: string_f2c, string_c2f
  implicit none
       
  interface
     ! Simple routine with no arguments and no return value
     subroutine fun1() bind(c)
       use iso_c_binding
       implicit none
     end subroutine fun1
     ! Pass integer arguments by reference and value
     function int1(i1,i1r) bind(c)
       use iso_c_binding
       implicit none
       integer(kind=c_int), value :: i1
       integer(kind=c_int) :: i1r
       integer(kind=c_int) :: int1
     end function int1
     ! Pass string arguments
     subroutine str1(astr,ostr) bind(c)
       use iso_c_binding
       implicit none
       character(kind=c_char), dimension(*) :: astr
       type(c_ptr) :: ostr
     end subroutine str1
  end interface

  ! !xx! Simple routine with no arguments and no return value
  ! write (*,*) "hello... "
  ! call fun1()

  ! !xx! Simple routine with no arguments and integer return value
  ! integer(kind=c_int) :: i1, i1r, iexit
  ! i1 = 2
  ! i1r = 0
  ! write (*,*) "before C: i1 = ", i1, " i1r = ", i1r
  ! iexit = int1(i1,i1r)
  ! write (*,*) "after C: i1 = ", i1, " i1r = ", i1r
  ! write (*,*) "return value: iexit = ", iexit

  ! !xx! Pass a string
  ! character(len=:), allocatable :: fstr
  ! character(kind=c_char), allocatable :: str(:)
  ! type(c_ptr) :: ostr_c

  ! fstr = "hello "
  ! write (*,*) "before C: ", fstr
  ! str = string_f2c(fstr)
  ! call str1(str,ostr_c)
  ! fstr = string_c2f(ostr_c)
  ! write (*,*) "after C: ", fstr

end program fortran_uses_c
