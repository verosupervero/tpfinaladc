pkg load control
pkg load symbolic
clc
clear all
close all

s = tf('s');
h = (s^2)/(s^2+2666*s+3.553*10^6);
w0=sqrt(3.553)*10^3;
f0=w0/(2*pi);

%Creo una función para generar la onda cuadrada así no repito 3 veces el mismo código
function generar_onda_cuadrada(h,periodo , duracion_en_periodos, titulo)
    [cuad,t] = gensig("SQUARE" , periodo , periodo*duracion_en_periodos,periodo/500);  %armo mi cuadrada de periodo 10/fo y duracion 5 periodos
    [V1,t1] = lsim(h,cuad,t); % respuesta al filtro
    plot(t1,V1,"markersize", 2, "linewidth", 2)
    xlabel("Tiempo [s]")
    ylabel("Tension [V]")
    title(titulo)
    grid on
endfunction

function plotear_de_csv(archivo,separador,delay=0)
    leido = dlmread(archivo,',');
    hold on
    tiempos = leido(1:end,1);
    tensiones = leido(1:end,2);
    plot(tiempos+delay,tensiones,"g");
endfunction

%Configuracion de pantalla
posicion_pantalla= [0 0];
tamanio_imagen=[900 400];
figure(1, 'position',[posicion_pantalla,tamanio_imagen]);

%Armo mi cuadrada de periodo 10/fo y duracion 7 periodos
subplot(3,1,1);
generar_onda_cuadrada(h,10/f0 , 7,"Respuesta a la cuadrada f=f0/10");  
plotear_de_csv('/home/vero/Documentos/ADC/tp/rta_cuadrada_30_Hz.txt',',');
xlim([0.005 10/f0])
legend("ideal","simulada")

% Defino una cuadrada con T= 1/f0 y dura 7 periodos
subplot(3,1,2);
generar_onda_cuadrada(h,1/f0 , 7,"Respuesta a la cuadrada f=f0");
plotear_de_csv('/home/vero/Documentos/ADC/tp/rta_cuadrada_300_Hz.txt',',');
xlim([0.005 7/f0])
legend("ideal","simulada")


% Defino una cuadrada con T= 1/(10*f0) (frec 10 f0) y dura 10 periodos
subplot(3,1,3);
generar_onda_cuadrada(h,1/(10*f0) , 10,"Respuesta a la cuadrada f=10*fo"); 
plotear_de_csv('/home/vero/Documentos/ADC/tp/rta_cuadrada_3000_Hz.txt',1/(10*f0));
legend("ideal","simulada")

