# Source issues before numerical claims

Observations from the supplied report and native code; no corrected simulation results are provided.

1. The excess-air search compares each residual with the preceding trial, rather than retaining a global best. `EA=1.4` then overrides its selection.
2. `q_in` is retained from the final loop while composition is recomputed at fixed EA. Its units and meaning must be reconciled with mass-specific heat rejection.
3. `MolProd=44+18+28+30+32+28` ignores product coefficients. Report and code also use different entropy conversion denominators. Use a consistent molar or reaction-total basis and composition-dependent mass conversion.
4. State 4 mixes mass-specific species entropy using mole fractions. Review mixture entropy, partial pressures, NO approximation, and the phase/reference state for water formation enthalpy.
5. The outlet temperature search enforces an isentropic entropy condition but labels its output as actual state 5. `s(5)` uses the last trial rather than the saved selected trial. Check consistency with actual enthalpy and turbine work.
6. The Live Script divides heat rejection by 9 and later combustion exergy by 900; the app includes divisions by 100 in component expressions. The Word report does not show all these factors. No justification is documented.
7. Define consistent energy and physical/chemical exergy balances for the reacting open system. Absolute values do not replace a signed energy balance.
8. Audit all J/kg and kJ/kg labels, arguments, and displayed conversions.

The English report preserves historical expressions and adds a separate editorial appendix. No model validation or numerical performance result was invented during preparation.
