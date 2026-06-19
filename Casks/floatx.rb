cask "floatx" do
  version "0.1.0"
  sha256 "0d231ca2b0efd9b6be162a999c88ebc1240fa592fd243e98d37175e1526d1aa1"

  url "https://github.com/mafex11/FloatX/releases/download/v#{version}/FloatX.zip"
  name "FloatX"
  desc "Ambient floating shower of your X timeline, one post at a time"
  homepage "https://github.com/mafex11/FloatX"

  depends_on macos: :tahoe

  app "FloatX.app"

  # FloatX is ad-hoc signed (not notarized). Strip the quarantine flag so it
  # opens on a normal double-click, then launch it into the menu bar.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/FloatX.app"],
                   sudo: false
    system_command "/usr/bin/open", args: ["#{appdir}/FloatX.app"], sudo: false
  end

  uninstall quit: "dev.mafex.floatx"

  zap trash: "~/Library/Preferences/dev.mafex.floatx.plist"

  caveats <<~EOS
    FloatX is now in your menu bar (the X glyph).

    First launch: sign in to X in the window that appears — that's your own
    session, read locally, never sent anywhere. Then click the menu-bar icon to
    float your timeline. Hover for prev/pause/next; right-click the icon for
    size, transparency, and desktop mode.

    FloatX is ad-hoc signed; if macOS blocks it, right-click the app → Open.
  EOS
end
