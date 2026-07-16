# global-init.tcl — HyperWorks Extension auto-init script.
#
# Runs once when this extension is registered/loaded via File >
# Extension Manager (autoLoad=true in extension.xml). Records this
# folder's own path in a global var so ribbon.xml's button command can
# find HVTools_Panel.tcl regardless of where the extension folder was
# unzipped/registered from (same portability trick hvtools_menu.tcl
# uses via [info script]).
#
# EXPERIMENTAL — first attempt at HW 2025.1's ribbon-based extension
# mechanism (compat/hv2025.1 branch). The classic Applications>Tools
# Tk-menu-injection approach (hvtools_menu.tcl) does not work on 2025.1:
# live testing showed the visible ribbon "Tools" tab entries aren't
# reachable as persistent Tk Menu widgets (see commit history on this
# branch). This extension package is the officially-documented
# alternative (Altair's Extension + Ribbon XML mechanism). Register via
# File > Extensions > Add Extension, browsing to the FOLDER this file
# lives in (NOT via "Import ribbon from XML" / "Import Custom Pages",
# a different GUI feature that never runs this script).

set ::HVToolsExtDir [file dirname [file normalize [info script]]]
puts "HV Tools extension loaded from: $::HVToolsExtDir"
