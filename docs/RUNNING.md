# Running the historical MATLAB model

Workflow prepared by source inspection. MATLAB execution, App Designer behavior, and binary compatibility were not tested.

## Dependencies

Use MATLAB with App Designer and Symbolic Math Toolbox (`syms`, `vpasolve`). The original MATLAB release is unspecified. The supplied `CoolProp.PropsSI` interface uses a legacy SWIG wrapper and `CoolPropMATLAB_wrap.mexw64`, targeting Windows 64-bit. It cannot be assumed to work on Linux, macOS, or every MATLAB release.

Current [official wrapper documentation](https://coolprop.org/coolprop/wrappers/MATLAB/index.html) describes Python and DLL access and notes legacy SWIG support ended. Installing the Python wrapper alone will not support the original MATLAB calls unchanged; a port must adapt and verify them.

## Extract the dependency

Set MATLAB's Current Folder to the repository root:

```matlab
projectRoot = pwd;
unzip(fullfile(projectRoot,'third_party','coolprop_legacy.zip'), ...
      fullfile(projectRoot,'third_party','coolprop_legacy'));
addpath(fullfile(projectRoot,'third_party','coolprop_legacy','cool'));
addpath(fullfile(projectRoot,'matlab'));
which CoolProp.PropsSI
hAir = CoolProp.PropsSI('H','T',298,'P',100000,'Air');
```

Resolve property-call failures before running the cycle model. The extracted dependency directory is ignored; retain its ZIP in version control.

## Function

`GasTur.m` preserves the historical equations while replacing the absolute dependency path. The original example call is:

```matlab
[P,T,h,s,ex_comp,ex_cc,ex_turb,ex_cycle,eta_cycle, ...
 eta2_comp,eta2_cc,eta2_turb,EA,b,c,d,e,f,g,AF] = ...
 GasTur(298,10000,8,0.85,0.9,1100,50000);
```

This is an execution example, not a verified result. The original MLX and extracted `gasturbn_original.m` retain their absolute path and script/function layout as baseline references.

## App

1. Open `app/app1.mlapp` in App Designer, working on a copy for edits.
2. In Code View, find the nested `GasTur` function inside the Calculate-button callback.
3. Replace its `E:` drive `addpath` line with your extracted `cool` folder path, or remove that line after adding the folder to MATLAB's path.
4. Keep `Schematic.jpg` beside the app; the interface locates it relative to the app file.
5. Run the app, enter inputs, and select Calculate. Check errors, units, and the technical notes before interpreting outputs.

The app has a separate embedded model. Changing `matlab/GasTur.m` does not change it. The app export is for readable review; edit the interface through MLAPP.

## Add your other code

Put helper functions in `matlab/` and inputs in a new `data/` folder. Document their purpose, dependencies, and execution order here. Save corrected results separately with units and inputs before updating performance claims.
