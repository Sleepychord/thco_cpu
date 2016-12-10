#include<iostream>
#include<fstream>
using namespace std;

int a[10][785];
int b[785],c[10]={0};
int main(){
    ifstream finw("mat_w.txt");
    ifstream finb("mat_b.txt");
    for (int i=0;i<10;i++)
        for (int j=0;j<784;j++) finw>>a[i][j];
    for (int i=0;i<10;i++) finb>>a[i][784];


    ifstream fin("xx.txt");
    for (int j=0;j<784;j++) fin>>b[j];
    b[784]=1;

for (int i=0;i<10;i++)
  for (int j=0;j<785;j++) c[i]+=b[j]*a[i][j];
for (int i=0;i<10;i++)
cout<<hex<<c[i]<<endl;


return 0;
}
