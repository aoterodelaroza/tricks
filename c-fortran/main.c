#include <stdio.h>
#include <stdlib.h>
#include <fmod.h>
#include <math.h>
#include <stdbool.h>
#include <string.h>

int main(int argc,char **argv)
{
/*
  hello();
  printf("****\n\n");
*/

/*
  int cin, cout, csame, cresult;
  cin = 1;
  csame = 10;
  printf("C - integers on input: %d %d\n",cin,csame);
  cresult = integer_scalar_types(cin, &cout, &csame);
  printf("C - integers on output: %d %d\n",cout,csame);
  printf("C - function result: %d\n",cresult);
  printf("****\n\n");
*/  

/*
  double fin, fout, fsame, fresult;
  fin = 5.2;
  fsame = 10.3;
  printf("C - reals on input: %f %f\n",fin,fsame);
  fresult = real_scalar_types(fin, &fout, &fsame);
  printf("C - reals on output: %f %f\n",fout,fsame);
  printf("C - function result: %f\n",fresult);
  printf("****\n\n");
*/

/*  
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
*/

/*
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
*/

/*
  int n = 3;
  double x1[n];
  double x2[n][n];
  double x3[n][n][n];
  int i, j, k;
  for (i=0;i<n;i++){
    x1[i] = -i;
    for (j=0;j<n;j++){
      x2[i][j] = -i;
      for (k=0;k<n;k++){
	x3[i][j][k] = -i;
      }
    }
  }
  array_arguments(n,x1,x2,x3);
  printf("In C:\n");
  for (i=0;i<n;i++){
    printf("%.10f\n",x1[i]);
    for (j=0;j<n;j++){
      printf("%.10f\n",x2[i][j]);
      for (k=0;k<n;k++){
	printf("%.10f\n",x3[i][j][k]);
      }
    }
  }
*/

/*
  int n = 3;
  double *xfull, *xempty;
  xfull = (double *) malloc(sizeof(double)*n);
  xempty = NULL;
  int i;
  for (i=0;i<n;i++)
    xfull[i] = -i;

  printf("xfull address: %p\n",xfull);
  printf("xempty address: %p\n",xempty);
  array_arguments_pointer(&xfull,&xempty);
  printf("xfull address: %p\n",xfull);
  printf("xempty address: %p\n",xempty);

  printf("In C, value of xempty:\n"); 
  for (i=0;i<5;i++)
    printf("%.10f\n",xempty[i]); 
  free(xempty); 
*/

/*
  int i, j;
  int n1 = 3, n2 = 4;
  double *xfull, *xempty;
  xfull = (double *) malloc(sizeof(double)*n1*n2);

  for (i=0;i<n1;i++){
    for (j=0;j<n2;j++){
      xfull[i*n2+j] = i+j;
      printf("%d %d %.10f\n",i,j,xfull[i*n2+j]);
    }
  }

  xempty = NULL;

  printf("xfull address: %p\n",xfull);
  printf("xempty address: %p\n",xempty);
  array2_arguments_pointer(&xfull,&xempty);
  printf("xfull address: %p\n",xfull);
  printf("xempty address: %p\n",xempty);

  printf("In C, value of xempty:\n"); 
  for (i=0;i<4;i++)
    for (j=0;j<3;j++)
      printf("%d %d %.10f\n",i,j,xempty[i*3+j]); 
  free(xempty); 
*/

/*
  struct stype ss, ssin;
  ss.id1 = 2;
  ss.f1 = 1.0;
  strncpy(ss.str,"ab",2);
  ss.str[2] = '\0'; // prevent buffer overrun
  ssin.id1 = 200;
  ssin.f1 = 100.0;

  printf("In C before:\n");
  printf("%d %.10f\n",ss.id1,ss.f1);
  type_pointer(&ss,ssin);
  printf("In C after:\n");
  printf("%d %.10f %s\n",ss.id1,ss.f1,ss.str);
*/

/*
  int i, n = 4;
  struct stype *ssempty, *ssfull;
  ssfull = (struct stype *) malloc(sizeof(struct stype)*n);
  ssempty = NULL;

  for (i=0;i<n;i++){
    ssfull[i].id1 = i;
    ssfull[i].f1 = i*10.0;
    strncpy(ssfull[i].str,"bleh",2);
    ssfull[i].str[2] = '\0'; // prevent buffer overrun
  }
  printf("In C before:\n");
  for (i=0;i<n;i++){
    printf("Number: %d\n",i);
    printf("id1: %d\n",ssfull[i].id1);
    printf("f1: %f\n",ssfull[i].f1);
    printf("str: %s\n",ssfull[i].str);
  }
  type_pointer_array(&ssempty,&ssfull);
  printf("In C after:\n");
  for (i=0;i<n;i++){
    printf("Number: %d\n",i);
    printf("id1: %d\n",ssempty[i].id1);
    printf("f1: %f\n",ssempty[i].f1);
    printf("str: %s\n",ssempty[i].str);
  }
*/

  int i;
  prepare_host();
  printf("nm %d\n",nm);
  for (i=0;i<nm;i++){
    printf("Number: %d\n",i);
    printf("pointer: %p\n",mm);
    printf("id1: %d\n",mm[i].id1);
    printf("f1: %f\n",mm[i].f1);
    printf("str: %s\n",mm[i].str);
  }

  return 0;
}

