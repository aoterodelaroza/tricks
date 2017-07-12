program hello
  use iso_c_binding
  implicit none

  real*8, target :: a = 10d0
  real*8, pointer :: pa
  type(c_ptr) :: ivoid

  interface
     subroutine bleh(ivoid)
       use iso_c_binding
       implicit none
       type(c_ptr), intent(in) :: ivoid
     end subroutine bleh
  end interface

  pa => a
  ivoid = c_loc(pa)
  call bleh(ivoid)
  write (*,*) "blah!"
  
end program hello

subroutine bleh(ivoid)
  use iso_c_binding
  implicit none
  type(c_ptr), intent(in) :: ivoid

  real*8, pointer :: npa => null()

  call c_f_pointer(ivoid, npa)
  write (*,*) "value: -", ivoid, "-"
  write (*,*) "value: ", npa

end subroutine bleh
