#include<iostream>
#include<fstream>
using namespace std;

short a[785];
ofstream rs("xx.bin",ios::binary);
void output(short a){
    rs.write((char*)(&a),sizeof(a));
}
int main(){
    ifstream finw("xx.txt");
    for (int j=0;j<784;j++) finw>>a[j];
	a[784]=1;
    for (int i=0;i<785;i++) output(a[i]);
    return 0;
}
