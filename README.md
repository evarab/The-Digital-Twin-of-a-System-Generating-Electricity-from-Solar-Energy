# Digital Twin of a Photovoltaic (PV) System

A MATLAB-based project for modelling the electrical behaviour of a photovoltaic module using the **two-diode model (DDM)**, numerical current calculation, and metaheuristic parameter estimation.

> **Project status:** This repository contains research and prototype code. The scripts and plots should be treated as an implementation snapshot, not as evidence of field-validated performance.

## 1. Project Overview

The project explores a digital-twin approach for a photovoltaic module by comparing a two-diode equivalent-circuit model with a set of voltage–current (I–V) data points.

The repository includes:

- A two-diode PV model implementation.
- Newton–Raphson-based numerical current calculation.
- War Strategy Optimization (WSO) code used for model-parameter estimation.
- A MATLAB graphical user interface (GUI) for generating I–V and P–V curves.
- An I–V dataset and example result plots.

The current dataset is derived from the **TSM60W module datasheet**. It should not be described as field-measured or laboratory-measured data: the repository snapshot does not establish outdoor or laboratory validation.

## 2. PV Module and Dataset

The included dataset contains 26 voltage–current points for the TSM60W module.

| Parameter | Value |
|---|---:|
| Open-circuit voltage, Voc | 24.62 V |
| Short-circuit current, Isc | 1.9098 A |
| Maximum-power voltage, Vmp | 20.84 V |
| Maximum-power current, Imp | 1.827 A |
| Number of I–V data points | 26 |

The values above are taken from the dataset included in this repository. They should be interpreted in the context of the source datasheet and its stated test conditions.

Dataset location:

```text
PV-Digital-Twin/data/IV_data.csv
```

**Implementation note:** In the current snapshot, `single_dd_2.m` defines the voltage and current vectors directly in the MATLAB code. The CSV file is included in the repository, but that objective-function script does not currently load the CSV. Therefore, changing the CSV alone will not change the optimization input.

## 3. Model and Numerical Methods

### Two-Diode Model

The main parameter-estimation workflow uses a two-diode equivalent-circuit model. Its parameter vector is represented as:

```text
[Iph, Io1, Io2, Rsh, Rs, n1, n2]
```

where:

- `Iph` is the photocurrent.
- `Io1` and `Io2` are the diode saturation currents.
- `Rsh` is the shunt resistance.
- `Rs` is the series resistance.
- `n1` and `n2` are the diode ideality factors (as represented in the implementation).

### Numerical and Optimization Methods

- **Newton–Raphson method:** used to calculate the PV output current for a given voltage and parameter set.
- **War Strategy Optimization (WSO):** used by the main parameter-estimation script to search for model parameters.
- **Logistic-map initialization:** implemented in `initialization.m` for generating the initial population.

The repository also contains `Ipv_newton_dd_2.m`, an alternative solver implementation. See the notes in the *Known implementation notes* section before using it.

## 4. Repository Structure

```text
.
└── PV-Digital-Twin/
    ├── data/
    │   └── IV_data.csv
    ├── results/
    │   ├── iv_curve.png
    │   ├── iv_pv_gui_curve.png
    │   └── pv_curve.png
    └── src/
        ├── Ipv_newton_dd.m
        ├── Ipv_newton_dd_2.m
        ├── PVPanelGUI.m
        ├── WSO.m
        ├── initialization.m
        ├── main_DDM.m
        └── single_dd_2.m
```

## 5. Running the MATLAB Code

Open MATLAB and set the project directory as the current folder. Add the `src` directory to the MATLAB path:

```matlab
addpath(fullfile(pwd, 'PV-Digital-Twin', 'src'));
```

If MATLAB's current folder is already `PV-Digital-Twin`, use:

```matlab
addpath(fullfile(pwd, 'src'));
```

### A. Run the parameter-estimation workflow

The main script is:

```matlab
main_DDM
```

It configures the WSO search, calls the objective function in `single_dd_2.m`, and generates optimization and model-comparison plots.

**Note:** `main_DDM.m` and `single_dd_2.m` currently use I–V values defined directly in the source code. The workflow does not currently read `data/IV_data.csv`.

### B. Run the PV Panel GUI

Run:

```matlab
PVPanelGUI
```

The GUI allows the user to enter irradiance and temperature values and displays calculated I–V and P–V curves. The GUI uses the parameter values defined inside `PVPanelGUI.m`; it is a separate demonstration and does not automatically use the optimized parameter vector produced by `main_DDM.m`.

## 6. Results

Example plot files are stored in:

```text
PV-Digital-Twin/results/
```

They include:

- `iv_curve.png`
- `pv_curve.png`
- `iv_pv_gui_curve.png`

These are example outputs included with the repository. They should not be interpreted as independent experimental validation. The current repository does not provide a documented field-test procedure or a complete measured-versus-simulated validation report.

## 7. Requirements

- MATLAB.
- The project source files in the `src` directory.

The included scripts use MATLAB functions such as `figure`, `plot`, `fmin`-style numerical operations, and standard array operations. No additional toolbox dependency is explicitly established by the source snapshot. Compatibility may vary by MATLAB release.

## 8. Known Implementation Notes

The following points should be considered when running or extending the current code:

1. **CSV loading:** `IV_data.csv` is present, but `single_dd_2.m` currently hardcodes the 26 I–V points instead of importing the CSV.
2. **Duplicate function name:** `Ipv_newton_dd_2.m` currently declares a function named `Ipv_newton_dd`, which is also declared in `Ipv_newton_dd.m`. MATLAB function/file naming and path resolution can therefore cause conflicts. Before using the alternative solver, rename its function declaration to `Ipv_newton_dd_2` and update any calls accordingly, or remove the unused duplicate if it is not required.
3. **Separate workflows:** `main_DDM.m` performs WSO-based parameter estimation, while `PVPanelGUI.m` uses its own parameter vector. The GUI is not currently connected to the optimization output.
4. **Reproducibility:** WSO uses random initialization and stochastic updates. Repeated runs may produce different results unless random-number generation is controlled and the run configuration is recorded.
5. **Validation:** Further work is required to establish performance under measured operating conditions, including clearly documented irradiance, cell/module temperature, measurement uncertainty, and test procedure.

## 9. Third-Party Code and References

This project includes or uses third-party algorithm code. The relevant source files retain their original attribution information.

- **War Strategy Optimization (WSO):** the source comments credit Tummala S. L. V. Ayyarao and cite related 2022 publications.
- **Population initialization:** `initialization.m` credits Jui-Sheng Chou and Dinh-Nhat Truong for the Jellyfish Search Optimizer source-code framework and cites Fister et al. (2015) in relation to chaos-based initialization.

Please see [`THIRD_PARTY_NOTICES.md`](THIRD_PARTY_NOTICES.md) for the component-level attribution and licensing information, if that file is present in the repository. Third-party licenses apply to their respective components; they do not automatically license the entire project.

## 10. Author

**Abdulkadir Doğan**  
Electrical & Electronics Engineering

---

This repository is shared for educational and research purposes. Please retain the relevant third-party copyright notices and license terms when redistributing or modifying third-party components.
