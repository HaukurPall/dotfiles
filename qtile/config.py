# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from typing import List, Mapping, Union  # noqa: F401
import logging

from Xlib import display

from libqtile import bar, layout, hook, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from libqtile.widget.currentlayout import CurrentLayout
from libqtile.widget.textbox import TextBox
from libqtile.widget.wallpaper import Wallpaper
from libqtile.widget.groupbox import GroupBox
from libqtile.widget.volume import Volume
from libqtile.widget.groupbox import GroupBox
from libqtile.widget.sep import Sep
from libqtile.widget.battery import Battery
from libqtile.widget.wlan import Wlan


log = logging.getLogger("libqtile")


mod = "mod4"
terminal = guess_terminal()

# fmt: off
keys = [
    # Switch between windows in current stack pane
    Key([mod], "j", lazy.layout.down(), desc="Move focus down in stack pane"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up in stack pane"),
    # Move windows up or down in current stack
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down in current stack "),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up in current stack "),
    # Toggle between different layouts as defined below
    Key([mod, "control"], "l", lazy.layout.grow_right(), lazy.layout.grow(), lazy.layout.increase_ratio()),
    Key([mod, "control"], "h", lazy.layout.grow_left(), lazy.layout.shrink(), lazy.layout.decrease_ratio()),
    Key([mod, "control"], "k", lazy.layout.grow_up(), lazy.layout.grow(), lazy.layout.decrease_nmaster()),
    Key([mod, "control"], "j", lazy.layout.grow_down(), lazy.layout.shrink(), lazy.layout.increase_nmaster()),
    # On windows
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "shift"], "f", lazy.window.toggle_floating()),
    Key([mod], "m", lazy.window.toggle_fullscreen()),
    Key([mod], "Tab", lazy.spawn('rofi -show window'), desc="swap to window prompt"),
    # Qtile
    Key([mod, "control"], "r", lazy.restart(), desc="Restart qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown qtile"),
    # Layout changing
    Key([mod], "space", lazy.next_layout(), desc="Toggle between layouts"),
    # Start other programs
    Key([mod], "t", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "f", lazy.spawn("firefox"), desc="Launch Firefox"),
    Key([mod], "r", lazy.spawn('rofi -show combi'), desc="run prompt"),
    # Special keys
    Key([], "XF86AudioMute", lazy.spawn("pulseaudio-ctl mute")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("pulseaudio-ctl up")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pulseaudio-ctl up")),
    Key([], "XF86MonBrightnessUp", lazy.spawn("light -A 10")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("light -U 10")),
    Key([], "XF86KbdBrightnessUp", lazy.spawn("light -k -A 10")),
    Key([], "XF86KbdBrightnessDown", lazy.spawn("light -k -U 10")),
]
# fmt: on

group_configs = [
    {"name": "Top(1)", "key": "1"},
    {"name": "Hakk(2)", "key": "2"},
    {"name": "Chat(3)", "key": "3", "matches": [Match(wm_class=["slack", "microsoft teams - preview", "telegram-desktop"])]},
    {"name": "Code(4)", "key": "4"},
    {"name": "Vinna(5)", "key": "5"},
    {"name": "Free(6)", "key": "6"},
    {"name": "Back(7)", "key": "7", "matches": [Match(wm_class=["spotify", "keepassxc"])]},
]

groups = []

for group_config in group_configs:
    # fmt: off
    key = group_config["key"]
    name = group_config["name"]
    matches = group_config["matches"] if "matches" in group_config else None
    groups.append(Group(name, matches=matches))
    keys.extend(
        [Key([mod], key, lazy.group[name].toscreen(), desc="Switch to group {}".format(name)),
         Key([mod, "shift"], key, lazy.window.togroup(name, switch_group=True), desc="Switch to & move focused window to group {}".format(name)),
        ]
    )

@hook.subscribe.client_new
def grouper(window):
    """Handle specific windows."""
    log.warning(f"window {window}")
    log.warning(f"window.window.type {window.window.get_wm_type()}")
    log.warning(f"window.window.class {window.window.get_wm_class()}")

    # fmt: on
layout_theme: Mapping[str, Union[int, str]] = {
    "border_width": 2,
    "margin": 2,
    # "border_focus": "e1acff",
    "border_normal": "282a36",
}
layouts = [
    layout.MonadTall(**layout_theme),
    # layout.Stack(num_stacks=4),
    # layout.Bsp(),
    # layout.Columns(),
    # layout.Matrix(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(**layout_theme),
    # layout.Max(**layout_theme),
    # layout.TreeTab(**layout_theme),
    # layout.VerticalTile(),
    # layout.Zoomy(**layout_theme),
]

widget_defaults = dict(
    font="mononoki",
    fontsize=14,
    padding=2,
)
extension_defaults = widget_defaults.copy()
# Wallpaper(directory=".config/variety/Downloaded/", random_selection=True),
get_screen = lambda: Screen(
    top=bar.Bar(
        [
            CurrentLayout(),
            Sep(padding=10),
            TextBox(
                "Term",
                mouse_callbacks={"Button1": lambda qtile: qtile.cmd_spawn("konsole")},
            ),
            Sep(padding=10),
            GroupBox(),
            Sep(padding=10),
            widget.WindowName(),
            widget.Chord(
                chords_colors={
                    "launch": ("#ff0000", "#ffffff"),
                },
                name_transform=lambda name: name.upper(),
            ),
            widget.Systray(),
            Sep(padding=10),
            Wlan(
                interface="wlp3s0", update_interval=5, format="{essid} {percent:2.0%}"
            ),
            Sep(padding=10),
            Battery(
                battery=0,
                discharge_char="🠗",
                charge_char="🠕",
                format="{percent:2.0%} {char}",
            ),
            Sep(padding=10),
            Volume(),
            Sep(padding=10),
            widget.Clock(format="%d %B %a %H:%M"),
            widget.QuickExit(default_text="↺"),
        ],
        24,
    ),
)

def get_num_screens():
    """Get the number of screens connected."""
    d = display.Display()
    s = d.screen()
    r = s.root
    res = r.xrandr_get_screen_resources()._data

    # Dynamic multiscreen! (Thanks XRandr)
    num_screens = 0
    for output in res['outputs']:
        print("Output %d:" % (output))
        mon = d.xrandr_get_output_info(output, res['config_timestamp'])._data
        log.warning(f"monitor {mon}")
        if mon['num_preferred']:
            num_screens += 1
    log.warning(f"Found {num_screens} number of screens")
    return num_screens

num_screens = get_num_screens()
screens = [
        get_screen() for _ in range(num_screens)
        ]

# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None  # WARNING: this is deprecated and will be removed soon
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        {"wmclass": "confirm"},
        {"wmclass": "dialog"},
        {"wmclass": "download"},
        {"wmclass": "error"},
        {"wmclass": "file_progress"},
        {"wmclass": "notification"},
        {"wmclass": "splash"},
        {"wmclass": "toolbar"},
        {"wmclass": "confirmreset"},  # gitk
        {"wmclass": "makebranch"},  # gitk
        {"wmclass": "maketag"},  # gitk
        {"wname": "branchdialog"},  # gitk
        {"wname": "pinentry"},  # GPG key password entry
        {"wmclass": "ssh-askpass"},  # ssh-askpass
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"

# Hooks
@hook.subscribe.startup_once
def autostart():
    """Autostart."""
    pass


@hook.subscribe.screen_change
def restart_on_randr(qtile, ev):
    """Restart qtile."""
    qtile.cmd_restart()


# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
