pkg load control
pkg load symbolic
clc
clear all
close all

s = tf('s');


h = (s^2)/(s^2+2666*s+3.553*10^6);
graphics_toolkit("gnuplot");
setenv ("GNUTERM", "qt")

%Configuracion de pantalla
posicion_pantalla= [0 0];
tamanio_imagen=[800 600];
figure(1, 'position',[posicion_pantalla,tamanio_imagen]);


%Obtenemos el bode
[Modulo_ideal,fase_ideal, w_ideal] = bode(h);
w_ideal(1)
Modulo_ideal_dB = 20*log10(Modulo_ideal);

%Graficamos
subplot(2,1,1);
graficar_modulo_dB("Bode módulo transferencia ideal",w_ideal,Modulo_ideal_dB);
subplot(2,1,2);
graficar_fase_dB("Bode fase transferencia ideal",w_ideal,fase_ideal);