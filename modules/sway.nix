{ config, pkgs, lib, ... }:
{
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true; # Fixes common issues with GTK 3 apps
    config = rec {
      modifier = "Mod4";
      # Use kitty as default terminal
      terminal = "kitty";
      menu = "dmenu_path | ${pkgs.wmenu}/bin/wmenu | xargs swaymsg exec --";
      
      # Font configuration
      fonts = {
        names = [ "monospace" ];
        size = 13.0;
      };
      
      # Key bindings
      keybindings = let
        modifier = config.wayland.windowManager.sway.config.modifier;
      in lib.mkOptionDefault {
        "${modifier}+Return" = "exec ${terminal}";
        "${modifier}+Shift+q" = "kill";
        "${modifier}+d" = "exec ${menu}";
        "${modifier}+Shift+c" = "reload";
        "${modifier}+Shift+e" = "exec ${pkgs.sway}/bin/swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -B 'Yes, exit sway' 'swaymsg exit'";
        
        # Direction keys (Dvorak)
        "${modifier}+n" = "focus left";
        "${modifier}+h" = "focus down";
        "${modifier}+t" = "focus up";
        "${modifier}+l" = "focus right";
        
        # Arrow keys alternative
        "${modifier}+Left" = "focus left";
        "${modifier}+Down" = "focus down";
        "${modifier}+Up" = "focus up";
        "${modifier}+Right" = "focus right";
        
        # Move windows
        "${modifier}+Shift+n" = "move left";
        "${modifier}+Shift+h" = "move down";
        "${modifier}+Shift+t" = "move up";
        # Note: "${modifier}+Shift+l" is missing from original as it's commented out
        
        # Arrow keys for moving
        "${modifier}+Shift+Left" = "move left";
        "${modifier}+Shift+Down" = "move down";
        "${modifier}+Shift+Up" = "move up";
        "${modifier}+Shift+Right" = "move right";
        
        # Workspaces
        "${modifier}+1" = "workspace number 1";
        "${modifier}+2" = "workspace number 2";
        "${modifier}+3" = "workspace number 3";
        "${modifier}+4" = "workspace number 4";
        "${modifier}+5" = "workspace number 5";
        "${modifier}+6" = "workspace number 6";
        "${modifier}+7" = "workspace number 7";
        "${modifier}+8" = "workspace number 8";
        "${modifier}+9" = "workspace number 9";
        "${modifier}+0" = "workspace number 10";
        
        # Move containers to workspaces
        "${modifier}+Shift+1" = "move container to workspace number 1";
        "${modifier}+Shift+2" = "move container to workspace number 2";
        "${modifier}+Shift+3" = "move container to workspace number 3";
        "${modifier}+Shift+4" = "move container to workspace number 4";
        "${modifier}+Shift+5" = "move container to workspace number 5";
        "${modifier}+Shift+6" = "move container to workspace number 6";
        "${modifier}+Shift+7" = "move container to workspace number 7";
        "${modifier}+Shift+8" = "move container to workspace number 8";
        "${modifier}+Shift+9" = "move container to workspace number 9";
        "${modifier}+Shift+0" = "move container to workspace number 10";
        
        # Move workspaces between screens
        "${modifier}+Shift+w" = "move workspace to output right";
        "${modifier}+Shift+m" = "move workspace to output left";
        
        # Layout controls
        "${modifier}+m" = "splith";
        "${modifier}+v" = "splitv";
        "${modifier}+s" = "layout stacking";
        "${modifier}+w" = "layout tabbed";
        "${modifier}+e" = "layout toggle split";
        "${modifier}+f" = "fullscreen";
        "${modifier}+Shift+space" = "floating toggle";
        
        # Scratchpad
        "${modifier}+Shift+minus" = "move scratchpad";
        "${modifier}+minus" = "scratchpad show";
        
        # Resize mode
        "${modifier}+Shift+r" = "mode resize";
        
        # Custom app bindings
        "${modifier}+b" = "exec ${pkgs.brave}/bin/brave";
        "${modifier}+Shift+l" = "exec ${pkgs.swaylock}/bin/swaylock";
        
        # Media keys
        "XF86MonBrightnessUp" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set +5%";
        "XF86MonBrightnessDown" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 5%-";
        "XF86AudioRaiseVolume" = "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "XF86AudioLowerVolume" = "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -5%";
        "XF86AudioMute" = "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle";
      };
      
      # Define resize mode
      modes = {
        "resize" = {
          "n" = "resize shrink width 10px";
          "h" = "resize grow height 10px";
          "t" = "resize shrink height 10px";
          "l" = "resize grow width 10px";
          "Left" = "resize shrink width 10px";
          "Down" = "resize grow height 10px";
          "Up" = "resize shrink height 10px";
          "Right" = "resize grow width 10px";
          "Return" = "mode default";
          "Escape" = "mode default";
        };
      };
      
      # Input configuration
      input = {
        "*" = {
          xkb_layout = "pl,es";
          xkb_variant = "dvp,dvorak";
          xkb_options = "ctrl:swap_lalt_lctl_lwin,grp:alt_space_toggle";
        };
        "type:touchpad" = {
          dwt = "enabled";
          tap = "enabled";
          middle_emulation = "enabled";
        };
      };
      
      # Bar configuration
      bars = [
        {
          position = "top";
          statusCommand = "${pkgs.i3status}/bin/i3status";
          fonts = {
            names = [ "monospace" ];
            size = 13.0;
          };
          colors = {
            statusline = "#ffffff";
            background = "#323232";
            inactiveWorkspace = {
              background = "#32323200";
              border = "#32323200";
              text = "#5c5c5c";
            };
          };
        }
      ];
      
      # Startup applications
      startup = [
        { command = "${pkgs.firefox}/bin/firefox"; }
      ];
      
      # Default wallpaper - adjust path as needed for your NixOS setup
      output = {
        "*" = {
          bg = "${pkgs.sway}/share/backgrounds/sway/Sway_Wallpaper_Blue_1920x1080.png fill";
        };
      };
      
      # Extra settings from original config
      floating.modifier = "${modifier} normal";
    };
  };
  
  # Make sure these packages are installed
  home.packages = with pkgs; [
    brightnessctl
    i3status
    dmenu
    # wmenu
    brave
    swaylock
    pulseaudio
    firefox
  ];
}
