cask "lid-awake" do
  version "1.0.0"
  sha256 "6e7456b8f0841615561bb14200f19464f145072e65fdb99cea17e28fd86ae6a8"

  url "https://github.com/mafex11/lid-awake/releases/download/v#{version}/LidAwake.zip"
  name "Lid Awake"
  desc "Menu bar switch that keeps a MacBook running with the lid closed"
  homepage "https://github.com/mafex11/lid-awake"

  depends_on macos: ">= :ventura"

  app "Lid Awake.app"
  binary "#{appdir}/Lid Awake.app/Contents/MacOS/LidAwake", target: "lid-awake"

  # Lid Awake is ad-hoc signed (not notarized). Strip the quarantine flag so it
  # opens without the Gatekeeper prompt. On an upgrade the old copy is still
  # running, so stop it first (it puts sleep back to normal as it exits), then
  # start the new one in the menu bar.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Lid Awake.app"],
                   sudo: false
    system_command "/usr/bin/pkill", args: ["-x", "LidAwake"], must_succeed: false, sudo: false
    system_command "/bin/sleep", args: ["1"], sudo: false
    system_command "/usr/bin/open", args: ["#{appdir}/Lid Awake.app"], sudo: false
  end

  # Quitting puts sleep back to normal. The script is a second line of defence
  # for the case where the app was not running: never leave sleep disabled
  # behind an uninstall.
  uninstall quit:   "dev.mafex.lidawake",
            script: {
              executable:   "#{appdir}/Lid Awake.app/Contents/MacOS/LidAwake",
              args:         ["release"],
              must_succeed: false,
            }

  # The sudoers rule stays through upgrades (so setup is asked once) and is
  # removed here.
  zap trash:  "~/Library/Preferences/dev.mafex.lidawake.plist",
      delete: "/etc/sudoers.d/lid-awake"

  caveats <<~EOS
    Lid Awake is in your menu bar (a moon).

      Click it        keep the Mac running when the lid closes (a cup)
      Click again     back to normal sleep
      Right-click     options

    The first time you turn it on it asks for your password once, to install
    a rule that lets it change one power setting.

    When it is On, the Mac does NOT sleep in a bag. Turn it Off before you pack.

    To remove everything, including that rule:
      brew uninstall --zap --cask lid-awake
  EOS
end
