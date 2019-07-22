function graficar_fase_dB (string,w_ideal,fase_ideal,color="b")
  semilogx(w_ideal,fase_ideal,"markersize", 5, "linewidth", 3,"color",color)
  xlabel("w_0 [rad/s]")
  ylabel("Arg(H(jw)) []")
  title(string)
  grid on
endfunction
