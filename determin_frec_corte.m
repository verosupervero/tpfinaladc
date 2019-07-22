clear all
close all
clc
leido = dlmread('/home/vero/Documentos/ADC/tp/img/mediciones/mediciones.csv',',');

frec = leido(1:end,1)
vout = leido(1:end,2)*10^(-3);
vi=0.972;
h=vout/vi

H_ideal= @(s,wo,Q) s./(s.^2+(wo/Q)*s+wo^2)
H_ideal(1j*frec,2*pi*300, 0.707)

ecm= @(wo,Q) norm(h-abs(H_ideal(1j*2*pi*frec,wo,Q)))
ecm(2*pi*300,0.707)
ecm(2*pi*300,0.70)
ecm(2*pi*300,0.3)
ecm(2*pi*300,0.5)

ecmwrapper =@(x) ecm(x(1),x(2))*(1+1e100*(abs(x(1)-2*pi*300)>500)+1e100*(abs(x(2)-0.7)<0.8))
xo=[2*pi*200, 0.5]
x=fminsearch(ecmwrapper,xo)
