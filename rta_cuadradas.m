pkg load control
clc
clear all
close all
s = tf('s');
h = (s^2)/(s^2+2666*s+3.553*10^6);
w0=sqrt(3.553)*10^3;
f0=w0/(2*pi);
markersize=2;
linewidth=3;
[cuad,t] = gensig("SQUARE" , 10/f0 , 70/f0);  %armo mi cuadrada de periodo 10/fo y duracion 5 periodos
[V1,t1] = lsim(h,cuad,t); % respuesta al filtro
%Configuracion de pantalla
posicion_pantalla= [0 0];
tamanio_imagen=[700 650];
figure(1, 'position',[posicion_pantalla,tamanio_imagen]);

subplot(3,1,1);
plot(t1,V1,"markersize", markersize, "linewidth", linewidth)
xlabel("Tiempo [s]")
ylabel("Tension [V]")
title("Respuesta a la cuadrada f=f0/10")
grid on

% Defino una cuadrada con T= 1/f0 y dura 7 periodos

[cuad,t] = gensig("SQUARE" , 1/f0 , 7/f0); 
[V2,t2] = lsim(h,cuad,t);
subplot(3,1,2);
plot(t2,V2,"markersize", markersize, "linewidth", linewidth)
xlabel("Tiempo [s]")
ylabel("Tension [V]")
title("Respuesta a la cuadrada f=f0")
grid on

% Defino una cuadrada con T= 1/(10*f0) (frec 10 f0) y dura 10 periodos
[cuad,t] = gensig("SQUARE" , 1/(10*f0) , 10/(10*f0)); 

[V3,t3] = lsim(h,cuad,t);
subplot(3,1,3);
plot(t3,V3,"markersize", markersize, "linewidth", linewidth)
xlabel("Tiempo [s]")
ylabel("Tension [V]")
title("Respuesta a la cuadrada f=10*fo")
grid on
print -color -depsc respuesta_distintas_cuadradas.eps
