%RESPUESTA AL IMPULSO

%graficamos la respuesta al impulso, necesitaremos de un truco,
% definiremos un polo que no existe de forma de limitar el ancho de banda. 
% Lo hacemos así porque a respuesta a la delta tiene una delta.
pkg load control
clc
clear all
close all

s = tf('s');
h = (s^2)/(s^2+2666*s+3.553*10^6);
graphics_toolkit("gnuplot");
setenv ("GNUTERM", "qt")
close all
h_trucha=h/(s+10e4);
[Y_impulse_ideal,T_impulse_ideal] = impulse(h_trucha);
figure()
plot(T_impulse_ideal, Y_impulse_ideal,"markersize", 10, "linewidth", 3)
title("Respuesta al impulso transferencia ideal")
xlabel ("Tiempo [s]");
ylabel ("Tension [V]");
grid on
grid minor on