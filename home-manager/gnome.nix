{lib, ...}: {
  dconf.settings = {
    "org/gnome/desktop/input-sources" = {
      xkb-options = [ "caps:swapescape" ];
      sources = [(lib.hm.gvariant.mkTuple ["xkb" "tr+alt"])];
    };
    "org/gnome/desktop/peripherals/mouse" = { natural-scroll = false; };
    "org/gnome/desktop/peripherals/touchpad" = { natural-scroll = true; };
  };
}
