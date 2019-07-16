pkg load control
pkg load symbolic
clc
clear all

%Colores para la terminal asi se ve mejor

RESET=  "\033[0m";;
BLACK=  "\033[30m";
RED=    "\033[31m";
GREEN=  "\033[32m";
ORANGE=  "\033[33m";
BLUE=  "\033[34m";
MAGENTA=  "\033[35m";
AZUL_CLARITO=  "\033[36m";


 function y = f(R)
  w0 = sqrt(3.553)*10^3;
  f0=w0/(2*pi);
  Q=w0/2666;
  C1_Norm = 10e-9;
  C2_Norm = 10e-9;
  y(1) = (1/(C1_Norm*C2_Norm*R(2)*R(1)))-w0^2;
  y(2) = sqrt(C1_Norm*C2_Norm*R(2)*R(1))/(R(1)*(C1_Norm+C2_Norm))-Q;

 endfunction

  %Calculamos las R por fsolve
  printf("\n\n");
  printf("%s ** Calculamos por fsolve los valores de las resistencias y su error ** %s \n",AZUL_CLARITO,RESET);
  printf("\n\n");
  [r, error] = fsolve ("f", [20e3;20e3])
 
  C1_Norm_elegida = 10e-9;
  C2_Norm_elegida = 10e-9;

  %normalizo los valores de R
  
  %Armo la serie e96 (me podría fijar en una tabla también)
  n=1:96;
  e96_serie_k=(round(10.^((n-1)/96)*100)/100)*10^4;
  e96_serie=e96_serie_k(e96_serie_k>4.7e3 & e96_serie_k<1.6e6);

  %seteo valores por default a r1 y a r2 para inicializarlas
  r1=0;
  r2=0;
  
  %busco el valor más próximo de resistencias al original
  error_resistencia_1=r(1)-e96_serie;
  [valor_error_r1,indice_r1]=min(abs(error_resistencia_1));
  if (valor_error_r1<r(1)/10)
    r1=e96_serie(indice_r1);
  else
    printf("%s No cambia el valor de R2, hay algún problema en el valor %s",RED,RESET);
  endif
  
  error_resistencia_2=r(2)-e96_serie;
 [valor_error_r2,indice_r2]=min(abs(error_resistencia_2));
  if (valor_error_r2<r(2)/10)
   r2=e96_serie(indice_r2);
  else
    printf("%s No cambia el valor de R2, hay algún problema en el valor %s",RED,RESET);
  endif
  
  %Muestro cuáles valores son y los que calcule previamente
  printf("%s ** Normalizamos los valores de las resistencias para E96 ** %s \n",AZUL_CLARITO,RESET);
  printf("\n\n");
  printf("%s <-------------------R1---------------------> %s \n",GREEN,RESET);
  printf("R1 normalizado:%s %.3g Ohm %s\n",GREEN,r1,RESET);
  printf("R1 calculado numéricamente:%s %.4g Ohm %s\n",MAGENTA,r(1),RESET);
  printf("%s <------------------------------------------> %s \n",GREEN,RESET);

  printf("\n\n");
  printf("%s <-------------------R2---------------------> %s \n",GREEN,RESET);
  printf("R2 normalizado:%s %.3g Ohm %s\n",GREEN,r2,RESET);
  printf("R2 calculado numéricamente::%s %.4g Ohm %s\n",MAGENTA,r(2),RESET);
  printf("%s <------------------------------------------> %s \n",GREEN,RESET);
  
  
  w0_cuadrado_estim=(1/(C1_Norm_elegida*C2_Norm_elegida*r2*r1));
  Q_estim= sqrt(C1_Norm_elegida*C2_Norm_elegida*r2*r1)/(r1*(C1_Norm_elegida+C2_Norm_elegida));
  wo_sobre_Q_estim=sqrt(w0_cuadrado_estim)/Q_estim;
  printf("\n\n");
  
  printf("%s ** Mostramos las transferencias ** %s \n",AZUL_CLARITO,RESET);
  printf("\n\n");
  %muestro la transferencia original
  s = tf('s');
  printf("%s Transferencia original: %s \n",ORANGE,RESET);
  h = (s^2)/(s^2+2666*s+3.553*10^6)
  printf("\n\n");
  %muestro la transferencia obtenida
  printf("%s Transferencia obtenida con los valores normalizados: %s \n",ORANGE,RESET);
  h2 = (s^2)/(s^2+wo_sobre_Q_estim*s+w0_cuadrado_estim)




  
