 pkg load control
 clc
 clear all
 close all
 s = tf('s');
 h = (s^2)/(s^2+2666*s+3.553*10^6);
 [p,z]= pzmap2(h)
 pzmap2(h)

 text(real(p) - 0.02* real(p), imag(p),num2str(p))
 text(-100, 0,"0+0i")
 print -dsvg polos_y_ceros_transferencia_original.svg
 print -color -depsc polos_y_ceros_transferencia_original.eps