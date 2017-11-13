rm(list=ls(all=T))
library(inline)

d1=read.table("depth1organizeddata_BCHEUR_2017-06-24_2017-07-31.txt", sep=",",header=T)
d1$timestamp=as.POSIXlt(c(d1[,1]),origin="1970-01-01")

src<-'
using namespace std;
using namespace Rcpp;
NumericVector v0(r0);
int n1=as<int>(k1);

int l0=v0.size();
NumericVector v1(l0-1);
for (int i=0; i<(l0-1); i++)
{
  v1[i]=log(v0[i+1])-log(v0[i]);
}

int l1=v1.size();
NumericVector bv1(l1-n1);
NumericVector rv1(l1-n1);

for (int i=0;i<(l1-n1);i++)
{
  double t1=0.0, t2=0.0;
  for (int j=0; j<(n1-1); j++)   
  {
  t1=+abs(v1[i+j])*abs(v1[i+j]);
  t2=+abs(v1[i+j])*abs(v1[i+j+1]);
  }
  rv1[i]=t1;
  bv1[i]=t2;
}

return List::create(Named("RV")=rv1,Named("BV")=bv1);
'
rb1<-cxxfunction(signature(r0 = "numeric", k1 = "int"), src, plugin = "Rcpp")


