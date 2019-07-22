function graficar_modulo_dB (string,w_ideal,Modulo_ideal_dB,color="b")
  semilogx(w_ideal,Modulo_ideal_dB, "markersize", 5, "linewidth", 3,"color",color)
  xlabel("w_0 [rad/s]")
  ylabel("|H(jw)| [dB]")
  title(string)
  grid on
endfunction
