pkg load control
pkg load symbolic
clc
clear all
close all

s = tf('s');
h = (s^2)/(s^2+2666*s+3.553*10^6);
w0=sqrt(3.553)*10^3;
f0=w0/(2*pi);

leido = dlmread('/home/vero/Documentos/ADC/tp/bodedB.csv',' ');

frec = leido(1:end,1);
modulo = leido(1:end,2);
fase = leido(1:end,3);


[Modulo_ideal,fase_ideal, w_ideal] = bode(h);
Modulo_ideal_dB = 20*log10(Modulo_ideal);

%Configuracion de pantalla
posicion_pantalla= [0 0];
tamanio_imagen=[900 400];
figure(1, 'position',[posicion_pantalla,tamanio_imagen]);

%%%%%MODULO
subplot(1,2,1);
plot(w_ideal,Modulo_ideal_dB,"markersize", 10, "linewidth", 5);
hold on
plot(frec*2*pi,modulo)
title("Bode módulo ")
set(gca, 'XScale', 'log');


grid on
g=get (gcf, "currentaxes");
set(g,"fontweight","bold","linewidth",2)
xlabel("w_0 [rad/s]")
ylabel("|H(jw)| [dB]")
legend("ideal","estimada")
xlim([1e2 1e5])
ylim([-50 0])


%%%FASE
subplot(1,2,2);
plot(w_ideal,fase_ideal,"markersize", 10, "linewidth", 5);
hold on

plot(frec*2*pi,fase)
set(gca, 'XScale', 'log');
title("Bode fase")

grid on
g=get (gcf, "currentaxes");
set(g,"fontweight","bold","linewidth",2)
xlabel("w_0 [rad/s]")
ylabel("Arg(H(jw)) []")
legend("ideal","estimada")
ylim([0 180])
xlim([1e2 1e5])