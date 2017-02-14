/*
  Routines that to be called from the fortran program (fortran_uses_c).
*/
#include <stdio.h>
#include <string.h>

// Simple routine with no arguments and no return value
void fun1() {
  printf(" ...world!\n");
  return;
}

// Pass integer arguments by reference and value - return an integer value
int int1(int i1, int *i1r) {
  
  *i1r = i1 + 10;
  *i1r = *i1r + 2;
  printf(" in C: i1 = %d, i1r = %d\n",i1,*i1r);
  
  return (*i1r + 4);
}

// Pass string arguments
void str1(char *astr,char **ostr) {
  
  *ostr = "Hello, world!";
  printf(" in C: %s | %s\n",astr,*ostr);
  return;
}
