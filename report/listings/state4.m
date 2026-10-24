% State 4

Ru=8.314;
EA=1.4;
syms   b c d e f g ;
eqns =[1 ==  b+d  , 4 == 2*c , 4*(1+EA) == 2*b+c+d+e+2*f , 4*3.76*(1+EA) == e+2*g , kp1 == ((d*f^0.5)/b)*((P(2)/P0)/( b+c+d+e+f+g ))^0.5 , kp2 == e/((g^0.5)*(f^0.5))*((P(2)/P0)/( b+c+d+e+f+g ))^0];
var=[ b,c ,d,e,f,g ];
[ b,c ,d,e,f,g ]= vpasolve ( eqns,var );
yp = b+c+d+e+f+g ;

ypCO2=double(b/ yp );
ypH2O=double(c/ yp );
ypCO =double(d/ yp );
ypNO =double(e/ yp );
ypO2=double(f/ yp );
ypN2=double(g/ yp );


h0CO2 =  CoolProp.PropsSI ( 'Hmolar' , 'T ' ,T 0, 'P' ,P0, 'CO2' );
h0H2O =  CoolProp.PropsSI ( 'Hmolar' , 'T ' ,T 0, 'P' ,P0, 'H2O' );
h0CO =  CoolProp.PropsSI ( 'Hmolar' , 'T ' ,T 0, 'P' ,P0, 'CO' );
% h0NO =  CoolProp.PropsSI ('Hmolar','T ',T 0,'P',P0,'NO');
h0O2_p =  CoolProp.PropsSI ( 'Hmolar' , 'T ' ,T 0, 'P' ,P0, 'O2' );
h0N2_p =  CoolProp.PropsSI ( 'Hmolar' , 'T ' ,T 0, 'P' ,P0, 'N2' );


hpCO2=  CoolProp.PropsSI ( ' Hmolar ' , 'T ' ,T (4), 'P' ,ypCO2*P(3), 'CO2' )-h0CO2;
hpH2O=  CoolProp.PropsSI ( ' Hmolar ' , 'T ' ,T (4), 'P' ,ypH2O*P(3), 'H2O' )-h0H2O;
hpCO =  CoolProp.PropsSI ( ' Hmolar ' , 'T ' ,T (4), 'P' , ypCO *P(3), 'CO' )-h0CO;
hpNO =  cpNO * molmass_NO *(T(4)-T0);
hpO2_p=  CoolProp.PropsSI ( ' Hmolar ' , 'T ' ,T (4), 'P' ,ypO2*P(3), 'O2' )-h0O2_p;
hpN2_p=  CoolProp.PropsSI ( ' Hmolar ' , 'T ' ,T (4), 'P' ,ypN2*P(3), 'N2' )-h0N2_p;

h0CH4=  CoolProp.PropsSI ( 'Hmolar' , 'T ' ,T 0, 'P' ,P0, 'Methane' );
hpCH4=  CoolProp.PropsSI ( ' Hmolar ' , 'T ' ,T (2), 'P' ,P(2), 'Methane' )-h0CH4;

h0O2_r=  CoolProp.PropsSI ( 'Hmolar' , 'T ' ,T 0, 'P' ,P0, 'O2' );
hpO2_r=  CoolProp.PropsSI ( ' Hmolar ' , 'T ' ,T (2), 'P' ,0.21*P(2), 'O2' )-h0O2_r;

h0N2_r=  CoolProp.PropsSI ( 'Hmolar' , 'T ' ,T 0, 'P' ,P0, 'N2' );
hpN2_r=  CoolProp.PropsSI ( ' Hmolar ' , 'T ' ,T (2), 'P' ,0.79*P(2), 'N2' )-h0N2_r;

HFuel  = 1*(hfCH4+hpCH4);
HAir  = 2*(1+ EA)* hpO2_r + 2*3.76*(1+EA)*hpN2_r;
HProd  = double(b)*(hfCO2+hpCO2) + double(c)*(hfH2O+hpH2O) + double(d)*( hfCO+hpCO ) + double(e)*( hfNO+hpNO ) + double(f)*(hpO2_p) + double(g)*(hpN2_p);
MolProd =44+18+28+30+32+28;
h( 4)= abs( HProd )*1000/ MolProd ;

spCO2= CoolProp.PropsSI ( 'S' , 'T ' ,T (4), 'P' ,P(4), 'CO2' );
spH2O= CoolProp.PropsSI ( 'S' , 'T ' ,T (4), 'P' ,P(4), 'H2O' );
spCO = CoolProp.PropsSI ( 'S' , 'T ' ,T (4), 'P' ,P(4), 'CO' );
spO2= CoolProp.PropsSI ( 'S' , 'T ' ,T (4), 'P' ,P(4), 'O2' );
spN2= CoolProp.PropsSI ( 'S' , 'T ' ,T (4), 'P' ,P(4), 'N2' );

sp =ypCO2*spCO2 + ypH2O*spH2O +  ypCO * spCO  + ypO2*spO2 + ypN2*spN2;

s( 4)= sp ;
