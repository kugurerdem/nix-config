{ pkgs, ... }:

{
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    extensions = [
      { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # Vimium
      { id = "kbfnbcaeplbcioakkpcpgfkobkghlhen"; } # Grammarly
      { id = "clngdbkpkpeebahjckkjfobafhncgmne"; } # Stylus
      { id = "pobhoodpcipjmedfenaigbeloiidbflp"; } # Minimal Theme for Twitter
      { id = "khncfooichmfjbepaaaebmommgaepoid"; } # YouTube Unhooked
      { id = "lggmmceliiaoddfnbaccgpfnpoifilic"; } # Bell of Mindfulness
      { id = "khgegkjchclhgpglloficdmdannlpmoi"; } # What Hackernews Says?
      { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # Dark Reader
    ];
  };

}
