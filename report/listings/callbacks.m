%Composition
             app.EA.Value = string( EA);
             app. b.Value =string(double(b));
             app. c.Value =string(double(c));
             app. d.Value =string(double(d));
             app. e.Value =string(double(e));
             app. f.Value =string(double(f));
             app. g.Value =string(double(g));
             %Show pressures
             app.P 1PaEditField_2.Value=string(P(1));
             app.P2PaEditField.Value =string(P(2));
             app.P4PaEditField.Value =string(P(4));
             app.P5PaEditField.Value =string(P(5));
             %Show entropies
             app.s1kJkgKEditField.Value =string(s(1)/1000);
             app.s2kJkgKEditField.Value =string(s(2)/1000);
             app.s4kJkgKEditField.Value =string(s(4)/1000);
             app.s5kJkgKEditField.Value =string(s(5)/1000);
             %Show enthalpies
             app.h1kJkgEditField.Value =string(h(1)/1000);
             app.h2kJkgEditField.Value =string(h(2)/1000);
             app.h4kJkgEditField.Value =string(h(4)/1000);
             app.h5kJkgEditField.Value =string(h(5)/1000);
             %Show temperatures
             app.T 1KEditField_2.Value=string(T(1));
             app.T2KEditField.Value =string(T(2));
             app.T 4KEditField_2.Value=string(T(4));
             app.T5KEditField.Value =string(T(5));
             %Show Exergies
             app.ExdCompkJkgEditField.Value =string( ex_comp );
             app.ExdCCkJkgEditField.Value =string( ex_cc );
             app.ExdTurbinekJkgEditField.Value =string( ex_turb );
             app.ExdCyclekJkgEditField.Value =string( ex_comp+ex_turb+ex_cc );
             %Others
             app.etaCycleEditField.Value =string( eta_cycle );
             app.etaIICompEditField.Value =string(eta2_comp);
             app.etaIICCEditField.Value =string(eta2_cc);
             app.etaIITurbineEditField.Value =string(eta2_turb);
             app.AirFuelratioEditField.Value =AF;
