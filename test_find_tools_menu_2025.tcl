# test_find_tools_menu_2025.tcl — one-shot diagnostic for HW 2025.1 compat
# (branch compat/hv2025.1).
#
# The classic Applications>Tools menu (hw item id=19, HvTrans/HgTrans/
# HW GUI Toolkit/HwLogViewer) is NOT the menu hvtools_menu.tcl actually
# needs on 2025.1 Results/HyperView context — the REAL, visible "Tools"
# dropdown there (Collision Detection/Systems Review/Mask/Entity
# Attributes/Apply Style/Extract Solver Deck Data/Synchronize Animation/
# Abaqus Result Diagnostics/Contour Measure Curve/Import/Export) is a
# different Tk Menu widget entirely. This walks the live Tk tree and
# finds it by its unique entry label "Collision Detection", instead of
# guessing blind.
#
# Usage: source this file in the HV Tcl Command Window, then read the
# printed widget path (or "" if not found).

namespace eval ::HVToolsMenu {}

proc ::HVToolsMenu::_findMenuByEntry {w label} {
    foreach c [winfo children $w] {
        if {[winfo class $c] eq "Menu"} {
            set n ""
            catch {set n [$c index end]}
            if {$n ne "" && $n ne "none"} {
                for {set i 0} {$i <= $n} {incr i} {
                    set lb ""
                    catch {set lb [$c entrycget $i -label]}
                    if {$lb eq $label} { return $c }
                }
            }
        }
        set r [::HVToolsMenu::_findMenuByEntry $c $label]
        if {$r ne ""} { return $r }
    }
    return ""
}

set ::_toolsMenuPath [::HVToolsMenu::_findMenuByEntry . "Collision Detection"]
if {$::_toolsMenuPath ne ""} {
    puts "FOUND real Tools menu widget: $::_toolsMenuPath"
} else {
    puts "NOT FOUND — 'Collision Detection' entry not located anywhere in the live Tk tree."
}
