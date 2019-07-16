function graficar_modulo_dB (string,w_ideal,Modulo_ideal_dB,color="b")
  semilogx(w_ideal,Modulo_ideal_dB, "markersize", 10, "linewidth", 5,"color",color)
  xlabel("w_0 [rad/s]")
  ylabel("|H(jw)| [dB]")
  title(string)
  grid on
  g=get (gcf, "currentaxes");
  set(g,"fontweight","bold","linewidth",2)
endfunction
