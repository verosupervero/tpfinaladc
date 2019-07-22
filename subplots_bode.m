pkg load control
pkg load symbolic
clc
clear all
close all

s = tf('s');

%Configuracion de pantalla
posicion_pantalla= [0 0];
tamanio_imagen=[500 400];
graphics_toolkit("gnuplot");
setenv ("GNUTERM", "qt")
figure(1, 'position',[posicion_pantalla,tamanio_imagen]);

%%%%%%%%TRANSFERENCIA ORIGINAL
h = (s^2)/(s^2+2666*s+3.553*10^6);
[Modulo_ideal,fase_ideal, w_ideal] = bode(h);
Modulo_ideal_dB = 20*log10(Modulo_ideal);


%%%%%%%%TRANSDERENCIA ESTIMADA
h_est=(s^2)/(s^2+2667*s+3.565*10^6);
[Modulo_ideal_2,fase_ideal_2, w_ideal_2] = bode(h_est);
Modulo_ideal_dB_2 = 20*log10(Modulo_ideal_2);


%%%%%MODULO
graficar_modulo_dB("Bode módulo",w_ideal,Modulo_ideal_dB);
hold on
graficar_modulo_dB("Bode módulo",w_ideal_2,Modulo_ideal_dB_2,"g");
legend("real","obtenida")
hold off
%print -color -depsc bode_modulo_estimada_real.eps
print("bode_modulo_estimada_real.eps", "-depscairo")
##
##%%%FASE
##graficar_fase_dB("Bode fase",w_ideal,fase_ideal);
##hold on
##graficar_fase_dB("Bode fase ",w_ideal_2,fase_ideal_2,"g");
##legend("real","obtenida")
##print("bode_fase_estimada_real.eps", "-depscairo")


##
##%%%RESPUESTA AL ESCALON
##respuesta_al_escalon(h,"Respuesta al escalón")
##hold on;
##respuesta_al_escalon(h_est,"Respuesta al escalón","g")
##legend("real","obtenida")
##print -color -depsc bode_escalon_estimado_real.eps
##print("bode_escalon_estimado_real.eps", "-depscairo")
