{ config, pkgs, ...} :

{
    programs.newsboat = {
        enable = true;
        autoReload = true;
        maxItems = 50;
        browser = ''${pkgs.brave}/bin/brave'';
        extraConfig = ''
            # unbind keys
            unbind-key ENTER
            unbind-key j
            unbind-key k
            unbind-key J
            unbind-key K

            # bind keys - vim style
            bind-key j down
            bind-key k up
            bind-key l open
            bind-key h quit

            # solarized
            color background         default   default
            color listnormal         default   default
            color listnormal_unread  default   default
            color listfocus          black     cyan
            color listfocus_unread   black     cyan
            color info               default   black
            color article            default   default

            # highlights
            highlight article "^(Title):.*$" blue default
            highlight article "https?://[^ ]+" red default
            highlight article "\\[image\\ [0-9]+\\]" green default
        '';


        urls = [
            { url = "https://mihaiolteanu.me/rss.xml"; }
            { url = "https://www.arp242.net/feed.xml"; }
            { url = "https://andrew-quinn.me/index.xml"; }
            { url = "https://antonz.org/all/index.xml"; }
            { url = "https://www.rugu.dev/en/blog/index.xml"; }
            { url = "https://feeds.transistor.fm/thoughts-on-functional-programming-podcast-by-eric-normand"; }
            { url = "https://breckyunits.com/feed.xml"; }
        ];
    };
}

