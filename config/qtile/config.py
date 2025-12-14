from libqtile import bar, layout, qtile, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
import subprocess


mod = "mod4"
terminal = guess_terminal()

myTerm = "kitty"  # My terminal of choice

keys = [
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key(
        [mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"
    ),
    Key(
        [mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key(
        [mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"
    ),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),
    Key(
        [mod],
        "t",
        lazy.window.toggle_floating(),
        desc="Toggle floating on the focused window",
    ),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key(
        [mod],
        "space",
        lazy.spawn("sh -c 'tofi-drun --drun-launch=true'"),
        desc="Run Launcher",
    ),
    Key(
        [],
        "Print",
        lazy.spawn('sh -c "slurp | grim -g - - | wl-copy"'),
        desc="Screenshot",
    ),
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl set +5%")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set 5%-")),
]

# Add key bindings to switch VTs in Wayland.
# We can't check qtile.core.name in default config as it is loaded before qtile is started
# We therefore defer the check until the key binding is run by using .when(func=...)
for vt in range(1, 8):
    keys.append(
        Key(
            ["control", "mod1"],
            f"f{vt}",
            lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
            desc=f"Switch to VT{vt}",
        )
    )


groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend(
        [
            # mod + group number = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc=f"Switch to group {i.name}",
            ),
            # mod + shift + group number = switch to & move focused window to group
            # Key(
            #     [mod, "shift"],
            #     i.name,
            #     lazy.window.togroup(i.name, switch_group=True),
            #     desc=f"Switch to & move focused window to group {i.name}",
            # ),
            # Or, use below if you prefer not to switch to that group.
            # # mod + shift + group number = move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name),
                desc="move focused window to group {}".format(i.name),
            ),
        ]
    )

colors = [
    ["#1f1f28", "#1f1f28"],  # bg0      (primary.background)
    ["#ddd8bb", "#ddd8bb"],  # fg1      (primary.foreground)
    ["#2a2a37", "#2a2a37"],  # color2   (normal.black)
    ["#e46876", "#e46876"],  # color3   (normal.red)
    ["#98bb6c", "#98bb6c"],  # color4   (normal.green)
    ["#e5c283", "#e5c283"],  # color5   (normal.yellow)
    ["#7e9cd8", "#7e9cd8"],  # color6   (normal.blue)
    ["#957fb8", "#957fb8"],  # color7   (normal.magenta)
    ["#7fb4ca", "#7fb4ca"],  # color8   (bright.cyan)
    ["#363646", "#363646"],  # color9   (bright.black)
]


# helper in case your colors are ["#hex", "#hex"]
def C(x):
    return x[0] if isinstance(x, (list, tuple)) else x


layout_theme = {
    "border_width": 1,
    # "margin": 1,
    "border_focus": colors[2],
    "border_normal": colors[9],
}

treetab_theme = {
    "section": [],
    "panel_width": 180,
    "section_top": 1,
    "section_bottom": 1,
    "section_left": 1,
    "section_right": 1,
    "padding_x": 1,
    "padding_y": 1,

    "bg_color": colors[0],
    "active_bg": colors[9],
    "active_fg": colors[1],
    "inactive_bg": colors[1],
    "inactive_fg": colors[9],
    "section_fg": colors[0],
    "urgent_bg": colors[3],
    "urgent_fg": colors[7],

    "fontsize": 14,
    "font": "Maple Mono NF",
    "section_fontsize": 14,
    "vspace": 1,
}

layouts = [
    layout.TreeTab(**treetab_theme),
    layout.Columns(**layout_theme),
    layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(**layout_theme),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
    layout.Floating(),
]

widget_defaults = dict(
    font="Maple Mono NF",
    # font="Ubuntu Bold",
    fontsize=14,
    padding=0,
    background=colors[0],
)


extension_defaults = widget_defaults.copy()

sep = widget.Sep(linewidth=1, padding=8, foreground=colors[9])

screens = [
    Screen(
        wallpaper="~/nixos-dotfiles/config/bg/kirby.jpg",
        wallpaper_mode="fill",
        top=bar.Bar(
            widgets=[
                widget.Spacer(length=8),
                widget.Prompt(font="Maple Mono NF", fontsize=14, foreground=colors[1]),
                widget.GroupBox(
                    fontsize=16,
                    margin_y=5,
                    margin_x=5,
                    padding_y=0,
                    padding_x=2,
                    borderwidth=3,
                    active=colors[8],
                    inactive=colors[9],
                    rounded=False,
                    highlight_color=colors[0],
                    highlight_method="line",
                    this_current_screen_border=colors[7],
                    this_screen_border=colors[4],
                    other_current_screen_border=colors[7],
                    other_screen_border=colors[4],
                ),
                widget.TextBox(
                    text="|",
                    font="Maple Mono NF",
                    foreground=colors[9],
                    padding=2,
                    fontsize=14,
                ),
                widget.CurrentLayout(foreground=colors[1], padding=5),
                widget.TextBox(
                    text="|",
                    font="Maple Mono NF",
                    foreground=colors[9],
                    padding=2,
                    fontsize=14,
                ),
                widget.WindowName(foreground=colors[6], padding=8, max_chars=40),
                widget.GenPollText(
                    update_interval=300,
                    func=lambda: subprocess.check_output(
                        "printf $(uname -r)", shell=True, text=True
                    ),
                    foreground=colors[3],
                    padding=8,
                    fmt="{}",
                ),
                sep,
                widget.CPU(
                    foreground=colors[4],
                    padding=8,
                    mouse_callbacks={
                        "Button1": lambda: qtile.cmd_spawn(myTerm + " -e btop")
                    },
                    format="CPU: {load_percent}%",
                ),
                sep,
                widget.Memory(
                    foreground=colors[8],
                    padding=8,
                    mouse_callbacks={
                        "Button1": lambda: qtile.cmd_spawn(myTerm + " -e btop")
                    },
                    format="Mem: {MemUsed:.0f}{mm}",
                ),
                sep,
                widget.DF(
                    update_interval=60,
                    foreground=colors[5],
                    padding=8,
                    mouse_callbacks={
                        "Button1": lambda: qtile.cmd_spawn(
                            'kitty --hold -e sh -c "duf"'
                        ),
                    },
                    partition="/",
                    # format = '[{p}] {uf}{m} ({r:.0f}%)',
                    format="{uf}{m} free",
                    fmt="Disk: {}",
                    visible_on_warn=False,
                ),
                sep,
                widget.Battery(
                    foreground=colors[6],  # pick a palette slot you like
                    padding=8,
                    update_interval=5,
                    format="{percent:2.0%} {char} {hour:d}:{min:02d}",  # e.g. "73% ⚡ 1:45"
                    fmt="Bat: {}",
                    charge_char="",  # shown while charging
                    discharge_char="",  # Nerd icon; use '-' if you prefer plain ascii
                    full_char="✔",  # when at/near 100%
                    unknown_char="?",
                    empty_char="!",
                    mouse_callbacks={
                        "Button1": lambda: qtile.cmd_spawn(
                            'kitty --hold -e sh -c "upower -i $(upower -e | grep BAT)"'
                        ),
                    },
                ),
                sep,
                widget.PulseVolume(
                    foreground=colors[7],
                    padding=8,
                    mouse_callbacks={"Button1": lambda: qtile.cmd_spawn("pavucontrol")},
                    fmt="Vol: {}",
                ),
                sep,
                widget.Clock(
                    foreground=colors[8],
                    padding=8,
                    mouse_callbacks={
                        "Button1": lambda: qtile.cmd_spawn('kitty -e sh -c "calcurse"'),
                    },
                    ## Uncomment for date and time
                    format="%a, %b %d - %H:%M",
                    ## Uncomment for time only
                    # format = "%I:%M %p",
                ),
                widget.Systray(padding=6),
                widget.Spacer(length=8),
            ],
            # 24,
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"],  # Borders are magenta
            margin=[0, 0, 0, 0],
            size=30,
        ),
    ),
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
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# xcursor theme (string or None) and size (integer) for Wayland backend
wl_xcursor_theme = None
wl_xcursor_size = 24

wmname = "LG3D"
