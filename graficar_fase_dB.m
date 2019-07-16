function graficar_fase_dB (string,w_ideal,fase_ideal,color="b")
  semilogx(w_ideal,fase_ideal,"markersize", 10, "linewidth", 5,"color",color)
  xlabel("w_0 [rad/s]")
  ylabel("Arg(H(jw)) []")
  title(string)
  grid on
  g=get (gcf, "currentaxes");
  set(g,"fontweight","bold","linewidth",2)
endfunction
