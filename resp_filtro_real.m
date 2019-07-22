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


%%%%%MODULO LTSPICE
frec_spice = leido(1:end,1);
Mod_spice = leido(1:end,2);
fase = leido(1:end,3);
plot(frec_spice*2*pi,Mod_spice,"y","markersize", 2, "linewidth", 2);
legend("filtro real","transferencia con valores comerciales","simulacion en ltspice","location", "east")
ylim([-36 max(tensiones_db)+2])

%%curva polinomica
tensiones_db
p = polyfit(log(frec_ang(6:10,:)),tensiones_db(6:10,:),1);
y1 = polyval(p,log(frec_ang));
plot(frec_ang,y1,"markersize", 2, "linewidth", 2)
