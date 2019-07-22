clear all 
close all
clc
pkg load signal
pkg load symbolic
s = tf('s');
graphics_toolkit("gnuplot");
setenv ("GNUTERM", "qt")
leido = dlmread('/home/vero/Documentos/ADC/tp/img/mediciones/mediciones.csv',',');

frec = leido(1:end,1);
frec_ang=2*pi*frec
vout = leido(1:end,2)*10^(-3);

%Configuracion de pantalla
posicion_pantalla= [0 0];
tamanio_imagen=[900 400];
figure(1, 'position',[posicion_pantalla,tamanio_imagen]);

%%%%%MODULO
vi=0.972;
h=vout/vi
tensiones_db=20*log10(h);
plot(frec_ang,tensiones_db,'bo-',"markersize", 3, "linewidth", 3);

%%%%%%%%TRANSDERENCIA ESTIMADA
h_est=(s^2)/(s^2+2667*s+3.565*10^6);
[Modulo_ideal_2,fase_ideal_2, w_ideal_2] = bode(h_est);
Modulo_ideal_dB_2 = 20*log10(Modulo_ideal_2);

%%%%%MODULO
hold on
graficar_modulo_dB("Bode módulo transferencia",w_ideal_2,Modulo_ideal_dB_2,"r");
xlim([2*pi*30 2*pi*3000])


leido = dlmread('/home/vero/Documentos/ADC/tp/bodedB.csv',' ');


%%curva polinomica
w_pendiente=200:1:20000;
p = polyfit(log(frec_ang(6:8,:)),tensiones_db(6:8,:),1)
p2 = polyfit(log(frec_ang(6:8,:)),zeros(size(tensiones_db(6:8,:))),1);
recta_pendiente_1 = polyval(p,log(w_pendiente));
recta_0_dB = polyval(p2,log(frec_ang));

plot(w_pendiente,recta_pendiente_1, "m","markersize", 2,"linewidth", 2)
plot(frec_ang,recta_0_dB, "m","markersize", 2,"linewidth", 2)

ylim([-40 10])
legend("filtro real","transferencia con valores comerciales","location", "east")

%encuentro fo
printf("hallo wc y fc:\n")

cero_minimo=min(abs(recta_pendiente_1)) %error en tercera cifra
indice_wo=find(recta_pendiente_1==cero_minimo);
wo_hallado=w_pendiente(indice_wo)
fo_hallado=wo_hallado/(2*pi)

%Hallo frecuencias a -3dB

p_mediciones= polyfit(log(frec_ang),tensiones_db,7);
recta_p_mediciones = polyval(p_mediciones,log(w_pendiente));
%plot(w_pendiente,recta_p_mediciones, "k","markersize", 2,"linewidth", 2)
printf("hallo el valor mas cercano a 3 dB,wo y fo:\n")

tres=recta_p_mediciones(recta_p_mediciones>-3);
menos_3_dB=min(tres)
indice_wo=find(recta_p_mediciones==menos_3_dB);
wo_hallado_m=w_pendiente(indice_wo)
fo_hallado_m=wo_hallado/(2*pi)

%hallar Q
printf("hallo el pico y Q:\n")
indice_w_pico=find(w_pendiente==wo_hallado);
pico=recta_p_mediciones(indice_w_pico)
Q=exp(pico/20)
