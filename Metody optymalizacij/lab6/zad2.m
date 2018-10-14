clc, clear all, close all


K = [-1 -1;
     -1 -1];
K1=DokladnaOptymalizacja(K)
Bieguny1 = FunkcjaCelu(K1)
K = [-1 2;
     3 -1];
K2=DokladnaOptymalizacja(K)
Bieguny2 = FunkcjaCelu(K2)
K = [3 3;
     -2 1];
K3=DokladnaOptymalizacja(K)
Bieguny3 = FunkcjaCelu(K3)
 