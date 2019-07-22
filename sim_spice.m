pkg load control
pkg load symbolic
clc
clear all
close all

%Configuracion de pantalla
posicion_pantalla= [0 0];
tamanio_imagen=[600 500];
graphics_toolkit("gnuplot")
figure(1, 'position',[posicion_pantalla,tamanio_imagen]);

s = tf('s');

%%%%%%%%TRANSFERENCIA ORIGINAL
h = (s^2)/(s^2+2666*s+3.553*10^6);
[Modulo_ideal,fase_ideal, w_ideal] = bode(h);
Modulo_ideal_dB = 20*log10(Modulo_ideal);
%%%RESPUESTA AL ESCALON IDEAL
respuesta_al_escalon(h,"Respuesta al escalón")

leido = dlmread('/home/vero/Documentos/ADC/tp/respuesta_escalon.txt',',');
hold on
tiempos = leido(1:end,1);
tensiones = leido(1:end,2);
plot(tiempos,tensiones,"g","markersize", 1, "linewidth", 1);
xlim([0 4e-3])
ylim([-0.5 1])
legend("ideal","simulada")