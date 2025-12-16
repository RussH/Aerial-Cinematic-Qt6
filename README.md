# Aerial Cinematic SDDM (Qt6/Plasma 6 Fix)

A modern, high-performance fork of the Aerial SDDM theme, fully rewritten for **Qt6** and **Plasma 6**. This version removes legacy Qt5 dependencies and introduces a cinematic "screensaver" mode.

##  Key Fixes & Features
- **Qt6 Multimedia Migration**: Completely replaced outdated `VideoPlayer` logic with the new `QtMultimedia` standard.
- **Cinematic Inactivity Timer**: After 10 seconds of inactivity (configurable), the login UI fades out and the background dimming is removed, revealing a crisp, unobstructed video.
- **Hardware Compatibility**: Includes built-in virtual keyboard suppression specifically designed for laptops with touchscreens (like the ThinkPad T480s).
- **Performance Optimized**: Uses simple opacity transitions rather than heavy blur shaders, ensuring smooth performance even on integrated graphics.
- **Single File Video**: Simplified `theme.conf` to support a direct path to a single `.mp4` file instead of complex playlist files.

##  Installation
1. Clone this repository to your SDDM themes directory:
   ```bash
   git clone [https://github.com/russh/aerial-sddm-qt6.git](https://github.com/russh/aerial-sddm-qt6.git)
   sudo cp -r aerial-sddm-qt6 /usr/share/sddm/themes/aerial-cinematic

Updated README.md for your ForkMarkdown# Aerial Cinematic SDDM (Qt6 Port)

A high-performance, cinematic SDDM theme for **Plasma 6**, rewritten to support the modern **Qt6 Multimedia** stack. This is a modernized fork of the original Aerial theme by 3ximus, optimized for local high-definition video backgrounds and minimalist aesthetics.

##  Compatibility Warning
**Tested On:** KDE Neon (Testing Edition) / Plasma 6. 
This theme is written specifically for **Qt6**. It is NOT compatible with Plasma 5 or older distributions using Qt5.

##  Key Enhancements
- **Qt6 Native**: Completely removed legacy `qt5-graphicaleffects` and `phonon` dependencies.
- **Cinematic Fade**: After 10 seconds of inactivity, the login UI and background dimming fade out completely, leaving a crystal-clear video view.
- **ThinkPad Optimized**: Built-in suppression for virtual keyboards on touch-enabled laptops (like the T480s/T490).
- **Single File Video**: Point the theme to a single `.mp4` file via `theme.conf`. No complex playlists required.

##  Dependencies
To play video in SDDM on Plasma 6, you must have the Qt6 Multimedia plugins and GStreamer backends installed.

### For KDE Neon / Kubuntu 24.04+ / Debian Trixie:
```bash
sudo apt install qml6-module-qtmultimedia qml6-module-qtquick-controls gstreamer1.0-libav gstreamer1.0-plugins-good
For Arch Linux:Bashpacman -S qt6-multimedia gst-libav gst-plugins-good qt6-5compat
For Fedora 40+:Bashsudo dnf install qt6-qtmultimedia gstreamer1-libav gstreamer1-plugins-good
 InstallationClone the repository:Bashgit clone [https://github.com/YOUR_USERNAME/aerial-sddm-qt6.git](https://github.com/YOUR_USERNAME/aerial-sddm-qt6.git)
Move the folder to the SDDM themes directory:Bashsudo cp -r aerial-sddm-qt6 /usr/share/sddm/themes/aerial-cinematic
Test the theme before applying:Bashsddm-greeter-qt6 --test-mode --theme /usr/share/sddm/themes/aerial-cinematic
🛠 Configuration (theme.conf)Unlike the original version, this theme uses a simplified theme.conf. Adjust these values to your liking:KeyDescriptionDefaultbackgroundVideoFull path to your .mp4 video/path/to/video.mp4fadeDurationTime in ms before UI fades out10000displayFontFont family for UIDroid Sans Mono for PowerlineclockFontSizeSize of the central clock84accentColorColor of the focus border#00d2ff
