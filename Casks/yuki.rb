cask "yuki" do
  version "0.1.0"
  sha256 "3868a48f84a4f1e4baf57cb62d0661c753180f64c574da781cd3d2ff4e4a911b"

  url "https://github.com/mafex11/yuki-mac-use/releases/download/v#{version}/Yuki-#{version}.zip"
  name "Yuki"
  desc "Jarvis-style macOS assistant — Raycast-style command bar with a local agent"
  homepage "https://github.com/mafex11/yuki-mac-use"

  depends_on macos: ">= :ventura"
  depends_on arch: :arm64

  app "Yuki.app"

  caveats <<~EOS

        ⠀⠀⠀⠀⠀⢀⣀⣀⣀⣀⣀⡀⠀⠀⠀⠀⠀
        ⠀⠀⢀⣤⣶⣿⣿⣿⣿⣿⣿⣿⣶⣤⡀⠀⠀
        ⠀⢠⣾⣿⣿⡿⠛⠉⠉⠛⢿⣿⣿⣷⡄⠀
        ⢀⣿⣿⡿⠋⠀⢀⣀⣀⡀⠀⠙⢿⣿⣿⡀
        ⢸⣿⣿⠁⠀⣰⣿⣿⣿⣿⣆⠀⠈⣿⣿⡇      Y U K I
        ⢸⣿⣿⠀⠀⣿⣿⣿⣿⣿⣿⠀⠀⣿⣿⡇   your mac, automated
        ⠘⣿⣿⣆⠀⠘⢿⣿⣿⡿⠃⠀⣰⣿⣿⠃
        ⠀⠹⣿⣿⣷⣤⣀⣉⣁⣀⣤⣾⣿⣿⠏⠀
        ⠀⠀⠙⠿⣿⣿⣿⣿⣿⣿⣿⠿⠋⠀⠀
        ⠀⠀⠀⠀⠀⠉⠛⠛⠉⠀⠀⠀⠀⠀⠀

    Yuki installed successfully! 🎐

    ⚠  First launch (Yuki isn't notarized yet, so Gatekeeper blocks it once):
         → Right-click Yuki.app in /Applications → "Open" → confirm.
         (Or run: xattr -dr com.apple.quarantine /Applications/Yuki.app)

    Then Yuki guides you through:
      1. Accessibility permission (so it can drive your apps)
      2. Picking an AI provider (Google Gemini free tier / Anthropic / Ollama)

    Yuki lives in your menu bar (look for "Y", no Dock icon).
    Press  ⌘⇧A  from anywhere to open the command bar.

    Ask it anything, or tell it to do things:
      "what's on my calendar today"
      "open whatsapp and message mom I'll be late"
  EOS

  uninstall quit: "com.yuki.app"

  zap trash: [
    "~/Library/Application Support/Yuki",
    "~/Library/Preferences/com.yuki.app.plist",
    "~/Library/LaunchAgents/com.yuki.feedback.learner.plist",
  ]
end
