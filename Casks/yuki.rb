cask "yuki" do
  version "0.1.0"
  sha256 "PLACEHOLDER_SHA256_FILLED_AT_RELEASE"

  url "https://github.com/mafex11/yuki-mac-use/releases/download/v#{version}/Yuki-#{version}.zip"
  name "Yuki"
  desc "Jarvis-style macOS assistant — Raycast-style command bar with a local agent"
  homepage "https://github.com/mafex11/yuki-mac-use"

  depends_on macos: ">= :ventura"
  depends_on arch: :arm64

  app "Yuki.app"

  caveats <<~EOS
    Yuki is not yet notarized. On first launch macOS Gatekeeper will block it:
      → Right-click Yuki.app in /Applications and choose "Open", then confirm.
      (Or: System Settings → Privacy & Security → "Open Anyway".)

    Yuki needs Accessibility permission to drive your apps. On first launch it
    will guide you to System Settings → Privacy & Security → Accessibility.

    Press Cmd+Shift+A from anywhere to open the command bar.
  EOS

  uninstall quit: "com.yuki.app"

  zap trash: [
    "~/Library/Application Support/Yuki",
    "~/Library/Preferences/com.yuki.app.plist",
    "~/Library/LaunchAgents/com.yuki.feedback.learner.plist",
  ]
end
