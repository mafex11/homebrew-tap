cask "claude-swap-bar" do
  version "1.0.0"
  sha256 "d40ab4a5704ac24b7e3f4b2762dbedeebe6cd89e59417a488e7f88392bc3e7e8"

  url "https://github.com/mafex11/claude-swap-bar/releases/download/v#{version}/ClaudeSwap.zip"
  name "Claude Swap"
  desc "Menu bar view of claude-swap accounts: usage, renewals and logins"
  homepage "https://github.com/mafex11/claude-swap-bar"

  depends_on macos: :ventura

  app "Claude Swap.app"

  # Claude Swap is ad-hoc signed (not notarized). Strip the quarantine flag so it
  # opens without the Gatekeeper prompt. Homebrew runs these steps in a sandbox
  # that cannot launch apps, so starting it is left to the user (see caveats).
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Claude Swap.app"]
  end

  uninstall quit: "dev.mafex.claudeswap"

  zap trash: "~/Library/Preferences/dev.mafex.claudeswap.plist"

  caveats <<~EOS
    Start Claude Swap once (after that it opens at login):

      open -a "Claude Swap"

    It shows the account in use and its session usage in the menu bar. Click
    it for every account: usage, renewal time, and which ones are logged out.

    It reads ~/.claude-swap/status.json, which your claude-swap script writes.
    See #{homepage} for the file format and the settings.
  EOS
end
