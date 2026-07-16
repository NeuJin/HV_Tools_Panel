# test_capture_menu_on_open_2025.tcl — catch a menu's widget path +
# entries at the EXACT moment it's posted/opened (compat/hv2025.1
# investigation).
#
# Why: test_find_tools_menu_2025.tcl searched the live Tk tree AFTER
# the "Tools" dropdown had already been opened once and returned
# NOT FOUND, even though the menu was visibly on screen moments
# earlier. That's consistent with the menu's content being built by a
# -postcommand callback right before it's shown and cleared/destroyed
# after it closes — a persistent search always looks either too early
# or too late. This instead binds to the <Map> event on the Menu
# widget CLASS (fires for every Tk menu the instant it's shown,
# including ones built just-in-time by -postcommand), so we catch it
# live no matter how it's populated.
#
# Usage:
#   1. source this file in the HV Tcl Command Window
#   2. click through the menu bar in the GUI — especially "Tools"
#   3. each menu that opens gets printed here AND appended to
#      C:/temp/hvtools_menu_open_log.txt
#   4. look for the line whose entries include "Collision Detection" —
#      the widget path in that line is the real, live Tools menu.

namespace eval ::HVToolsMenu {}

proc ::HVToolsMenu::OnMenuMap {w} {
    set entries {}
    catch {
        set n [$w index end]
        if {$n ne "" && $n ne "none"} {
            for {set i 0} {$i <= $n} {incr i} {
                set lb ""
                catch {set lb [$w entrycget $i -label]}
                lappend entries $lb
            }
        }
    }
    set line "MENU OPENED: $w -> [join $entries {, }]"
    puts $line
    catch {
        file mkdir {C:/temp}
        set fh [open {C:/temp/hvtools_menu_open_log.txt} a]
        puts $fh $line
        close $fh
    }
}

bind Menu <Map> {+ ::HVToolsMenu::OnMenuMap %W}
puts "HVToolsMenu: menu-open capture armed. Click through the menu bar\
(especially Tools) now -- each opened menu is logged here and appended\
to C:/temp/hvtools_menu_open_log.txt."
