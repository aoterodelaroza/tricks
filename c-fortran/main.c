#include <stdio.h>
#include <stdlib.h>
#include <fmod.h>
#include <math.h>
#include <stdbool.h>
#include <string.h>

int main(int argc,char **argv)
{
  hello();
  printf("****\n\n");

  int cin, cout, csame, cresult;
  cin = 1;
  csame = 10;
  printf("C - integers on input: %d %d\n",cin,csame);
  cresult = integer_scalar_types(cin, &cout, &csame);
  printf("C - integers on output: %d %d\n",cout,csame);
  printf("C - function result: %d\n",cresult);
  printf("****\n\n");
  
  double fin, fout, fsame, fresult;
  fin = 5.2;
  fsame = 10.3;
  printf("C - reals on input: %f %f\n",fin,fsame);
  fresult = real_scalar_types(fin, &fout, &fsame);
  printf("C - reals on output: %f %f\n",fout,fsame);
  printf("C - function result: %f\n",fresult);
  printf("****\n\n");
  
  float complex cmplxin, cmplxout, cmplxsame, cmplxresult;
  cmplxin = 3. + 4. * I;
  cmplxsame = 5. + 7. * I;
  printf("C - complex on input: %f+%f i\n",creal(cmplxin),cimag(cmplxin));
  printf("C - complex on input: %f+%f i\n",creal(cmplxsame),cimag(cmplxsame));
  cmplxresult = complex_scalar_types(cmplxin, &cmplxout, &cmplxsame);
  printf("C - complex on output: %f %f\n",creal(cmplxout),cimag(cmplxout));
  printf("C - complex on output: %f %f\n",creal(cmplxsame),cimag(cmplxsame));
  printf("C - function result: %f %f\n",creal(cmplxresult),cimag(cmplxresult));
  printf("****\n\n");

  char *sin, *sout, *sinout, *sres;
  sin = "abcde";
  sinout = (char *) malloc(sizeof(char)*5);
  strncpy(sinout, "fghi", 5);
  printf("C - string on input: %s\n",sin);
  printf("C - string on input (i/o): %s\n",sinout);
  sres = string_types(&sin,&sout,&sinout);
  printf("C - string on output: %s\n",sout);
  printf("C - string on output (i/o): %s\n",sinout);
  printf("C - function result: %s\n",sres);
  free(sres);
  free(sinout);
  printf("****\n\n");

  return 0;
}

