# home.nix for Home Manager (without NixOS)
{ config, pkgs, lib, ... }: {
  wayland.windowManager.sway.enable = false;
  xdg.desktopEntries = {
    i3 = {
      name = "i3";
      comment = "Improved tiling window manager";
      exec = "i3";
      type = "Application";
      categories = [ "System" "X-WindowManager" ];
    };
  };

  # Enable X session with i3
  xsession = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      config = {
        modifier = "Mod4";
        gaps = {
          inner = 10;
          outer = 5;
        };

        # Font for window titles
        fonts = {
          names = [ "monospace" ];
          size = 14.0;
        };

        # Use Mouse+$mod to drag floating windows
        floating = { modifier = "Mod4"; };

        # Terminal
        terminal = "kitty";

        # Key bindings
        keybindings =
          let modifier = config.xsession.windowManager.i3.config.modifier;
          in lib.mkOptionDefault {
            "${modifier}+Return" = "exec kitty";
            "${modifier}+Shift+q" = "kill";
            "${modifier}+d" = "exec --no-startup-id dmenu_run";

            # Change focus
            "${modifier}+l" = "focus left";
            "${modifier}+t" = "focus down";
            "${modifier}+h" = "focus up";
            "${modifier}+n" = "focus right";

            # Alternatively, use cursor keys
            "${modifier}+Left" = "focus left";
            "${modifier}+Down" = "focus down";
            "${modifier}+Up" = "focus up";
            "${modifier}+Right" = "focus right";

            # Move focused window
            "${modifier}+Shift+j" = "move left";
            "${modifier}+Shift+k" = "move down";
            "${modifier}+Shift+l" = "move up";
            "${modifier}+Shift+semicolon" = "move right";

            # Alternatively, use cursor keys for moving
            "${modifier}+Shift+Left" = "move left";
            "${modifier}+Shift+Down" = "move down";
            "${modifier}+Shift+Up" = "move up";
            "${modifier}+Shift+Right" = "move right";

            # Split orientation
            "${modifier}+v" = "split v";

            # Fullscreen
            "${modifier}+f" = "fullscreen toggle";

            # Container layout
            "${modifier}+s" = "layout stacking";
            "${modifier}+w" = "layout tabbed";
            "${modifier}+e" = "layout toggle split";

            # Toggle floating/tiling
            "${modifier}+Shift+space" = "floating toggle";
            "${modifier}+space" = "focus mode_toggle";

            # Focus parent container
            "${modifier}+a" = "focus parent";

            # Workspace switching
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

            # Move container to workspace
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

            # Reload, restart, exit
            "${modifier}+Shift+c" = "reload";
            "${modifier}+Shift+r" = "restart";
            "${modifier}+Shift+e" = ''
              exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -B 'Yes, exit i3' 'i3-msg exit'"'';

            # Resize mode
            "${modifier}+r" = "mode resize";

            # Move workspaces between monitors
            "${modifier}+Shift+h" = "move workspace to output right";
            "${modifier}+Shift+t" = "move workspace to output left";

            # Media keys
            "XF86AudioRaiseVolume" =
              "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +10% && killall -SIGUSR1 i3status";
            "XF86AudioLowerVolume" =
              "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -10% && killall -SIGUSR1 i3status";
            "XF86AudioMute" =
              "exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle && killall -SIGUSR1 i3status";
            "XF86AudioMicMute" =
              "exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle && killall -SIGUSR1 i3status";

            # Brightness controls
            "XF86MonBrightnessUp" = "exec brightnessctl set +5%";
            "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
          };

        # Resize mode
        modes = {
          resize = {
            "j" = "resize shrink width 10 px or 10 ppt";
            "k" = "resize grow height 10 px or 10 ppt";
            "l" = "resize shrink height 10 px or 10 ppt";
            "semicolon" = "resize grow width 10 px or 10 ppt";

            # Same bindings for arrow keys
            "Left" = "resize shrink width 10 px or 10 ppt";
            "Down" = "resize grow height 10 px or 10 ppt";
            "Up" = "resize shrink height 10 px or 10 ppt";
            "Right" = "resize grow width 10 px or 10 ppt";

            # Back to normal
            "Return" = "mode default";
            "Escape" = "mode default";
            "${config.xsession.windowManager.i3.config.modifier}+r" =
              "mode default";
          };
        };

        # Bar configuration
        bars = [{
          statusCommand = "i3status";
          position = "bottom";
        }];

        # Startup applications
        startup = [
          {
            command = "dex --autostart --environment i3";
            notification = false;
          }
          {
            command = "xss-lock --transfer-sleep-lock -- i3lock --nofork";
            notification = false;
          }
          {
            command = "nm-applet";
            notification = false;
          }
          # Add keyboard layout settings
          {
            command =
              "setxkbmap -layout pl,es -variant dvp,dvorak -option ctrl:swap_lwin_lctl,grp:alt_space_toggle";
            always = true;
            notification = false;
          }
        ];
      };
    };
  };

  # Ensure necessary packages are installed
  home.packages = with pkgs; [
    brightnessctl
    i3status
    i3lock
    dmenu
    dex
    xss-lock
    networkmanagerapplet
  ];
}
