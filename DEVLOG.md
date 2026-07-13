# DEVLOG — HV_Tools_Panel (deploy bundle repo)

> 🔄 **HANDOFF (2026-07-10):** Đây là repo **DEPLOY**, không chứa source
> gốc — chỉ đóng gói `HV_Tools_Panel.zip` từ 2 repo lib để đồng nghiệp tải
> về dùng ngay. **Đọc DEVLOG.md của
> [Tcl_VonMises-stress-on-mutiple-step-load-](https://github.com/NeuJin/Tcl_VonMises-stress-on-mutiple-step-load-)**
> (nhánh `feat/multi-window-summary`) để biết kiến trúc/gotchas/lịch sử
> đầy đủ — file này chỉ ghi quy trình deploy.
>
> **Trạng thái zip mới nhất: v1.14** (commit `7f3d708`), chứa 13 file, đã
> push lên `main`. Repo này KHÔNG dùng feature branch — mọi commit thẳng
> vào `main` vì bản chất chỉ là snapshot đóng gói.

---

## Quy trình re-zip (BẮT BUỘC làm mỗi khi sửa 1 trong 2 repo nguồn)

Nguồn thật nằm ở 2 repo khác, KHÔNG sửa trực tiếp trong `staging/` của repo
này:
- `C:\Users\TechnoStar\Tcl_VonMises-stress-on-mutiple-step-load-\` (nhánh `feat/multi-window-summary`)
- `C:\Users\TechnoStar\Tcl_Safety-Factor-\` (nhánh `feat/multi-window-annotate`)

Các bước (đã làm ~14 lần trong session này, luôn theo đúng thứ tự):

```bash
# 1. Commit + push 2 repo nguồn trước (nếu có sửa)
# 2. Gom 13 file vào thư mục staging (tên thư mục = tên sẽ hiện khi user giải nén zip)
mkdir -p "C:/Users/TechnoStar/HV_Tools_Panel/staging/HV_Tools_Panel"
cd "C:/Users/TechnoStar/HV_Tools_Panel/staging/HV_Tools_Panel"
cp ".../Tcl_VonMises-stress-on-mutiple-step-load-/HVTools_Panel.tcl" .
cp ".../Tcl_VonMises-stress-on-mutiple-step-load-/hvtools_menu.tcl" .
cp ".../Tcl_VonMises-stress-on-mutiple-step-load-/maxstress_lib.tcl" .
cp ".../Tcl_VonMises-stress-on-mutiple-step-load-/MaxStress_Panel.tcl" .
cp ".../Tcl_VonMises-stress-on-mutiple-step-load-/TCL_StressExport.tcl" .
cp ".../Tcl_VonMises-stress-on-mutiple-step-load-/TCL_MaxStressAnnotate.tcl" .
cp ".../Tcl_VonMises-stress-on-mutiple-step-load-/README.md" ./README_MaxStress.md
cp ".../Tcl_Safety-Factor-/safetyfactor_lib.tcl" .
cp ".../Tcl_Safety-Factor-/SafetyFactor_Panel.tcl" .
cp ".../Tcl_Safety-Factor-/Conrod_SF_Find_NodeSet.tcl" .
cp ".../Tcl_Safety-Factor-/TCL_SFAnnotate.tcl" .
cp ".../Tcl_Safety-Factor-/SF_Debug.tcl" .
cp ".../Tcl_Safety-Factor-/README.md" ./README_SafetyFactor.md
```

```powershell
# 3. Nén (PowerShell, vì Bash zip không có sẵn trên máy này)
Compress-Archive -Path "C:\Users\TechnoStar\HV_Tools_Panel\staging\HV_Tools_Panel" `
  -DestinationPath "C:\Users\TechnoStar\HV_Tools_Panel\HV_Tools_Panel.zip" -Force
Remove-Item -Recurse -Force "C:\Users\TechnoStar\HV_Tools_Panel\staging"
```

```bash
# 4. Commit + push zip
cd "C:/Users/TechnoStar/HV_Tools_Panel"
git add HV_Tools_Panel.zip
git commit -m "feat: vX.Y — <mô tả ngắn>"
git push origin main
```

**Lưu ý:** `.gitignore` đã có `staging/` — không commit nhầm thư mục tạm.
`Remove-Item` xoá `staging/` đôi khi bị "process cannot access" nếu file
đang mở ở app khác (VD Notepad) — chạy lại sau khi đóng, không phải bug.

## Danh sách 13 file trong zip

```
HVTools_Panel.tcl       ★ user source cái này (panel gộp 2 tab)
hvtools_menu.tcl        ★ hoặc source cái này để có menu Applications>Tools>HV Tools Panel
maxstress_lib.tcl        (logic Max Stress, namespace ::MaxStress)
safetyfactor_lib.tcl     (logic Safety Factor, namespace ::SafetyFactor)
MaxStress_Panel.tcl      (panel đơn lẻ cũ — không còn cập nhật tính năng mới)
SafetyFactor_Panel.tcl   (panel đơn lẻ cũ — không còn cập nhật tính năng mới)
TCL_StressExport.tcl     (wrapper console cũ, gọi ::MaxStress::RunExport)
TCL_MaxStressAnnotate.tcl(wrapper console cũ, gọi ::MaxStress::RunAnnotate)
Conrod_SF_Find_NodeSet.tcl (wrapper console cũ, gọi ::SafetyFactor::RunExport)
TCL_SFAnnotate.tcl       (wrapper console cũ, gọi ::SafetyFactor::RunAnnotate)
SF_Debug.tcl             (script chẩn đoán 9 lớp, dùng khi query trả 0 rows)
README_MaxStress.md      (README gốc của repo VonMises)
README_SafetyFactor.md   (README gốc của repo Safety-Factor)
```

## Lịch sử version (commit trên `main`, mới nhất trước)

| Ver | Commit | Nội dung chính |
|---|---|---|
| v1.14 | `7f3d708` | annotate frame sync (animator step) + derived case mới nhất |
| v1.13 | `35873e2` | chữ note đen (HV2022) + nút Make Report hiện lại |
| v1.12 | `28229e4` | bỏ auto-load khi mở panel, chỉ prefill path |
| v1.11 | `6d092b1` | Make Report tách khỏi Export |
| v1.10 | `e5c19dd` | Load All bỏ qua odb thiếu + Stress_Report.csv pivot |
| v1.9  | `fd0413e` | nút Reset (New) + dọn model cũ robust hơn |
| v1.8  | `f2f9b27` | display options, legend TCL annotate, note layout |
| v1.7  | `9ae035b` | note trắng góc trái-dưới + padding + nhãn MAX/MIN |
| v1.6  | `1a896c3` | style note trắng; bỏ ô Load case SF |
| v1.5  | `87e3291` | SF tab: lưới per-window + precision/datatype |
| v1.4  | `04ab7a2` | precision + datatype/component droplist (Max Stress) |
| v1.3  | `71bde0d` | bảng Results per-window dạng lưới (Max Stress) |
| v1.2  | `8e00fb8` | toggle "Show note header" |
| v1.1.x| `26dce77`/`8694a16` | mã layout preset 4×2=19 |
| v1.1  | `39f8830` | thêm `hvtools_menu.tcl` vào bundle |
| v1.0  | `3841579` | bản đầu tiên (panel gộp + menu registration) |

## Việc còn treo

Toàn bộ nằm ở 2 repo nguồn — xem DEVLOG.md của
`Tcl_VonMises-stress-on-mutiple-step-load-` mục "Việc còn treo / chưa
xác nhận". Sau khi user xác nhận các fix mới nhất (`e8a126b`, `4a3544e`)
hoạt động đúng, cần re-zip lên **v1.15**.
