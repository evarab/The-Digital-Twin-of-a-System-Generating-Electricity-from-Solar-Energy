# Digital Twin of a Photovoltaic Panel System

## 1. Project Overview
This project develops a **digital twin** of a photovoltaic (PV) panel using real-world field measurements, numerical modeling, and optimization-based parameter estimation. The digital twin replicates the electrical behavior of a TSM60W solar module under varying irradiance and temperature conditions.

The system integrates:
- Field-measured I–V data under different irradiance levels
- MATLAB modeling and curve fitting
- Single-diode model parameter extraction
- Graphical validation through I–V and P–V curves

This repository demonstrates practical engineering skills in data acquisition, modeling, analysis, and validation.

---

## 2. Features
- Real-world field measurements (V, I, irradiance, load variation)
- Laboratory measurements using halogen light source
- MATLAB implementation of:
  - PV model equations (Single-Diode Model)
  - Curve fitting and parameter identification
  - I–V and P–V curve generation
- Comparison between measured and simulated data
- Plots and analysis included for transparency

---

## 3. Hardware Used
- **TSM60W PV panel**
- **Multimeter (current/voltage)**
- Adjustable load (resistive bank)
- Calibrated pyranometer
- Halogen projector lamp (laboratory tests)
- Temperature sensor (for ambient tracking)

---

## 4. Data Summary
- **Irradiance:** **636.85 W/m²**  
- **Number of measurement points:** **26**  
- **Data origin:**  
  Measurement points were obtained from the PV module datasheet and validated with outdoor readings at constant irradiance.

Dataset file:

```
Data/IV_data.csv
```

---

## 5. MATLAB Implementation
### Key Components
- Single-diode PV model
- Newton-Raphson and numerical solvers
- Curve-fitting for extracting:
  - Shunt resistance
  - Series resistance
  - Photocurrent (Iph)
  - Saturation current (Io)
  - Ideality factor (n)

### Running the Code
```matlab
main.m
```
This script:
1. Loads field and laboratory measurement data.
2. Fits the PV model parameters.
3. Generates I–V and P–V curves.
4. Exports the results.

Dependencies:
- MATLAB R2022+ recommended
- Optimization Toolbox

---

## 6. Results
The project includes:
- Measured I–V curve
- Simulated I–V curve
- Error comparison chart
- Power curve (P–V)
- Extracted model parameters

These results validate that the digital twin accurately reflects real PV panel behavior.

Plots are located in the `results/` directory.

---

## 7. Repository Structure
```
📦 PV-Digital-Twin
 ┣ 📂 data
 ┃ ┣ IV_data.csv 
 ┣ 📂 src
 ┃ ┣ main.m
 ┃ ┣ PVPanelGUI.m
 ┃ ┣ Ipv_newton_dd.m
 ┃ ┣ Ipv_newton_dd_2.m
 ┃ ┣ initialization.m
 ┃ ┣ single_dd_2.m
 ┃ ┗ WSO.m
 ┣ 📂 results
 ┃ ┣ iv_curve.png
 ┃ ┣ pv_curve.png
 ┃ ┗ iv_pv_gui_curve.png
 ┗ README.md
```

---

## 8. Future Improvements
- Implementing PSO / WSO parameter optimization
- Temperature‑dependent model enhancement
- GUI-based real‑time simulation
- Integration with microcontroller data acquisition (ESP32/STM32)

---

## 9. Author
**Abdulkadir Doğan**  
Electrical & Electronics Engineer  
Focused on PV systems, digital twins, and computational modeling.

---

If you use any part of this project, please cite or reference the repository.

