module fmod
  use c_interface_module
  implicit none

  public

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

end module fmod
