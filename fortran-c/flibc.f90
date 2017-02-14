! Interface to a subset of the C standard library routines and other
! goodies
module flibc
  use iso_c_binding
  implicit none

  public
  public :: string_f2c
  public :: string_c2f

  interface
     !xx! string.h !xx!
     ! From fortranwiki.org (c interface module)
     pure function strlen(str) bind(C,name="strlen")
       ! size_t strlen(const char *str)
       import c_ptr, c_size_t
       integer(c_size_t) :: strlen
       type(c_ptr), value, intent(in) :: str  !character(len=*), intent(in)
     end function strlen
  end interface
  
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
    type(c_ptr), intent(in) :: str0
    character(len=:), allocatable :: str

    integer(c_size_t) :: i, len
    character(kind=c_char),pointer,dimension(:) :: auxf

    len = strlen(str0)
    allocate(character(len=len) :: str)
    call c_f_pointer(str0, auxf, (/len+1/))
    do i = 1, len
       str(i:i) = auxf(i)
    end do
    nullify(auxf)

  end function string_c2f

end module flibc
