cask "kvirc" do
  version "5.2.0,Quasar"
  sha256 "945e51861f031c7adbdb5f3d7322f94b40850c33a7d050300dfb30d3d5e2bdd1"

  url "https://github.com/kvirc/KVIrc/releases/download/#{version.csv.first}/KVIrc-#{version.csv.first}-#{version.csv.second}.dmg",
      verified: "github.com/kvirc/KVIrc/"
  name "KVIrc"
  desc "IRC Client"
  homepage "https://www.kvirc.net/"

  livecheck do
    url :url
    regex(/^KVIrc[._-]v?(\d+(?:\.\d+)+)[._-](\w+)\.dmg/i)
    strategy :github_releases do |json, regex|
      json.map do |release|
        next if release["draft"] || release["prerelease"]

        release["assets"]&.map do |asset|
          match = asset["name"]&.match(regex)
          next if match.blank?

          "#{match[1]},#{match[2]}"
        end
      end.flatten
    end
  end

  depends_on macos: ">= :high_sierra"

  app "KVIrc.app"

  zap trash: [
    "~/.kvirc*.rc",
    "~/Library/Preferences/com.kvirc.kvirc.plist",
    "~/Library/Saved Application State/com.kvirc.kvirc.savedState",
  ]
end
