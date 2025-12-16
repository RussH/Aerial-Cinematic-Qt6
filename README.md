# Aerial Cinematic SDDM (Qt6/Plasma 6 Port)

A minimalist, cinematic SDDM login theme designed specifically for KDE Neon Testing / Plasma 6. This theme features a high-definition video background that seamlessly transitions into a "Cinematic Mode"—fading out UI elements during inactivity to let the background video shine.

## 🎥 Preview
[Click to view the preview video](https://github.com/RussH/Aerial-Cinematic-Qt6/raw/main/screens/sddm_preview.mp4)

> **The Cinematic Effect:** After 10 seconds of inactivity, the clock, login fields, and session picker will automatically fade out, and the background dimming will lift to reveal the crystal-clear video. Simply move your mouse or start typing to bring the interface back.

---

##  Features
* **Qt6 & Plasma 6 Native**: Fully refactored to remove legacy Qt5 dependencies and versioned imports.


---

## 🛠 Installation

### 1. Clone the repository
```bash
git clone [https://github.com/RussH/Aerial-Cinematic-Qt6.git](https://github.com/RussH/Aerial-Cinematic-Qt6.git)
cd Aerial-Cinematic-Qt6
2. Move to SDDM themes directory
You must install the theme folder into your system's SDDM directory:
Bash
sudo cp -r ../Aerial-Cinematic-Qt6 /usr/share/sddm/themes/aerial-cinematic-qt6
3. Apply the theme
Open System Settings.
Navigate to Colors & Themes > Login Screen (SDDM).
Select Aerial Cinematic Qt6 and click Apply. 

#### Configuration
You can customize the theme by editing the theme.conf file located in the theme directory: amend backgroundVideo to your .mp4 
Default is video file snowfall-in-forest.mp4
fadeDurationTime in ms before the UI fades out 10000
accentColorBorder color for active field sessions#00d2ff
showSessionSelect - Toggle the Wayland/X11 picker true
