module fmod
  use c_interface_module
  implicit none

  public

  type, bind(c) :: modtype
     integer(c_int) :: id1
     real(c_double) :: f1
     character(kind=c_char,len=1) :: str(3)
  end type modtype
  type(modtype), allocatable, target :: mm(:)
  integer(c_int), bind(c) :: nm
  type(c_ptr), bind(c,name="mm") :: mpoint

contains

  ! A trivial hello world example with no arguments.
  !header! void hello();
  subroutine hello() bind(c)

    write (*,*) "hello, world!"

  end subroutine hello

  ! Passing scalar integers from/to C. The integer types are:
  ! | Fortran type    | C type                    |
  ! |-----------------+---------------------------|
  ! | C_INT           | int                       |
  ! | C_SHORT         | short int                 |
  ! | C_LONG          | long int                  |
  ! | C_LONG_LONG     | long long int             |
  ! | C_SIGNED_CHAR   | signed char/unsigned char |
  ! | C_SIZE_T        | size_t                    |
  ! | C_INT8_T        | int8_t                    |
  ! | C_INT16_T       | int16_t                   |
  ! | C_INT32_T       | int32_t                   |
  ! | C_INT64_T       | int64_t                   |
  ! | C_INT_LEAST8_T  | int_least8_t              |
  ! | C_INT_LEAST16_T | int_least16_t             |
  ! | C_INT_LEAST32_T | int_least32_t             |
  ! | C_INT_LEAST64_T | int_least64_t             |
  ! | C_INT_FAST8_T   | int_fast8_t               |
  ! | C_INT_FAST16_T  | int_fast16_t              |
  ! | C_INT_FAST32_T  | int_fast32_t              |
  ! | C_INT_FAST64_T  | int_fast64_t              |
  ! | C_INTMAX_T      | intmax_t                  |
  ! | C_INTPTR_T      | intptr_t                  |
  function integer_scalar_types(cint,cintp1,csame) bind(c) result(cresult)
    integer(c_int), intent(in), value :: cint
    integer(c_int), intent(out) :: cintp1
    integer(c_int), intent(inout) :: csame
    integer(c_int) :: cresult

    write (*,*) "F - integer on input: ", cint, csame
    cintp1 = cint + 1
    csame = csame + 1
    cresult = -99
    write (*,*) "F - integer on output: ", cintp1, csame
    write (*,*) "F - function result: ", cresult

  end function integer_scalar_types

  ! Passing scalar real from/to C. The real types are:
  ! | Fortran type  | C type      |
  ! |---------------+-------------|
  ! | C_FLOAT       | float       |
  ! | C_DOUBLE      | double      |
  ! | C_LONG_DOUBLE | long double |
  function real_scalar_types(cf,cft2,cfsame) bind(c) result(cfresult)
    real(c_double), intent(in), value :: cf
    real(c_double), intent(out) :: cft2
    real(c_double), intent(inout) :: cfsame
    real(c_double) :: cfresult

    write (*,*) "F - real on input: ", cf, cfsame
    cft2 = cf * 2
    cfsame = cfsame + 1
    cfresult = -99
    write (*,*) "F - real on output: ", cft2, cfsame
    write (*,*) "F - function result: ", cfresult

  end function real_scalar_types
  
  ! Passing scalar complex from/to C. The complex types are:
  ! | Fortran type          | C type               |
  ! |-----------------------+----------------------|
  ! | C_FLOAT_COMPLEX       | float _Complex       |
  ! | C_DOUBLE_COMPLEX      | double _Complex      |
  ! | C_LONG_DOUBLE_COMPLEX | long double _Complex |
  function complex_scalar_types(cf,cft2,cfsame) bind(c) result(cfresult)
    complex(c_float_complex), intent(in), value :: cf
    complex(c_float_complex), intent(out) :: cft2
    complex(c_float_complex), intent(inout) :: cfsame
    complex(c_float_complex) :: cfresult

    write (*,*) "F - complex on input: ", cf, cfsame
    cft2 = cf * 2 + 8 * (0.,1.)
    cfsame = cfsame * (0.,1.)
    cfresult = -99d0 * (1.,2.)
    write (*,*) "F - complex on output: ", cft2, cfsame
    write (*,*) "F - function result: ", cfresult

  end function complex_scalar_types
  
  ! Passing scalar logical from/to C. The logical types are:
  ! | Fortran type          | C type               |
  ! |-----------------------+----------------------|
  ! | C_BOOL                | _Bool                |
  function logical_scalar_types(cf,cft2,cfsame) bind(c) result(cfresult)
    logical(c_bool), intent(in), value :: cf
    logical(c_bool), intent(out) :: cft2
    logical(c_bool), intent(inout) :: cfsame
    logical(c_bool) :: cfresult

    write (*,*) "F - logical on input: ", cf, cfsame
    cft2 = .not.cf
    cfsame = .not.cfsame
    cfresult = .true.
    write (*,*) "F - logical on output: ", cft2, cfsame
    write (*,*) "F - function result: ", cfresult

  end function logical_scalar_types

  ! Passing scalar character from/to C. The character types are:
  ! | Fortran type          | C type               |
  ! |-----------------------+----------------------|
  ! | C_CHAR                | char                 |
  function string_types(cstr,cstro,cstrio) bind(c) result(cout)
    type(c_ptr), intent(in) :: cstr
    type(c_ptr), intent(out) :: cstro
    type(c_ptr), intent(inout) :: cstrio
    type(c_ptr) :: cout

    character(len=:), allocatable :: fstr, fstr2

    fstr = c_string_value(cstr)
    write (*,*) "F - string on input: ", fstr
    
    cstro = f_c_string_dup("opqr",4)

    ! needs to have been malloc'd
    fstr2 = c_string_value(cstrio)
    write (*,*) "F - string on input (i/o): ", fstr2
    fstr = fstr2 // "jkl"
    write (*,*) "F - string on output (i/o): ", fstr
    cstrio = c_realloc(cstrio,int(len(fstr)+1,c_size_t))
    call f_c_string(fstr,cstrio)

    ! needs free() later on
    cout = f_c_string_dup("blehblah!")

  end function string_types

  ! pass array arguments to and from C
  subroutine array_arguments(n,x1,x2,x3) bind(c)
    integer(c_int), intent(in), value :: n
    real(c_double), intent(inout) :: x1(n)
    real(c_double), intent(inout) :: x2(n,n)
    real(c_double), intent(inout) :: x3(n,n,n)

    integer :: i, j, k
    
    write (*,*) "n: "
    write (*,*) n
    write (*,*) "x1: "
    do i = 1, n
       write (*,*) i, x1(i)
    end do
    write (*,*) "x2: "
    do i = 1, n
       do j = 1, n
          write (*,*) i, j, x2(i,j)
       end do
    end do
    write (*,*) "x3: "
    do i = 1, n
       do j = 1, n
          do k = 1, n
             write (*,*) i, j, k, x3(i,j,k)
          end do
       end do
    end do
    do i = 1, n
       x1(i) = real(i**2,8)
       do j = 1, n
          x2(i,j) = real(i**2+j**2,8)
          do k = 1, n
             x3(i,j,k) = real(i**2+j**2+k**2,8)
          end do
       end do
    end do

  end subroutine array_arguments

  ! pass one-dimensional arrays
  subroutine array_arguments_pointer(xfull,xempty) bind(c)
    type(c_ptr), intent(inout) :: xfull
    type(c_ptr), intent(inout) :: xempty

    real(c_double), pointer :: ffull(:)
    real(c_double), pointer :: fempty(:)

    integer :: i

    write (*,*) "associated xfull: ", c_associated(xfull)
    write (*,*) "associated xempty: ", c_associated(xempty)

    ! use xfull and deallocate it, pass it back as null to C
    call c_f_pointer(xfull,ffull,(/3/))
    write (*,*) "associated ffull: ", associated(ffull)
    write (*,*) "size ffull: ", size(ffull,1)
    write (*,*) "contents ffull: "
    do i = 1, 3
       write (*,*) i, ffull(i)
    end do
    deallocate(ffull)
    xfull = c_loc(ffull)

    ! allocate xempty and assign it
    allocate(fempty(5))
    do i = 1, 5
       fempty(i) = 20d0*i
    end do
    xempty = c_loc(fempty)

  end subroutine array_arguments_pointer

  ! pass two-dimensional arrays
  subroutine array2_arguments_pointer(xfull,xempty) bind(c)
    type(c_ptr), intent(inout) :: xfull
    type(c_ptr), intent(inout) :: xempty

    integer :: i, j

    real(c_double), pointer :: ffull(:,:)
    real(c_double), pointer :: fempty(:,:)

    write (*,*) "associated xfull: ", c_associated(xfull)
    write (*,*) "associated xempty: ", c_associated(xempty)

    ! use xfull and deallocate it, pass it back as null to C
    call c_f_pointer(xfull,ffull,(/4,3/))
    write (*,*) "associated ffull: ", associated(ffull)
    write (*,*) "size ffull: ", size(ffull,1), size(ffull,2)
    write (*,*) "contents ffull: "
    do i = 1, 3
       do j = 1, 4
          write (*,*) i, j, ffull(j,i)
       end do
    end do
    deallocate(ffull)
    xfull = c_loc(ffull)

    ! allocate xempty and assign it
    allocate(fempty(3,4))
    write (*,*) "contents fempty: "
    do i = 1, 4
       do j = 1, 3
          fempty(j,i) = 20d0*i+j
          write (*,*) i, j, fempty(j,i)
       end do
    end do
    xempty = c_loc(fempty)

  end subroutine array2_arguments_pointer

  ! pass the user defined type
  subroutine type_pointer(ss,ssin) bind(c)
    type, bind(c) :: bleh 
       integer(c_int) :: id1
       real(c_double) :: f1
       character(kind=c_char,len=1) :: str(3)
    end type bleh
    type(bleh), intent(inout) :: ss
    type(bleh), intent(in), value :: ssin

    character(len=3) :: fstr

    write (*,*) "in fortran: "
    write (*,*) ss%id1
    write (*,*) ss%f1
    fstr = ""
    call c_f_string(ss%str,fstr)
    write (*,*) trim(fstr)
    write (*,*) ssin%id1
    write (*,*) ssin%f1
    ss%id1 = 10
    ss%f1 = -80d0
    call f_c_string("cd",ss%str)

  end subroutine type_pointer

  ! pass an array of user-defined type
  subroutine type_pointer_array(ssempty,ssfull) bind(c)
    type, bind(c) :: bleh 
       integer(c_int) :: id1
       real(c_double) :: f1
       character(kind=c_char,len=1) :: str(3)
    end type bleh
    type(c_ptr), intent(inout) :: ssempty
    type(c_ptr), intent(inout) :: ssfull

    type(bleh), pointer :: ffull(:)
    type(bleh), pointer :: fempty(:)

    character(len=3) :: fstr
    integer :: i

    write (*,*) "associated ssfull: ", c_associated(ssfull)
    write (*,*) "associated ssempty: ", c_associated(ssempty)

    call c_f_pointer(ssfull,ffull,(/4/))
    write (*,*) "associated ffull: ", associated(ffull)
    write (*,*) "size ffull: ", size(ffull,1)
    write (*,*) "contents ffull: "
    do i = 1, 4
       write (*,*) "loop ", i
       write (*,*) "id1 ", ffull(i)%id1
       write (*,*) "f1 ", ffull(i)%f1
       write (*,*) "str ", ffull(i)%str
    end do

    allocate(fempty(4))
    write (*,*) "contents fempty: "
    do i = 1, 4
       fempty(i)%id1 = 100 * i
       fempty(i)%f1 = -100 * i**2
       fempty(i)%str = (/"a","h","!"/)
    end do
    ssempty = c_loc(fempty)

  end subroutine type_pointer_array

  subroutine prepare_host() bind(c)
    integer :: i

    if (allocated(mm)) deallocate(mm)
    nm = 3
    allocate(mm(nm))
    do i = 1, nm
       mm(i)%id1 = 2 * i
       mm(i)%f1 = i*200
       mm(i)%str = (/char(50+i),char(70+i),c_null_char/)
    end do
    mpoint = c_loc(mm(1))

  end subroutine prepare_host

end module fmod
