function respuesta_al_escalon(h,string="Respuesta al escalon",color="b")
    [Y_step_ideal,T_step_ideal] = step(h);
    plot(T_step_ideal, Y_step_ideal,"markersize", 2, "linewidth", 2,"color",color)
    title(string)
    xlabel ("Tiempo [s]");
    ylabel ("Tension [V]");
    grid on
    grid minor on
endfunction