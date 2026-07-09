# HV Tools Panel — Max Stress + Safety Factor (HyperView TCL Add-in)

One-package deployment of the HyperView post-processing tool suite:
a combined tabbed panel that loads a multi-window session, sweeps
**max Von Mises stress** across crank-angle frames, extracts **min
Safety Factor**, and annotates the critical nodes — all from buttons.

**Author:** Nguyen Tan Loc — Simulation Engineer
Technostar Co., Ltd (Outsourced to Suzuki Motor Corporation)

---

## Download & run

1. Download **[`HV_Tools_Panel.zip`](HV_Tools_Panel.zip)** and extract it
   anywhere (all files stay in one folder).
2. In HyperView: `View → Command Window`, then:
   ```tcl
   source <extracted path>/HV_Tools_Panel/HVTools_Panel.tcl
   ```
   Or auto-open at startup:
   ```
   hw.exe <model_or_session> -tcl <path>/HVTools_Panel.tcl
   ```

## The combined panel (`HVTools_Panel.tcl`)

- **0. Load model & results** (shared, top): one model file for every
  window + one result file per line (each gets its own window) + page
  layout (default 4×2 = 8 windows). Paths persist and **auto-load when
  the panel opens**.
- **Max Stress tab**: full-sweep export over all windows → single
  `Stress_Summary.csv` → annotate (pink node-ID marker + summary note
  with angle / node / value) → editable results table (fix Node ID or
  Angle, re-query the value straight from HyperView).
- **Safety Factor tab**: same flow for min `Endure_SF_A` on one load
  case — no frame sweep. Set IDs or set **names** (e.g. `Pos3`) accepted.

## Contents

| File | Role |
|------|------|
| `HVTools_Panel.tcl` | ★ Combined tabbed panel (this is the one to source) |
| `maxstress_lib.tcl` | Max Stress logic (export / annotate / re-query / load) |
| `safetyfactor_lib.tcl` | Safety Factor logic |
| `MaxStress_Panel.tcl` / `SafetyFactor_Panel.tcl` | Standalone single-tool panels |
| `TCL_StressExport.tcl` / `TCL_MaxStressAnnotate.tcl` | Console wrappers (Max Stress) |
| `Conrod_SF_Find_NodeSet.tcl` / `TCL_SFAnnotate.tcl` | Console wrappers (Safety Factor) |
| `SF_Debug.tcl` | Layer-by-layer diagnostic for empty-query issues |
| `README_MaxStress.md` / `README_SafetyFactor.md` | Per-tool documentation |

## Source repositories

- Max Stress: [Tcl_VonMises-stress-on-mutiple-step-load-](https://github.com/NeuJin/Tcl_VonMises-stress-on-mutiple-step-load-)
- Safety Factor: [Tcl_Safety-Factor-](https://github.com/NeuJin/Tcl_Safety-Factor-)

Tested on HyperWorks v14.0 (HyperView), Tcl/Tk bundled — no extra installs.
