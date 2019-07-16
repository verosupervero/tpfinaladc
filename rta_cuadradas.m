pkg load control
clc
clear all
close all
s = tf('s');
h = (s^2)/(s^2+2666*s+3.553*10^6);
w0=sqrt(3.553)*10^3;
f0=w0/(2*pi);

[cuad,t] = gensig("SQUARE" , 10/f0 , 70/f0);  %armo mi cuadrada de periodo 10/fo y duracion 5 periodos
[V1,t1] = lsim(h,cuad,t); % respuesta al filtro
figure()
plot(t1,V1,"markersize", 10, "linewidth", 5)
xlabel("Tiempo [s]")
ylabel("Tension [V]")
title("Respuesta a la cuadrada f=f0/10")
grid on


% Defino una cuadrada con T= 1/f0 y dura 7 periodos

[cuad,t] = gensig("SQUARE" , 1/f0 , 7/f0); 
[V2,t2] = lsim(h,cuad,t);
figure()
plot(t2,V2,"markersize", 10, "linewidth", 5)
xlabel("Tiempo [s]")
ylabel("Tension [V]")
title("Respuesta a la cuadrada f=f0")
grid on

% Defino una cuadrada con T= 1/(10*f0) (frec 10 f0) y dura 10 periodos
[cuad,t] = gensig("SQUARE" , 1/(10*f0) , 10/(10*f0)); 

[V3,t3] = lsim(h,cuad,t);
figure()
plot(t3,V3,"markersize", 10, "linewidth", 5)
xlabel("Tiempo [s]")
ylabel("Tension [V]")
title("Respuesta a la cuadrada f=10*fo")
grid on