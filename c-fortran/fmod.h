#include <complex.h>
#include <stdbool.h>

struct stype {
  int id1;
  double f1;
  char str[3];
};

// host association from fmod.f90
int nm;
struct stype *mm;

void hello();
int integer_scalar_types(int cint,int *cintp1,int *csame);
double real_scalar_types(double cint,double *cintp1,double *csame);
float complex complex_scalar_types(float complex cint,float complex *cintp1,float complex *csame);
_Bool logical_scalar_types(_Bool cint,_Bool *cintp1,_Bool *csame);
char *string_types(char **sin, char **sout, char **sinout);
void array_arguments(int n, double x1[n],double x2[n][n],double x3[n][n][n]);
void array_arguments_pointer(double **xfull,double **xempty);
void array2_arguments_pointer(double **xfull,double **xempty);
void type_pointer(struct stype *ss, struct stype ssin);
void type_pointer_array(struct stype **ssempty,struct stype **ssfull);
void prepare_host();
