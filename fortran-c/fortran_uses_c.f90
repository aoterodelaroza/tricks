program fortran_uses_c
  use iso_c_binding
  implicit none
       
  interface
     ! From fortranwiki.org (c interface module)
     pure function c_strlen(s) result(result) bind(C,name="strlen")
       use iso_c_binding
       integer(c_size_t) :: result
       type(c_ptr), value, intent(in) :: s  !character(len=*), intent(in)
     end function C_strlen
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

  !xx! Pass a string
  
  character(len=:), allocatable :: fstr
  character(kind=c_char), allocatable :: str(:)
  type(c_ptr) :: ostr_c

  fstr = "hello "
  write (*,*) "before C: ", fstr
  str = string_f2c(fstr)
  call str1(str,ostr_c)
  fstr = string_c2f(ostr_c)
  write (*,*) "after C: ", fstr

contains
  !> Convert a fortran string to a C string
  function string_f2c(str0) result(str)
    character(kind=c_char,len=*), intent(in) :: str0
    character(kind=c_char), allocatable :: str(:)

    integer :: i

    if (allocated(str)) deallocate(str)
    allocate(str(len(str0)+1))
    do i = 1, len(str0)
       str(i) = str0(i:i)
    end do
    str(len(str0)+1) = char(0)

  end function string_f2c

  !> Convert a C string (given as type(c_ptr)) to a fortran string
  function string_c2f(str0) result(str)
    use iso_c_binding
    type(c_ptr), intent(in) :: str0
    character(len=:), allocatable :: str

    integer(c_size_t) :: i, len
    character(kind=c_char),pointer,dimension(:) :: auxf

    len = c_strlen(str0)
    allocate(character(len=len) :: str)
    call c_f_pointer(str0, auxf, (/len+1/))
    do i = 1, len
       str(i:i) = auxf(i)
    end do
    nullify(auxf)

  end function string_c2f

end program fortran_uses_c
