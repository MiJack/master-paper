#include<stdio.h>
#include<stdlib.h>
#include<time.h>
#include<math.h>
/*
int Random(int t,int fw)
{
	srand(time(t));
	return rand()%fw;
}
*/

int Random(int fw)
{
	//srand((unsigned) time(NULL)); //用时间做种，每次产生随机数不一样
	srand(time(NULL));
	return rand()%fw;
}
/*
double Drand()//drand（）产生0～1之间的随机数
{
float x;
int i;
for(i=0;i<20;i++)rand();
x=rand();
x=65539*x+1743251541;
x=fmod(x,2147483638);
return(x/2147483638);
}

double Exponen(double fl)// 产生负指数分布的随机数
{
double v,u;
u=Drand();
v=-fl*log(u);
return v;
}

float poissn(float la)//poissn（）产生泊松分布随机数
{
int k=0;
float b,t=1.0f,r;
b=exp(-la);
while((t-b)>=0)
{
r=Drand();
t=t*r;
k=k+1;
}
return k;
}

float pgauss(float k,float j)//pgauss（）产生正态分布随机数
{
float v1,v2,s,w,y,sg[2];
do{v1=Drand();
   v2=Drand();
   s=v1*v1+v2*v2;
   }
while(s>=1);
w=sqrt(-2.0*log(s)/s);
sg[0]=v1*w;
sg[1]=v2*w;
y=k*(sg[0]+sg[1])/2+j;
return y;
}
*/
double Gaussian(double x){
	 double PI=3.1415926535897;
	 long double w,y=0,z,sum=0,b=1; 
     int n=1,a=1,m=1; 
     while(n<101)   //101决定最后结果的误差
     { 
         w=pow(x,n); 
         z=a*w/(b*n); 
         y+=z ; 
         a*=-1 ; 
         b*=2*m ; 
         //printf("%30.25f\n%d!!=%30.25f\n",z,2*m,b); //用于查看中途计算出得数据;
         m++; 
         n+=2 ; 
     } 
     sum=0.5+y/sqrt(2*PI); 
     return sum;
}
//返回结果下标从1开始
int Random(double a[],int len,int n)
{
	return 1;
	int t=1;
	while(n-->0)
		t*=10;
	int res=Random(t)+1;
	double sum=a[0]*t;
	int i;
	for(i=1;i<len;i++)
		if(sum>=res) break;
		else sum+=a[i]*t;
	return i;
}
 
