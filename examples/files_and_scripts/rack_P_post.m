%BWS
%May 2005
%Post-processing an analysis
%
clear all
close all
%
currentlocation=['c:\ben\cufsm\cufsm_working\cufsm3\source'];
addpath([currentlocation]);
addpath([currentlocation,'\analysis']);
addpath([currentlocation,'\analysis\GBTconstraints']);
addpath([currentlocation,'\helpers']);
addpath([currentlocation,'\interface']);
addpath([currentlocation,'\plotters']);
%
%minimum inputs
load rack_P
Fy=33;
b=3.125;
length_index_plotted=[11 23 30]
label=['Rack Section (Hancock et al. (2001))'];
%
%Figures
figure(1)
semilogx(curve(:,1),curve(:,2),'k.-')
axis([1 1000 0 2])
hold on,plot([b b],[1.5 1.8],'k:'),hold off
xlabel('half-wavelength (in.)')
ylabel('P_{cr} / P_y ') 
hold on
semilogx(curve(length_index_plotted,1),curve(length_index_plotted,2),'o')
hold off
%embelish the plot a bit with the cross-section
scale=1;
[A,xcg,zcg,Ixx,Izz,Ixz,thetap,I11,I22]=grosprop(node,elem);
unsymm=0;
[Py,Mxx_y,Mzz_y,M11_y,M22_y]=yieldMP(node,Fy,A,xcg,zcg,Ixx,Izz,Ixz,thetap,I11,I22,unsymm)
%flags:[node# element# mat# stress# stresspic coord constraints springs origin] 1 means show
flags=[0 0 0 0 0 0 1 1 1]; %these flags control what is plotted, node#, elem#
axesnum=axes('Units','normalized','Position',[0.6 0.6 0.2 0.2],'visible','off');
strespic(node,elem,axesnum,scale)
%crossect(node,elem,axesnum,springs,constraints,flags)
%propplot(node,elem,xcg,zcg,thetap,axesnum)
title(label)
text(1.5,b/2,['P_y=',num2str(Py,'%4.2f'),'kips']);
%
%and with the mode shapes
scale=1;
modeindex=1;
undefv=1;
scale=1;
springs=0;
%local
axesshape=axes('Units','normalized','Position',[0.13 0.43 0.2 0.2],'visible','off');
scale=1;
lengthindex=length_index_plotted(1);
dispshap(undefv,node,elem,shapes(:,lengthindex,modeindex),axesshape,scale,springs);
title(['Local P_{cr}/P_y=',num2str(curve(lengthindex,2),'%2.2f')])
%distortional
axesshape=axes('Units','normalized','Position',[0.34 0.23 0.2 0.2],'visible','off');
scale=1;
lengthindex=length_index_plotted(2);
dispshap(undefv,node,elem,shapes(:,lengthindex,modeindex),axesshape,scale,springs);
title(['Distortional P_{cr}/P_y=',num2str(curve(lengthindex,2),'%2.2f')])
%LTB
axesshape=axes('Units','normalized','Position',[0.69 0.2 0.2 0.2],'visible','off');
scale=1;
lengthindex=length_index_plotted(3);
dispshap(undefv,node,elem,shapes(:,lengthindex,modeindex),axesshape,scale,springs);
title('Flexural')
%title(['Lateral-torsional M_{cr}/M_y=',num2str(curve(lengthindex,2),'%2.2f')])


