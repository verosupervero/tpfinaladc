%Configuracion de pantalla
posicion_pantalla= [0 0];
tamanio_imagen=[800 600];
figure(1, 'position',[posicion_pantalla,tamanio_imagen]);


%Obtenemos el bode
[Modulo_ideal,fase_ideal, w_ideal] = bode(h);
Modulo_ideal_dB = 20*log10(Modulo_ideal);

%Graficamos
subplot(2,1,1);
graficar_modulo_dB("Bode modulo transferencia ideal",w_ideal,Modulo_ideal_dB);
subplot(2,1,2);
graficar_fase_dB("Bode fase transferencia ideal",w_ideal,fase_ideal);