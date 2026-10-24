% Exergy Analysis

ex_comp =T0*(s(2)- s( 1));
ex_cc =T0*(s(4)-s(2)- q_in / T( 2));
ex_turb =T0*(s(5)- s( 4));
ex_cycle = ex_turb+ex_cc+ex_comp ;

% Efficiency                                                                                                                                                      q_out =(h(5)- h( 1)); 
eta_cycle =1-q_out/ q_in ;
                                                                                                                                                           
eta2_comp=1-ex_comp/ w_c ;
eta2_cc=1-ex_cc/( q_in );
eta2_turb=1-ex_turb/ w_t ;
