# Publish your gas turbine project on GitHub

A repository is a project folder with saved history. Its README is the introduction shown below the file list. A commit records a change with a short message. You can complete this guide using only the GitHub website.

## 1. Download and prepare

Download and extract `Gas_Turbine_GitHub_Package.zip`. Open its `gas-turbine-thermodynamic-analysis` folder. It includes the English report, LaTeX assets, original MATLAB script and app, dependency archive, README, and running instructions. Do not extract the CoolProp ZIP for the GitHub upload; extract it locally only when preparing to run MATLAB.

## 2. Create your repository

1. Go to https://github.com and choose Sign up if you do not have an account. Complete verification and sign in.
2. Open https://github.com/new.
3. Fill the fields as follows:

| Field | What to enter |
| --- | --- |
| Owner | Your personal account |
| Repository name | `gas-turbine-thermodynamic-analysis` |
| Description | `MATLAB gas turbine modeling with combustion equilibrium, energy and exergy analysis, and an App Designer interface.` |
| Visibility | Public for your portfolio; Private if you want to prepare it first |
| Add README | On; you will replace the starter README |
| Add .gitignore | None; the package includes one |
| License | None until you decide which reuse permissions to grant |

4. Click Create repository.

If you already have a repository intended for multiple projects, upload this entire project folder as a subfolder instead. Add a link to its README in your existing root README. For a standalone project, follow the next steps with the project contents at the repository root.

## 3. Upload the prepared contents

1. On the repository Code page, select Add file → Upload files.
2. Drag the extracted project folder's **contents** into the upload area: `README.md`, `.gitignore`, `report/`, `matlab/`, `app/`, `docs/`, and `third_party/`.
3. Keep paths such as `report/main.tex`, `app/app1.mlapp`, and `matlab/GasTur.m`. Do not upload only the outer ZIP.
4. Check that the README is at the repository root and the dependency remains a ZIP inside `third_party/`.
5. Enter this commit message:

```text
Add gas turbine report, MATLAB model, and App Designer interface
```

6. For the first upload to your own new repository, commit directly to the main branch if that option is offered, then click Commit changes. If GitHub instead offers a proposal workflow, follow its displayed steps.
7. Open the repository homepage. The supplied README should replace the starter, and its app screenshot should display.

GitHub allows up to 100 files per browser upload and 25 MiB per individual file. This prepared project fits those limits. If `.gitignore` is hidden, enable hidden items in your file manager or create it using Add file → Create new file and paste its contents. Browser uploads do not automatically filter chosen files through `.gitignore`.

## 4. Fill the About panel

Click the gear next to About on the Code page. Use this description:

```text
MATLAB gas turbine modeling with combustion equilibrium, energy and exergy analysis, and an App Designer interface.
```

Leave Website blank. Enter these Topics individually and save:

```text
matlab
thermodynamics
gas-turbine
combustion
exergy-analysis
coolprop
app-designer
mechanical-engineering
```

## 5. What to write in each README section

The supplied README is already written. Upload it directly; you do not need to compose it yourself.

| Section | Prepared content |
| --- | --- |
| Title and introduction | Project title, author, university, and software |
| Objective | Connect compression, combustion, expansion, and energy/exergy analysis |
| Methods | Property calls, element balances, equilibrium, searches, and interface |
| Example inputs | Original sample parameters with units and qualification |
| Results and limitations | What the source contains and the numerical issues still unresolved |
| Files | Links and explanations for all project components |
| Requirements and running | MATLAB, Symbolic Math Toolbox, CoolProp, and instructions |
| Build the report | Overleaf and local LaTeX compilation |
| Academic context and provenance | Course, source preservation, translation, and derived files |
| License and attribution | Current project permission status and third-party attribution |

Keep the technical qualifications until the model has been corrected and checked. The source report has no completed results table, and its app screenshot has blank outputs; do not claim a verified efficiency or optimization result.

## 6. Other repository tabs

| Tab or feature | What you should do |
| --- | --- |
| Code | Store the prepared files; README appears automatically |
| Issues | Optional tasks such as fixing excess-air selection or auditing units |
| Pull requests | Optional review of future changes |
| Actions | Leave unused initially; automation is optional |
| Projects | Optional task board |
| Wiki | Optional; documentation is already in README and docs |
| Security | No project description to enter |
| Insights | Automatically generated activity information |
| Settings | Keep defaults unless intentionally changing visibility or features |
| Releases | Optional downloadable milestones after a working version is verified |

These are features, not mandatory sections requiring written content.

## 7. Add the code you have elsewhere

The package already includes the original Live Script and app. For additional scripts:

1. Place helper functions under `matlab/` and inputs under a new `data/` folder.
2. Explain each file and the correct execution order in `docs/RUNNING.md`.
3. Update the README file table if needed.
4. Upload through Add file → Upload files and commit with `Add gas turbine helper functions and inputs`.

Keep the baseline versions identifiable. The app embeds its own calculation; changing the separate `GasTur.m` does not update it. Store revised-model results separately with inputs and units before updating numerical claims.

## 8. Compile the English LaTeX report

For the simplest Overleaf workflow, download `Gas_Turbine_English_LaTeX.zip`, create a new project using Upload Project, and select `main.tex`. Choose pdfLaTeX and compile. Keep `figures/` and `listings/` beside the source. No custom font, MATLAB installation, or CoolProp installation is needed to compile the report.

The complete GitHub package also contains the report under `report/`; if uploading that package to Overleaf, select the nested `report/main.tex` as the main document.

## 9. Edit and verify

To edit text on GitHub, open the file, choose the pencil, edit, preview, and commit. Upload a revised file at the same path to record a new version.

Check that the README image displays and its PDF link opens. GitHub may not preview MLAPP or MLX files; download and open them in MATLAB. The extracted `.m` files provide readable source online. Follow `docs/RUNNING.md` for dependency extraction and the app's original Windows path.

Your portfolio link will be:

```text
https://github.com/YOUR-USERNAME/gas-turbine-thermodynamic-analysis
```

Replace `YOUR-USERNAME` with your actual username. Pin the repository from your GitHub profile using Customize your pins if you want it prominently displayed.

## 10. ATS-friendly CV line

Developed a MATLAB gas turbine model with combustion equilibrium, exergy analysis, and an App Designer interface.

Official references:

- https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-new-repository
- https://docs.github.com/en/repositories/working-with-files/managing-files/adding-a-file-to-a-repository
- https://coolprop.org/coolprop/wrappers/MATLAB/index.html
