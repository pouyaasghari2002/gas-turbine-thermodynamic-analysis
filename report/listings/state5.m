% State 5(after gas turbine)
s5s= s( 4);
P( 5)= P(1);

h5s= h( 4)- w_t / eta_t ;
h( 5)= h(4)- w_t ;
T5LB = 650;
deltaS  = 1e10;

for  T5s = (300):1:(1000)
    s5sCO2 =  CoolProp.PropsSI ( 'Smolar' , 'T ' ,T 5s, 'P' ,ypCO2*P(5), 'CO2' );
    s5sH2O =  CoolProp.PropsSI ( 'Smolar' , 'T ' ,T 5s, 'P' ,ypH2O*P(5), 'H2O' );
    s5sCO =  CoolProp.PropsSI ( 'Smolar' , 'T ' ,T 5s, 'P' ,ypCO*P(5), 'CO' );
    s5sO2 =  CoolProp.PropsSI ( 'Smolar' , 'T ' ,T 5s, 'P' ,ypO2*P(5), 'O2' );
    s5sN2 =  CoolProp.PropsSI ( 'Smolar' , 'T ' ,T 5s, 'P' ,ypN2*P(5), 'N2' );

    s5sTest0 = s5sCO2*ypCO2 + s5sH2O*ypH2O + s5sCO* ypCO  + s5sO2*ypO2 + s5sN2*ypN2;
    s5sTest= s5sTest0/(( MolProd )   /1000);
     if  (abs(s5sTest-s5 s)< deltaS )
        T5sf=T5s;
        s5sf=s5sTest;
     end 
     deltaS  = abs(s5sTest-s5s);
end
s( 5)=s5sTest;
T( 5)=T5sf;
