%%%%%%  first subplot  %%%%%%
subplot("position",[.15 0.13 .4 .8])
x=0:.1:30;
plot(x,sin(x),"linewidth",4)
set(gca,'xtick',[0 10 20 30])
box("off")
xlabel("x","fontweight","bold")
%ylabel
h=text(-8,-.12,"sin(x)")
set(h,"fontweight","bold","rotation",90)
%get axes handle to use for setting properties
h=get (gcf, "currentaxes");
set(h,"fontweight","bold","linewidth",2)
 
%%%%%%  second subplot  %%%%%%
subplot("position",[.7 0.13 .2 .8])
x=0:.1:4;
plot(x,exp(x),"linewidth",4)
set(gca,'xtick',[0 1 2 3])
box("off")
xlabel("x","fontweight","bold")
ylabel("exp(x)","fontweight","bold")
%get axes handle to use for setting properties
h=get (gcf, "currentaxes");
set(h,"fontweight","bold","linewidth",2)