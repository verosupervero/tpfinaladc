clear all,clf, clc,tic
%graphics_toolkit gnuplot %use this for now it's older but allows zoom
freq=[20,30,40,50,60,70,80];
amp_orig=[2,4,3,7,1,8,4];
amp_inv=[6,4,5,1,7,0,4];


plot(freq,amp_orig,'-bo')
hold on
plot(freq,amp_inv,'-r*')
xlabel ("Frequency");
ylabel ("Amplitude");
[x0,y0,iout,jout] = intersections(freq,amp_orig,freq,amp_inv)