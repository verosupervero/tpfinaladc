pkg load control
pkg load symbolic
clc
clear all
close all

s = tf('s');

%Configuracion de pantalla
posicion_pantalla= [0 0];
tamanio_imagen=[800 600];
figure()
#figure(1, 'position',[posicion_pantalla,tamanio_imagen]);


%%%%%%%%TRANSFERENCIA ORIGINAL
h = (s^2)/(s^2+2666*s+3.553*10^6);
[Modulo_ideal,fase_ideal, w_ideal] = bode(h);
Modulo_ideal_dB = 20*log10(Modulo_ideal);

%%%%%MODULO
subplot(3,2,1);
graficar_modulo_dB("Bode modulo transferencia ideal",w_ideal,Modulo_ideal_dB);
%%%FASE
subplot(3,2,3);
graficar_fase_dB("Bode fase transferencia ideal",w_ideal,fase_ideal);
%%%RESPUESTA AL ESCALON
subplot(3,2,5);
respuesta_al_escalon(h,"Respuesta al escalon transferencia ideal")

%%%%%%%%TRANSDERENCIA ESTIMADA
h_est=(s^2)/(s^2+2667*s+3.565*10^6);
[Modulo_ideal_2,fase_ideal_2, w_ideal_2] = bode(h_est);
Modulo_ideal_dB_2 = 20*log10(Modulo_ideal_2);

%%%%%MODULO
subplot(3,2,2);
graficar_modulo_dB("Bode modulo transferencia calculada",w_ideal_2,Modulo_ideal_dB_2,"r");
%%%FASE
subplot(3,2,4);
graficar_fase_dB("Bode fase transferencia calculada",w_ideal_2,fase_ideal_2,"r");
%%%RESPUESTA AL ESCALON
subplot(3,2,6);
respuesta_al_escalon(h_est,"Respuesta al escalon transferencia calculada","r")