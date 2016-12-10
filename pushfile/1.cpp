#include<iostream>
#include<fstream>
using namespace std;

short a[10][785];
ofstream rs("mat.bin",ios::binary);
void output(short a){
    rs.write((char*)(&a),sizeof(a));
}
int main(){
    ifstream finw("mat_w.txt");
    ifstream finb("mat_b.txt");
    for (int i=0;i<10;i++)
        for (int j=0;j<784;j++) finw>>a[i][j];
    for (int i=0;i<10;i++) finb>>a[i][784];
    for (int i=0;i<785;i++)
        for (int j=0;j<10;j++) output(a[j][i]);
    return 0;
}
