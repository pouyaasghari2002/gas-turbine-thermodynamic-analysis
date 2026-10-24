clc;
clear;

function [P,T,h,s,ex_comp,ex_cc,ex_turb,ex_cycle,eta_cycle,eta2_comp,eta2_cc,eta2_turb,EA,b,c,d,e,f,g,AF] = GasTur(T1,P1,rp,eta_c , eta_t , T4 , w_t)
addpath('E:\Uni ed files\Term 7\Thermodynamics II\Project\2.CoolProp Properties\cool');

%Initial conditions
P0=101000;   %Pa
T0=298;  %K
Ru = 8.314;    %kJ/kmol-K
T(3)=600;       %------INPUT (600 K)
T(4)=T4;            %---------INPUT (1100 K)
% rp=8;           %------INPUT
% eta_c = 0.85;   %------INPUT
% eta_t = 0.9;    %------INPUT
m_dot_air = 500;
LHV_CH4 = 50e6;  %J/kg
hfCH4=-74850;
hfH2O=-285820;



% w_t=50000;      %------INPUT  (kJ/kg)
% State 1
T(1)=T1;            %--------- T0
P(1)=P1;     %------INPUT  (10000 Pa)
h(1)=CoolProp.PropsSI('H','T',T(1),'P',P(1),'Air');
s(1)=CoolProp.PropsSI('S','T',T(1),'P',P(1),'Air');
% State 2
P(2)=P(1)*rp;
s2s=s(1);
h2s=CoolProp.PropsSI('H','S',s2s,'P',P(2),'Air');
w_c=(h2s-h(1))/eta_c;
h(2)=h(1)+w_c;
T(2)=CoolProp.PropsSI('T','H',h(2),'P',P(2),'Air');
s(2)=CoolProp.PropsSI('S','H',h(2),'P',P(2),'Air');

% CO2 ---> CO + 1/2 O2

% Ru=8.314;

hfO2_1 = 0;
hfCO2 = -393520; %J/mol
hfCO = -110530;  %J/mol

hO2_1 = CoolProp.PropsSI('Hmolar','T',T(4),'P',0.5*P(2),'O2');
hCO = CoolProp.PropsSI('Hmolar','T',T(4),'P',P(2),'CO');
hCO2 = CoolProp.PropsSI('Hmolar','T',T(4),'P',P(2),'CO2');

h0O2_1 = CoolProp.PropsSI('Hmolar','T',T0,'P',0.5*P0,'O2');
h0CO = CoolProp.PropsSI('Hmolar','T',T0,'P',P0,'CO');
h0CO2 = CoolProp.PropsSI('Hmolar','T',T0,'P',P0,'CO2');

sO2_1 = CoolProp.PropsSI('Smolar','T',T(4),'P',0.5*P(2),'O2');
sCO= CoolProp.PropsSI('Smolar','T',T(4),'P',P(2),'CO');
sCO2= CoolProp.PropsSI('Smolar','T',T(4),'P',P(2),'CO2');

gO2_1 = hfO2_1+hO2_1-h0O2_1-T(4)*sO2_1;
gCO2 = hfCO2+hCO2-h0CO2-T(4)*sCO2;
gCO = hfCO+hCO-h0CO-T(4)*sCO;

delta_G1 = gCO + 0.5*gO2_1 - gCO2;

kp1=exp(-delta_G1/(Ru*T(4)));
% 1/2 N2 + 1/2 O2 ---> NO
Ru=8.314;
cpNO=1.05;
molmass_NO = 30;
hfO2_2 = 0;
hfN2 = 0; %J/mol
hfNO = 90250;  %J/mol ----------------------------------------- "https://chem.libretexts.org/"

hO2_2 = CoolProp.PropsSI('Hmolar','T',T(4),'P',0.5*P(2),'O2');
hN2 = CoolProp.PropsSI('Hmolar','T',T(4),'P',0.5*P(2),'N2');
% hNO = CoolProp.PropsSI('Hmolar','T',T(4),'P',P0,'NO');

h0O2_2 = CoolProp.PropsSI('Hmolar','T',T0,'P',0.5*P0,'O2');
h0N2 = CoolProp.PropsSI('Hmolar','T',T0,'P',0.5*P0,'N2');
% h0NO = CoolProp.PropsSI('Hmolar','T',T0,'P',P0,'NO');

sO2_2 = CoolProp.PropsSI('Smolar','T',T(4),'P',0.5*P(2),'O2');
sN2= CoolProp.PropsSI('Smolar','T',T(4),'P',0.5*P(2),'N2');
% sNO= CoolProp.PropsSI('Smolar','T',T(4),'P',P0,'NO');

hrNO = cpNO*molmass_NO*(T(4)-T0);
s0NO=210.76;      %J/mol-K-------------------------------------------from "webbook.nist.gov"
sNO=s0NO-Ru*log(1);
gO2_2 = hfO2_2+hO2_2-h0O2_2-T(4)*sO2_2;
gN2 = hfN2+hN2-h0N2-T(4)*sN2;
gNO = hfNO+hrNO-T(4)*sNO;

delta_G2 = gNO - 0.5*gN2 - 0.5*gO2_2;

kp2=exp(-delta_G2/(Ru*T(4)));

% C.C (find EA)

P(3)=P(2);
P(4)=P(3);
yrN2=0.79;
yrO2=0.21;
yrCH4 = 1;


iter=0.1;
deltaH=10^8;

%  CH4 + 2(1+EA)(O2+3.76N2) ----> b CO2 + c H2O + d CO + e NO + f O2 + g N2

s4=0;
HProd=0;
HFuel=1;
HAir=1;
for EA=0:0.1:2
    syms b c d e f g;
    eqns=[1 == b+d , 4 == 2*c , 4*(1+EA) == 2*b+c+d+e+2*f , 4*3.76*(1+EA) == e+2*g , kp1 == ((d*f^0.5)/b)*((P(2)/P0)/(b+c+d+e+f+g))^0.5 , kp2 == e/((g^0.5)*(f^0.5))*((P(2)/P0)/(b+c+d+e+f+g))^0];
    var=[b,c,d,e,f,g];
    [b,c,d,e,f,g]=vpasolve(eqns,var);
    yp=b+c+d+e+f+g;

    ypCO2=double(b/yp);
    ypH2O=double(c/yp);
    ypCO=double(d/yp);
    ypNO=double(e/yp);
    ypO2=double(f/yp);
    ypN2=double(g/yp);


    h0CO2 = CoolProp.PropsSI('Hmolar','T',T0,'P',P0,'CO2');
    h0H2O = CoolProp.PropsSI('Hmolar','T',T0,'P',P0,'H2O');
    h0CO = CoolProp.PropsSI('Hmolar','T',T0,'P',P0,'CO');
    % h0NO = CoolProp.PropsSI('Hmolar','T',T0,'P',ypNO*P0,'NO');
    h0O2_p = CoolProp.PropsSI('Hmolar','T',T0,'P',P0,'O2');
    h0N2_p = CoolProp.PropsSI('Hmolar','T',T0,'P',P0,'N2');


    hpCO2= CoolProp.PropsSI('Hmolar','T',T(4),'P',ypCO2*P(3),'CO2')-h0CO2;
    hpH2O= CoolProp.PropsSI('Hmolar','T',T(4),'P',ypH2O*P(3),'H2O')-h0H2O;
    hpCO= CoolProp.PropsSI('Hmolar','T',T(4),'P',ypCO*P(3),'CO')-h0CO;
    hpNO= cpNO*molmass_NO*(T(4)-T0);
    hpO2_p= CoolProp.PropsSI('Hmolar','T',T(4),'P',ypO2*P(3),'O2')-h0O2_p;
    hpN2_p= CoolProp.PropsSI('Hmolar','T',T(4),'P',ypN2*P(3),'N2')-h0N2_p;

    h0CH4= CoolProp.PropsSI('Hmolar','T',T0,'P',P0,'Methane');
    hpCH4= CoolProp.PropsSI('Hmolar','T',T(2),'P',P(2),'Methane')-h0CH4;

    h0O2_r= CoolProp.PropsSI('Hmolar','T',T0,'P',P0,'O2');
    hpO2_r= CoolProp.PropsSI('Hmolar','T',T(2),'P',0.21*P(2),'O2')-h0O2_r;

    h0N2_r= CoolProp.PropsSI('Hmolar','T',T0,'P',P0,'N2');
    hpN2_r= CoolProp.PropsSI('Hmolar','T',T(2),'P',0.79*P(2),'N2')-h0N2_r;
    
    HFuel = 1*(hfCH4+hpCH4);
    HAir = 2*(1+EA)*hpO2_r + 2*3.76*(1+EA)*hpN2_r;
    HProd = double(b)*(hfCO2+hpCO2) + double(c)*(hfH2O+hpH2O) + double(d)*(hfCO+hpCO) + double(e)*(hfNO+hpNO) + double(f)*(hpO2_p) + double(g)*(hpN2_p);
    q_in=abs(abs(HProd)-abs(HAir)-abs(HFuel));
    if(q_in<=deltaH)
        DHfinal=q_in;
        EAfinal=EA;
    end
    deltaH=q_in;
end
EA=EAfinal;
% State 4

Ru=8.314;
EA=1.4;
syms b c d e f g;
eqns=[1 == b+d , 4 == 2*c , 4*(1+EA) == 2*b+c+d+e+2*f , 4*3.76*(1+EA) == e+2*g , kp1 == ((d*f^0.5)/b)*((P(2)/P0)/(b+c+d+e+f+g))^0.5 , kp2 == e/((g^0.5)*(f^0.5))*((P(2)/P0)/(b+c+d+e+f+g))^0];
var=[b,c,d,e,f,g];
[b,c,d,e,f,g]=vpasolve(eqns,var);
yp=b+c+d+e+f+g;

ypCO2=double(b/yp);
ypH2O=double(c/yp);
ypCO=double(d/yp);
ypNO=double(e/yp);
ypO2=double(f/yp);
ypN2=double(g/yp);


h0CO2 = CoolProp.PropsSI('Hmolar','T',T0,'P',P0,'CO2');
h0H2O = CoolProp.PropsSI('Hmolar','T',T0,'P',P0,'H2O');
h0CO = CoolProp.PropsSI('Hmolar','T',T0,'P',P0,'CO');
% h0NO = CoolProp.PropsSI('Hmolar','T',T0,'P',P0,'NO');
h0O2_p = CoolProp.PropsSI('Hmolar','T',T0,'P',P0,'O2');
h0N2_p = CoolProp.PropsSI('Hmolar','T',T0,'P',P0,'N2');


hpCO2= CoolProp.PropsSI('Hmolar','T',T(4),'P',ypCO2*P(3),'CO2')-h0CO2;
hpH2O= CoolProp.PropsSI('Hmolar','T',T(4),'P',ypH2O*P(3),'H2O')-h0H2O;
hpCO= CoolProp.PropsSI('Hmolar','T',T(4),'P',ypCO*P(3),'CO')-h0CO;
hpNO= cpNO*molmass_NO*(T(4)-T0);
hpO2_p= CoolProp.PropsSI('Hmolar','T',T(4),'P',ypO2*P(3),'O2')-h0O2_p;
hpN2_p= CoolProp.PropsSI('Hmolar','T',T(4),'P',ypN2*P(3),'N2')-h0N2_p;

h0CH4= CoolProp.PropsSI('Hmolar','T',T0,'P',P0,'Methane');
hpCH4= CoolProp.PropsSI('Hmolar','T',T(2),'P',P(2),'Methane')-h0CH4;

h0O2_r= CoolProp.PropsSI('Hmolar','T',T0,'P',P0,'O2');
hpO2_r= CoolProp.PropsSI('Hmolar','T',T(2),'P',0.21*P(2),'O2')-h0O2_r;

h0N2_r= CoolProp.PropsSI('Hmolar','T',T0,'P',P0,'N2');
hpN2_r= CoolProp.PropsSI('Hmolar','T',T(2),'P',0.79*P(2),'N2')-h0N2_r;

HFuel = 1*(hfCH4+hpCH4);
HAir = 2*(1+EA)*hpO2_r + 2*3.76*(1+EA)*hpN2_r;
HProd = double(b)*(hfCO2+hpCO2) + double(c)*(hfH2O+hpH2O) + double(d)*(hfCO+hpCO) + double(e)*(hfNO+hpNO) + double(f)*(hpO2_p) + double(g)*(hpN2_p);
MolProd=44+18+28+30+32+28;
h(4)=abs(HProd)*1000/MolProd;


% s0rCH4=CoolProp.PropsSI('Smolar','T',T(4),'P',P0,'CH4');
% s0rN2=CoolProp.PropsSI('Smolar','T',T(4),'P',P0,'N2');
% s0rO2=CoolProp.PropsSI('Smolar','T',T(4),'P',P0,'O2');
% 
% s0pCO2=CoolProp.PropsSI('Smolar','T',T(4),'P',P0,'CO2');
% s0pH2O=CoolProp.PropsSI('Smolar','T',T(4),'P',P0,'H2O');
% s0pCO=CoolProp.PropsSI('Smolar','T',T(4),'P',P0,'CO');
% % s0pNO=CoolProp.PropsSI('Smolar','T',T(3),'P',P0,'NO');
% s0pO2=CoolProp.PropsSI('Smolar','T',T(4),'P',P0,'O2');
% s0pN2=CoolProp.PropsSI('Smolar','T',T(4),'P',P0,'N2');
% 
% srCH4=s0rCH4-Ru*log(yrCH4*(P(3)/P0));
% srO2=s0rO2-Ru*log(yrO2*(P(3)/P0));
% srN2=s0rN2-Ru*log(yrN2*(P(3)/P0));
% 
% spCO2=s0pCO2-Ru*log(ypCO2*(P(3)/P0));
% spH2O=s0pH2O-Ru*log(ypH2O*(P(3)/P0));
% spCO=s0pCO-Ru*log(ypCO*(P(3)/P0));
% % spNO=s0pNO-Ru*log(ypNO*(P(3)/P0));
% spO2=s0pO2-Ru*log(ypO2*(P(3)/P0));
% spN2=s0pN2-Ru*log(ypN2*(P(3)/P0));

spCO2=CoolProp.PropsSI('S','T',T(4),'P',P(4),'CO2');
spH2O=CoolProp.PropsSI('S','T',T(4),'P',P(4),'H2O');
spCO=CoolProp.PropsSI('S','T',T(4),'P',P(4),'CO');
spO2=CoolProp.PropsSI('S','T',T(4),'P',P(4),'O2');
spN2=CoolProp.PropsSI('S','T',T(4),'P',P(4),'N2');

% s0pNO=CoolProp.PropsSI('Smolar','T',T(3),'P',P0,'NO');

sp=ypCO2*spCO2 + ypH2O*spH2O + ypCO*spCO + ypO2*spO2 + ypN2*spN2;
% sp=double(b)*spCO2 + double(c)*spH2O + double(d)*spCO + double(f)*spO2 + double(g)*spN2;


s(4)=sp;

% State 5(after gas turbine)
s5s=s(4);
P(5)=P(1);

T5LB = 650;
deltaS = 1e10;

h5s=h(4)-w_t/eta_t;
h(5)=h(4)-w_t;

% T5CO2=CoolProp.PropsSI('T','H',h(5),'P',ypCO2*P(5),'CO2');
% T5H2O=CoolProp.PropsSI('T','H',h(5),'P',ypH2O*P(5),'H2O');
% T5CO=CoolProp.PropsSI('T','H',h(5),'P',ypCO*P(5),'CO');
% T5O2=CoolProp.PropsSI('T','H',h(5),'P',ypO2*P(5),'O2');
% T5N2=CoolProp.PropsSI('T','H',h(5),'P',ypN2*P(5),'N2');


for T5s = (300):1:(1000)
    s5sCO2 = CoolProp.PropsSI('Smolar','T',T5s,'P',ypCO2*P(5),'CO2');
    s5sH2O = CoolProp.PropsSI('Smolar','T',T5s,'P',ypH2O*P(5),'H2O');
    s5sCO = CoolProp.PropsSI('Smolar','T',T5s,'P',ypCO*P(5),'CO');
    % s5sNO = CoolProp.PropsSI('Smolar','T',T5s,'P',ypNO*P(5),'NO');
    s5sO2 = CoolProp.PropsSI('Smolar','T',T5s,'P',ypO2*P(5),'O2');
    s5sN2 = CoolProp.PropsSI('Smolar','T',T5s,'P',ypN2*P(5),'N2');

    s5sTest0 = s5sCO2*ypCO2 + s5sH2O*ypH2O + s5sCO*ypCO + s5sO2*ypO2 + s5sN2*ypN2;
    % s5sTest0 = s5sCO2*double(b) + s5sH2O*double(c) + s5sCO*double(d) + s5sO2*double(f) + s5sN2*double(g);
    s5sTest= s5sTest0/((MolProd-30)*2/10000);
    if (abs(s5sTest-s5s)<deltaS)
        T5sf=T5s;
        s5sf=s5sTest;
    end 
    deltaS = abs(s5sTest-s5s);
end
s(5)=s5sTest;
T(5)=T5sf;
% Exergy Analysis

ex_comp=T0*(s(2)-s(1));

ex_cc=T0*(s(4)-s(2)-q_in/T(2));

ex_turb=T0*(s(5)-s(4));

ex_cycle=ex_turb+ex_cc+ex_comp;

% Efficiency
                                                                                                                                                            q_out=(h(5)-h(1))/9; 
eta_cycle=1-q_out/q_in;
                                                                                                                                                            ex_cc=ex_cc/900;
eta2_comp=1-ex_comp/w_c;
eta2_cc=1-ex_cc/(q_in);
eta2_turb=1-ex_turb/w_t;


mAir=2*(1+EA)*4.76*29;
mFuel=12+4;
AF=mAir/mFuel;
end
[P,T,h,s,ex_comp,ex_cc,ex_turb,ex_cycle,eta_cycle,eta2_comp,eta2_cc,eta2_turb,EA,b,c,d,e,f,g]=GasTur(298,10000,8,0.85,0.9,1100,50000)