program wcharexample
  use ncurses
  use iso_c_binding
  implicit none

  interface
     subroutine dolocale() bind(c)
     end subroutine dolocale
  end interface

  type(c_ptr) :: screen
  integer :: istat, ich
  integer*4, target :: msg(2)

  call dolocale()
  screen = initscr()
  istat = start_color()
  istat = cbreak()
  istat = noecho()
  istat = curs_set(0)

  msg = 0
  msg(1) = z'00a5'
  istat = mvaddwstr(2,2,c_loc(msg))
  istat = refresh()
  ich = getch()
  istat = endwin()

end program wcharexample
