classdef app1 < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                      matlab.ui.Figure
        AirFuelratioEditField         matlab.ui.control.NumericEditField
        AirFuelratioEditFieldLabel    matlab.ui.control.Label
        Image                         matlab.ui.control.Image
        g                             matlab.ui.control.EditField
        f                             matlab.ui.control.EditField
        e                             matlab.ui.control.EditField
        d                             matlab.ui.control.EditField
        c                             matlab.ui.control.EditField
        b                             matlab.ui.control.EditField
        EA                            matlab.ui.control.EditField
        CH421Label                    matlab.ui.control.Label
        N2Label                       matlab.ui.control.Label
        O2Label                       matlab.ui.control.Label
        NOLabel                       matlab.ui.control.Label
        COLabel                       matlab.ui.control.Label
        H2OLabel                      matlab.ui.control.Label
        CO2Label                      matlab.ui.control.Label
        O2376N2Label                  matlab.ui.control.Label
        CompositionLabel              matlab.ui.control.Label
        etaCycleEditField             matlab.ui.control.EditField
        etaCycleEditFieldLabel        matlab.ui.control.Label
        etaIITurbineEditField         matlab.ui.control.EditField
        etaIITurbineEditFieldLabel    matlab.ui.control.Label
        etaIICCEditField              matlab.ui.control.EditField
        etaIICCEditFieldLabel         matlab.ui.control.Label
        etaIICompEditField            matlab.ui.control.EditField
        etaIICompEditFieldLabel       matlab.ui.control.Label
        ExdCyclekJkgEditField         matlab.ui.control.EditField
        ExdCyclekJkgEditFieldLabel    matlab.ui.control.Label
        ExdTurbinekJkgEditField       matlab.ui.control.EditField
        ExdTurbinekJkgEditFieldLabel  matlab.ui.control.Label
        ExdCCkJkgEditField            matlab.ui.control.EditField
        ExdCCkJkgEditFieldLabel       matlab.ui.control.Label
        ExdCompkJkgEditField          matlab.ui.control.EditField
        ExdCompkJkgEditFieldLabel     matlab.ui.control.Label
        T5KEditField                  matlab.ui.control.EditField
        T5KEditFieldLabel             matlab.ui.control.Label
        T4KEditField_2                matlab.ui.control.EditField
        T4KEditField_2Label           matlab.ui.control.Label
        T2KEditField                  matlab.ui.control.EditField
        T2KEditFieldLabel             matlab.ui.control.Label
        T1KEditField_2                matlab.ui.control.EditField
        T1KEditField_2Label           matlab.ui.control.Label
        h5kJkgEditField               matlab.ui.control.EditField
        h5kJkgEditFieldLabel          matlab.ui.control.Label
        h4kJkgEditField               matlab.ui.control.EditField
        h4kJkgEditFieldLabel          matlab.ui.control.Label
        h2kJkgEditField               matlab.ui.control.EditField
        h2kJkgEditFieldLabel          matlab.ui.control.Label
        h1kJkgEditField               matlab.ui.control.EditField
        h1kJkgEditFieldLabel          matlab.ui.control.Label
        s5kJkgKEditField              matlab.ui.control.EditField
        s5kJkgKEditFieldLabel         matlab.ui.control.Label
        s4kJkgKEditField              matlab.ui.control.EditField
        s4kJkgKEditFieldLabel         matlab.ui.control.Label
        s2kJkgKEditField              matlab.ui.control.EditField
        s2kJkgKEditFieldLabel         matlab.ui.control.Label
        s1kJkgKEditField              matlab.ui.control.EditField
        s1kJkgKEditFieldLabel         matlab.ui.control.Label
        P5PaEditField                 matlab.ui.control.EditField
        P5PaEditFieldLabel            matlab.ui.control.Label
        P4PaEditField                 matlab.ui.control.EditField
        P4PaEditFieldLabel            matlab.ui.control.Label
        P2PaEditField                 matlab.ui.control.EditField
        P2PaEditFieldLabel            matlab.ui.control.Label
        P1PaEditField_2               matlab.ui.control.EditField
        P1PaEditField_2Label          matlab.ui.control.Label
        OutputsLabel                  matlab.ui.control.Label
        InputsLabel                   matlab.ui.control.Label
        Lamp                          matlab.ui.control.Lamp
        CalculateButton               matlab.ui.control.Button
        WturbineLabel                 matlab.ui.control.Label
        WturbinekJEditField           matlab.ui.control.NumericEditField
        rpLabel                       matlab.ui.control.Label
        rpEditField                   matlab.ui.control.NumericEditField
        etacompressorLabel            matlab.ui.control.Label
        etacompressorEditField        matlab.ui.control.NumericEditField
        etaturbineLabel               matlab.ui.control.Label
        etaturbineEditField           matlab.ui.control.NumericEditField
        P1Label                       matlab.ui.control.Label
        P1PaEditField                 matlab.ui.control.NumericEditField
        T4Label                       matlab.ui.control.Label
        T4KEditField                  matlab.ui.control.NumericEditField
        T1KEditField                  matlab.ui.control.NumericEditField
        T1Label                       matlab.ui.control.Label
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: CalculateButton
        function btnpshd(app, event)
            T1=app.T1KEditField.Value;
            T4=app.T4KEditField.Value;
            P1=app.P1PaEditField.Value;
            eta_t=app.etaturbineEditField.Value;
            eta_c=app.etacompressorEditField.Value;
            rp=app.rpEditField.Value;
            w_t=app.WturbinekJEditField.Value;

            function [P,T,h,s,ex_comp,ex_cc,ex_turb,ex_cycle,eta_cycle,eta2_comp,eta2_cc,eta2_turb,EA,b,c,d,e,f,g,AF] = GasTur(T1,P1,rp,eta_c , eta_t , T4 , w_t )
                addpath('E:\Uni ed files\Term 7\Thermodynamics II\Project\2.CoolProp Properties\cool');
                % app.Lamp.Color='r';
                % if ftype=='Methane'



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
                % EA=0;
                for EA=0:0.1:2
                    % while q>100
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

                ex_comp=T0*(s(2)-s(1))/100;

                ex_cc=T0*(s(4)-s(2)-q_in/T(2))/100;

                ex_turb=T0*(s(5)-s(4))/100;

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
            [P,T,h,s,ex_comp,ex_cc,ex_turb,ex_cycle,eta_cycle,eta2_comp,eta2_cc,eta2_turb,EA,b,c,d,e,f,g,AF] = GasTur(T1,P1,rp,eta_c , eta_t , T4 , w_t);
            
            %Composition
            app.EA.Value=string(EA);
            app.b.Value=string(double(b));
            app.c.Value=string(double(c));
            app.d.Value=string(double(d));
            app.e.Value=string(double(e));
            app.f.Value=string(double(f));
            app.g.Value=string(double(g));
            
            %Show pressures
            app.P1PaEditField_2.Value=string(P(1));
            app.P2PaEditField.Value=string(P(2));
            app.P4PaEditField.Value=string(P(4));
            app.P5PaEditField.Value=string(P(5));

            %Show entropies
            app.s1kJkgKEditField.Value=string(s(1)/1000);
            app.s2kJkgKEditField.Value=string(s(2)/1000);
            app.s4kJkgKEditField.Value=string(s(4)/1000);
            app.s5kJkgKEditField.Value=string(s(5)/1000);

            %Show enthalpies
            app.h1kJkgEditField.Value=string(h(1)/1000);
            app.h2kJkgEditField.Value=string(h(2)/1000);
            app.h4kJkgEditField.Value=string(h(4)/1000);
            app.h5kJkgEditField.Value=string(h(5)/1000);

            %Show temperatures
            app.T1KEditField_2.Value=string(T(1));
            app.T2KEditField.Value=string(T(2));
            app.T4KEditField_2.Value=string(T(4));
            app.T5KEditField.Value=string(T(5));

            %Show Exergies
            app.ExdCompkJkgEditField.Value=string(ex_comp);
            app.ExdCCkJkgEditField.Value=string(ex_cc);
            app.ExdTurbinekJkgEditField.Value=string(ex_turb);
            app.ExdCyclekJkgEditField.Value=string(ex_comp+ex_turb+ex_cc);


            %Others
            app.etaCycleEditField.Value=string(eta_cycle);
            app.etaIICompEditField.Value=string(eta2_comp);
            app.etaIICCEditField.Value=string(eta2_cc);
            app.etaIITurbineEditField.Value=string(eta2_turb);

            app.AirFuelratioEditField.Value=AF;
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Get the file path for locating images
            pathToMLAPP = fileparts(mfilename('fullpath'));

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 989 672];
            app.UIFigure.Name = 'MATLAB App';

            % Create T1Label
            app.T1Label = uilabel(app.UIFigure);
            app.T1Label.HorizontalAlignment = 'center';
            app.T1Label.Position = [50 602 49 22];
            app.T1Label.Text = 'T1 (K) =';

            % Create T1KEditField
            app.T1KEditField = uieditfield(app.UIFigure, 'numeric');
            app.T1KEditField.HorizontalAlignment = 'center';
            app.T1KEditField.Position = [136 601 68 25];
            app.T1KEditField.Value = 298;

            % Create T4KEditField
            app.T4KEditField = uieditfield(app.UIFigure, 'numeric');
            app.T4KEditField.HorizontalAlignment = 'center';
            app.T4KEditField.Position = [136 558 68 25];
            app.T4KEditField.Value = 1100;

            % Create T4Label
            app.T4Label = uilabel(app.UIFigure);
            app.T4Label.HorizontalAlignment = 'center';
            app.T4Label.Position = [50 559 49 22];
            app.T4Label.Text = 'T4 (K) =';

            % Create P1PaEditField
            app.P1PaEditField = uieditfield(app.UIFigure, 'numeric');
            app.P1PaEditField.HorizontalAlignment = 'center';
            app.P1PaEditField.Position = [136 517 68 25];
            app.P1PaEditField.Value = 10000;

            % Create P1Label
            app.P1Label = uilabel(app.UIFigure);
            app.P1Label.HorizontalAlignment = 'center';
            app.P1Label.Position = [46 517 56 22];
            app.P1Label.Text = 'P1 (Pa) =';

            % Create etaturbineEditField
            app.etaturbineEditField = uieditfield(app.UIFigure, 'numeric');
            app.etaturbineEditField.HorizontalAlignment = 'center';
            app.etaturbineEditField.Position = [136 476 68 25];
            app.etaturbineEditField.Value = 0.9;

            % Create etaturbineLabel
            app.etaturbineLabel = uilabel(app.UIFigure);
            app.etaturbineLabel.HorizontalAlignment = 'center';
            app.etaturbineLabel.Position = [38 479 72 22];
            app.etaturbineLabel.Text = 'eta turbine =';

            % Create etacompressorEditField
            app.etacompressorEditField = uieditfield(app.UIFigure, 'numeric');
            app.etacompressorEditField.HorizontalAlignment = 'center';
            app.etacompressorEditField.Position = [136 435 68 25];
            app.etacompressorEditField.Value = 0.85;

            % Create etacompressorLabel
            app.etacompressorLabel = uilabel(app.UIFigure);
            app.etacompressorLabel.HorizontalAlignment = 'center';
            app.etacompressorLabel.Position = [25 438 98 22];
            app.etacompressorLabel.Text = 'eta compressor =';

            % Create rpEditField
            app.rpEditField = uieditfield(app.UIFigure, 'numeric');
            app.rpEditField.HorizontalAlignment = 'center';
            app.rpEditField.Position = [136 394 68 25];
            app.rpEditField.Value = 8;

            % Create rpLabel
            app.rpLabel = uilabel(app.UIFigure);
            app.rpLabel.HorizontalAlignment = 'center';
            app.rpLabel.Position = [61 397 26 22];
            app.rpLabel.Text = 'rp =';

            % Create WturbinekJEditField
            app.WturbinekJEditField = uieditfield(app.UIFigure, 'numeric');
            app.WturbinekJEditField.HorizontalAlignment = 'center';
            app.WturbinekJEditField.Position = [136 353 68 25];
            app.WturbinekJEditField.Value = 50000;

            % Create WturbineLabel
            app.WturbineLabel = uilabel(app.UIFigure);
            app.WturbineLabel.HorizontalAlignment = 'center';
            app.WturbineLabel.Position = [29 354 90 22];
            app.WturbineLabel.Text = 'W turbine (kJ) =';

            % Create CalculateButton
            app.CalculateButton = uibutton(app.UIFigure, 'push');
            app.CalculateButton.ButtonPushedFcn = createCallbackFcn(app, @btnpshd, true);
            app.CalculateButton.Position = [99 287 67 28];
            app.CalculateButton.Text = 'Calculate';

            % Create Lamp
            app.Lamp = uilamp(app.UIFigure);
            app.Lamp.Position = [179 289 25 25];

            % Create InputsLabel
            app.InputsLabel = uilabel(app.UIFigure);
            app.InputsLabel.HorizontalAlignment = 'center';
            app.InputsLabel.FontWeight = 'bold';
            app.InputsLabel.FontAngle = 'italic';
            app.InputsLabel.Position = [52 639 152 23];
            app.InputsLabel.Text = 'Inputs';

            % Create OutputsLabel
            app.OutputsLabel = uilabel(app.UIFigure);
            app.OutputsLabel.HorizontalAlignment = 'center';
            app.OutputsLabel.FontWeight = 'bold';
            app.OutputsLabel.FontAngle = 'italic';
            app.OutputsLabel.Position = [379 639 152 23];
            app.OutputsLabel.Text = 'Outputs';

            % Create P1PaEditField_2Label
            app.P1PaEditField_2Label = uilabel(app.UIFigure);
            app.P1PaEditField_2Label.HorizontalAlignment = 'center';
            app.P1PaEditField_2Label.Position = [279 602 56 22];
            app.P1PaEditField_2Label.Text = 'P1 (Pa) =';

            % Create P1PaEditField_2
            app.P1PaEditField_2 = uieditfield(app.UIFigure, 'text');
            app.P1PaEditField_2.Editable = 'off';
            app.P1PaEditField_2.Position = [371 601 68 25];

            % Create P2PaEditFieldLabel
            app.P2PaEditFieldLabel = uilabel(app.UIFigure);
            app.P2PaEditFieldLabel.HorizontalAlignment = 'center';
            app.P2PaEditFieldLabel.Position = [487 602 56 22];
            app.P2PaEditFieldLabel.Text = 'P2 (Pa) =';

            % Create P2PaEditField
            app.P2PaEditField = uieditfield(app.UIFigure, 'text');
            app.P2PaEditField.Editable = 'off';
            app.P2PaEditField.Position = [573 601 68 25];

            % Create P4PaEditFieldLabel
            app.P4PaEditFieldLabel = uilabel(app.UIFigure);
            app.P4PaEditFieldLabel.HorizontalAlignment = 'center';
            app.P4PaEditFieldLabel.Position = [279 559 56 22];
            app.P4PaEditFieldLabel.Text = 'P4 (Pa) =';

            % Create P4PaEditField
            app.P4PaEditField = uieditfield(app.UIFigure, 'text');
            app.P4PaEditField.Editable = 'off';
            app.P4PaEditField.Position = [371 558 68 25];

            % Create P5PaEditFieldLabel
            app.P5PaEditFieldLabel = uilabel(app.UIFigure);
            app.P5PaEditFieldLabel.HorizontalAlignment = 'center';
            app.P5PaEditFieldLabel.Position = [487 559 56 22];
            app.P5PaEditFieldLabel.Text = 'P5 (Pa) =';

            % Create P5PaEditField
            app.P5PaEditField = uieditfield(app.UIFigure, 'text');
            app.P5PaEditField.Editable = 'off';
            app.P5PaEditField.Position = [573 558 68 25];

            % Create s1kJkgKEditFieldLabel
            app.s1kJkgKEditFieldLabel = uilabel(app.UIFigure);
            app.s1kJkgKEditFieldLabel.HorizontalAlignment = 'center';
            app.s1kJkgKEditFieldLabel.Position = [268 517 79 22];
            app.s1kJkgKEditFieldLabel.Text = 's1 (kJ/kg.K) =';

            % Create s1kJkgKEditField
            app.s1kJkgKEditField = uieditfield(app.UIFigure, 'text');
            app.s1kJkgKEditField.Editable = 'off';
            app.s1kJkgKEditField.Position = [371 516 68 25];

            % Create s2kJkgKEditFieldLabel
            app.s2kJkgKEditFieldLabel = uilabel(app.UIFigure);
            app.s2kJkgKEditFieldLabel.HorizontalAlignment = 'center';
            app.s2kJkgKEditFieldLabel.Position = [476 517 79 22];
            app.s2kJkgKEditFieldLabel.Text = 's2 (kJ/kg.K) =';

            % Create s2kJkgKEditField
            app.s2kJkgKEditField = uieditfield(app.UIFigure, 'text');
            app.s2kJkgKEditField.Editable = 'off';
            app.s2kJkgKEditField.Position = [573 516 68 25];

            % Create s4kJkgKEditFieldLabel
            app.s4kJkgKEditFieldLabel = uilabel(app.UIFigure);
            app.s4kJkgKEditFieldLabel.HorizontalAlignment = 'center';
            app.s4kJkgKEditFieldLabel.Position = [268 477 79 22];
            app.s4kJkgKEditFieldLabel.Text = 's4 (kJ/kg.K) =';

            % Create s4kJkgKEditField
            app.s4kJkgKEditField = uieditfield(app.UIFigure, 'text');
            app.s4kJkgKEditField.Editable = 'off';
            app.s4kJkgKEditField.Position = [371 476 68 25];

            % Create s5kJkgKEditFieldLabel
            app.s5kJkgKEditFieldLabel = uilabel(app.UIFigure);
            app.s5kJkgKEditFieldLabel.HorizontalAlignment = 'center';
            app.s5kJkgKEditFieldLabel.Position = [476 477 79 22];
            app.s5kJkgKEditFieldLabel.Text = 's5 (kJ/kg.K) =';

            % Create s5kJkgKEditField
            app.s5kJkgKEditField = uieditfield(app.UIFigure, 'text');
            app.s5kJkgKEditField.Editable = 'off';
            app.s5kJkgKEditField.Position = [573 476 68 25];

            % Create h1kJkgEditFieldLabel
            app.h1kJkgEditFieldLabel = uilabel(app.UIFigure);
            app.h1kJkgEditFieldLabel.HorizontalAlignment = 'center';
            app.h1kJkgEditFieldLabel.Position = [273 436 68 22];
            app.h1kJkgEditFieldLabel.Text = 'h1 (kJ/kg) =';

            % Create h1kJkgEditField
            app.h1kJkgEditField = uieditfield(app.UIFigure, 'text');
            app.h1kJkgEditField.Editable = 'off';
            app.h1kJkgEditField.Position = [371 435 68 25];

            % Create h2kJkgEditFieldLabel
            app.h2kJkgEditFieldLabel = uilabel(app.UIFigure);
            app.h2kJkgEditFieldLabel.HorizontalAlignment = 'center';
            app.h2kJkgEditFieldLabel.Position = [481 436 68 22];
            app.h2kJkgEditFieldLabel.Text = 'h2 (kJ/kg) =';

            % Create h2kJkgEditField
            app.h2kJkgEditField = uieditfield(app.UIFigure, 'text');
            app.h2kJkgEditField.Editable = 'off';
            app.h2kJkgEditField.Position = [573 435 68 25];

            % Create h4kJkgEditFieldLabel
            app.h4kJkgEditFieldLabel = uilabel(app.UIFigure);
            app.h4kJkgEditFieldLabel.HorizontalAlignment = 'center';
            app.h4kJkgEditFieldLabel.Position = [273 395 68 22];
            app.h4kJkgEditFieldLabel.Text = 'h4 (kJ/kg) =';

            % Create h4kJkgEditField
            app.h4kJkgEditField = uieditfield(app.UIFigure, 'text');
            app.h4kJkgEditField.Editable = 'off';
            app.h4kJkgEditField.Position = [371 394 68 25];

            % Create h5kJkgEditFieldLabel
            app.h5kJkgEditFieldLabel = uilabel(app.UIFigure);
            app.h5kJkgEditFieldLabel.HorizontalAlignment = 'center';
            app.h5kJkgEditFieldLabel.Position = [481 395 68 22];
            app.h5kJkgEditFieldLabel.Text = 'h5 (kJ/kg) =';

            % Create h5kJkgEditField
            app.h5kJkgEditField = uieditfield(app.UIFigure, 'text');
            app.h5kJkgEditField.Editable = 'off';
            app.h5kJkgEditField.Position = [573 394 68 25];

            % Create T1KEditField_2Label
            app.T1KEditField_2Label = uilabel(app.UIFigure);
            app.T1KEditField_2Label.HorizontalAlignment = 'center';
            app.T1KEditField_2Label.Position = [283 354 49 22];
            app.T1KEditField_2Label.Text = 'T1 (K) =';

            % Create T1KEditField_2
            app.T1KEditField_2 = uieditfield(app.UIFigure, 'text');
            app.T1KEditField_2.Editable = 'off';
            app.T1KEditField_2.Position = [371 353 68 25];

            % Create T2KEditFieldLabel
            app.T2KEditFieldLabel = uilabel(app.UIFigure);
            app.T2KEditFieldLabel.HorizontalAlignment = 'center';
            app.T2KEditFieldLabel.Position = [491 354 49 22];
            app.T2KEditFieldLabel.Text = 'T2 (K) =';

            % Create T2KEditField
            app.T2KEditField = uieditfield(app.UIFigure, 'text');
            app.T2KEditField.Editable = 'off';
            app.T2KEditField.Position = [573 353 68 25];

            % Create T4KEditField_2Label
            app.T4KEditField_2Label = uilabel(app.UIFigure);
            app.T4KEditField_2Label.HorizontalAlignment = 'center';
            app.T4KEditField_2Label.Position = [283 314 49 22];
            app.T4KEditField_2Label.Text = 'T4 (K) =';

            % Create T4KEditField_2
            app.T4KEditField_2 = uieditfield(app.UIFigure, 'text');
            app.T4KEditField_2.Editable = 'off';
            app.T4KEditField_2.Position = [371 313 68 25];

            % Create T5KEditFieldLabel
            app.T5KEditFieldLabel = uilabel(app.UIFigure);
            app.T5KEditFieldLabel.HorizontalAlignment = 'center';
            app.T5KEditFieldLabel.Position = [491 314 49 22];
            app.T5KEditFieldLabel.Text = 'T5 (K) =';

            % Create T5KEditField
            app.T5KEditField = uieditfield(app.UIFigure, 'text');
            app.T5KEditField.Editable = 'off';
            app.T5KEditField.Position = [573 313 68 25];

            % Create ExdCompkJkgEditFieldLabel
            app.ExdCompkJkgEditFieldLabel = uilabel(app.UIFigure);
            app.ExdCompkJkgEditFieldLabel.HorizontalAlignment = 'center';
            app.ExdCompkJkgEditFieldLabel.Position = [252 274 111 22];
            app.ExdCompkJkgEditFieldLabel.Text = 'Exd Comp (kJ/kg) =';

            % Create ExdCompkJkgEditField
            app.ExdCompkJkgEditField = uieditfield(app.UIFigure, 'text');
            app.ExdCompkJkgEditField.Editable = 'off';
            app.ExdCompkJkgEditField.Position = [371 273 68 25];

            % Create ExdCCkJkgEditFieldLabel
            app.ExdCCkJkgEditFieldLabel = uilabel(app.UIFigure);
            app.ExdCCkJkgEditFieldLabel.HorizontalAlignment = 'center';
            app.ExdCCkJkgEditFieldLabel.Position = [466 274 99 22];
            app.ExdCCkJkgEditFieldLabel.Text = 'Exd C.C (kJ/kg) =';

            % Create ExdCCkJkgEditField
            app.ExdCCkJkgEditField = uieditfield(app.UIFigure, 'text');
            app.ExdCCkJkgEditField.Editable = 'off';
            app.ExdCCkJkgEditField.Position = [573 273 68 25];

            % Create ExdTurbinekJkgEditFieldLabel
            app.ExdTurbinekJkgEditFieldLabel = uilabel(app.UIFigure);
            app.ExdTurbinekJkgEditFieldLabel.HorizontalAlignment = 'center';
            app.ExdTurbinekJkgEditFieldLabel.Position = [248 234 119 22];
            app.ExdTurbinekJkgEditFieldLabel.Text = 'Exd Turbine (kJ/kg) =';

            % Create ExdTurbinekJkgEditField
            app.ExdTurbinekJkgEditField = uieditfield(app.UIFigure, 'text');
            app.ExdTurbinekJkgEditField.Editable = 'off';
            app.ExdTurbinekJkgEditField.Position = [371 233 68 25];

            % Create ExdCyclekJkgEditFieldLabel
            app.ExdCyclekJkgEditFieldLabel = uilabel(app.UIFigure);
            app.ExdCyclekJkgEditFieldLabel.HorizontalAlignment = 'center';
            app.ExdCyclekJkgEditFieldLabel.Position = [461 234 109 22];
            app.ExdCyclekJkgEditFieldLabel.Text = 'Exd Cycle (kJ/kg) =';

            % Create ExdCyclekJkgEditField
            app.ExdCyclekJkgEditField = uieditfield(app.UIFigure, 'text');
            app.ExdCyclekJkgEditField.Editable = 'off';
            app.ExdCyclekJkgEditField.Position = [573 233 68 25];

            % Create etaIICompEditFieldLabel
            app.etaIICompEditFieldLabel = uilabel(app.UIFigure);
            app.etaIICompEditFieldLabel.HorizontalAlignment = 'center';
            app.etaIICompEditFieldLabel.Position = [269 193 77 22];
            app.etaIICompEditFieldLabel.Text = 'eta II Comp =';

            % Create etaIICompEditField
            app.etaIICompEditField = uieditfield(app.UIFigure, 'text');
            app.etaIICompEditField.Editable = 'off';
            app.etaIICompEditField.Position = [371 192 68 25];

            % Create etaIICCEditFieldLabel
            app.etaIICCEditFieldLabel = uilabel(app.UIFigure);
            app.etaIICCEditFieldLabel.HorizontalAlignment = 'center';
            app.etaIICCEditFieldLabel.Position = [483 193 66 22];
            app.etaIICCEditFieldLabel.Text = 'eta II C.C =';

            % Create etaIICCEditField
            app.etaIICCEditField = uieditfield(app.UIFigure, 'text');
            app.etaIICCEditField.Editable = 'off';
            app.etaIICCEditField.Position = [573 192 68 25];

            % Create etaIITurbineEditFieldLabel
            app.etaIITurbineEditFieldLabel = uilabel(app.UIFigure);
            app.etaIITurbineEditFieldLabel.HorizontalAlignment = 'center';
            app.etaIITurbineEditFieldLabel.Position = [265 153 85 22];
            app.etaIITurbineEditFieldLabel.Text = 'eta II Turbine =';

            % Create etaIITurbineEditField
            app.etaIITurbineEditField = uieditfield(app.UIFigure, 'text');
            app.etaIITurbineEditField.Editable = 'off';
            app.etaIITurbineEditField.Position = [371 152 68 25];

            % Create etaCycleEditFieldLabel
            app.etaCycleEditFieldLabel = uilabel(app.UIFigure);
            app.etaCycleEditFieldLabel.HorizontalAlignment = 'center';
            app.etaCycleEditFieldLabel.Position = [493 153 65 22];
            app.etaCycleEditFieldLabel.Text = 'eta Cycle =';

            % Create etaCycleEditField
            app.etaCycleEditField = uieditfield(app.UIFigure, 'text');
            app.etaCycleEditField.Editable = 'off';
            app.etaCycleEditField.Position = [573 152 68 25];

            % Create CompositionLabel
            app.CompositionLabel = uilabel(app.UIFigure);
            app.CompositionLabel.Position = [30 81 107 24];
            app.CompositionLabel.Text = 'Composition:';

            % Create O2376N2Label
            app.O2376N2Label = uilabel(app.UIFigure);
            app.O2376N2Label.Position = [219 56 122 22];
            app.O2376N2Label.Text = ')*(O2+3.76N2) ====>';

            % Create CO2Label
            app.CO2Label = uilabel(app.UIFigure);
            app.CO2Label.Position = [391 56 37 22];
            app.CO2Label.Text = 'CO2+';

            % Create H2OLabel
            app.H2OLabel = uilabel(app.UIFigure);
            app.H2OLabel.Position = [479 56 37 22];
            app.H2OLabel.Text = 'H2O+';

            % Create COLabel
            app.COLabel = uilabel(app.UIFigure);
            app.COLabel.Position = [569 56 30 22];
            app.COLabel.Text = 'CO+';

            % Create NOLabel
            app.NOLabel = uilabel(app.UIFigure);
            app.NOLabel.Position = [650 56 30 22];
            app.NOLabel.Text = 'NO+';

            % Create O2Label
            app.O2Label = uilabel(app.UIFigure);
            app.O2Label.Position = [733 56 28 22];
            app.O2Label.Text = 'O2+';

            % Create N2Label
            app.N2Label = uilabel(app.UIFigure);
            app.N2Label.Position = [817 56 25 22];
            app.N2Label.Text = 'N2';

            % Create CH421Label
            app.CH421Label = uilabel(app.UIFigure);
            app.CH421Label.Position = [102 56 65 22];
            app.CH421Label.Text = 'CH4+2*(1+';

            % Create EA
            app.EA = uieditfield(app.UIFigure, 'text');
            app.EA.Editable = 'off';
            app.EA.Position = [166 56 50 22];

            % Create b
            app.b = uieditfield(app.UIFigure, 'text');
            app.b.Editable = 'off';
            app.b.Position = [338 56 50 22];

            % Create c
            app.c = uieditfield(app.UIFigure, 'text');
            app.c.Editable = 'off';
            app.c.Position = [427 56 50 22];

            % Create d
            app.d = uieditfield(app.UIFigure, 'text');
            app.d.Editable = 'off';
            app.d.Position = [515 56 50 22];

            % Create e
            app.e = uieditfield(app.UIFigure, 'text');
            app.e.Editable = 'off';
            app.e.Position = [597 56 50 22];

            % Create f
            app.f = uieditfield(app.UIFigure, 'text');
            app.f.Editable = 'off';
            app.f.Position = [679 56 50 22];

            % Create g
            app.g = uieditfield(app.UIFigure, 'text');
            app.g.Editable = 'off';
            app.g.Position = [760 56 50 22];

            % Create Image
            app.Image = uiimage(app.UIFigure);
            app.Image.Position = [680 427 290 212];
            app.Image.ImageSource = fullfile(pathToMLAPP, 'Schematic.jpg');

            % Create AirFuelratioEditFieldLabel
            app.AirFuelratioEditFieldLabel = uilabel(app.UIFigure);
            app.AirFuelratioEditFieldLabel.HorizontalAlignment = 'right';
            app.AirFuelratioEditFieldLabel.Position = [679 354 74 22];
            app.AirFuelratioEditFieldLabel.Text = 'Air-Fuel ratio';

            % Create AirFuelratioEditField
            app.AirFuelratioEditField = uieditfield(app.UIFigure, 'numeric');
            app.AirFuelratioEditField.Editable = 'off';
            app.AirFuelratioEditField.Position = [760 354 40 22];

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = app1

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end