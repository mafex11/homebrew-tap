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

        ╭──────────────────────────────╮
        │   Y U K I                    │
        │   your mac, automated        │
        ╰──────────────────────────────╯

    Yuki installed! 🎐

    ⚠  First launch (not notarized yet — Gatekeeper blocks it once):
         → Right-click Yuki.app in /Applications → "Open" → confirm.
         (Or run: xattr -dr com.apple.quarantine /Applications/Yuki.app)

    Then Yuki guides you through Accessibility permission + picking an AI
    provider (Google Gemini free tier / Anthropic / Ollama).

    Yuki lives in your menu bar ("Y", no Dock icon).
    Press  Cmd+Shift+A  from anywhere to open the command bar.
  EOS

  uninstall quit: "com.yuki.app"

  zap trash: [
    "~/Library/Application Support/Yuki",
    "~/Library/Preferences/com.yuki.app.plist",
    "~/Library/LaunchAgents/com.yuki.feedback.learner.plist",
  ]
end
