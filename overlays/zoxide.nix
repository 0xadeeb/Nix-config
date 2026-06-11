final: prev: {
    zoxide = prev.zoxide.overrideAttrs (old: {
        patches = (old.patches or [ ]) ++ [
            (prev.fetchpatch {
                url = "https://github.com/0xadeeb/zoxide/compare/d7458b756ee218e6f597218a8d9065b2032601f1...f3934a2b1c8048f0997d8870e40b1f7eabe9d42c.diff";
                hash = "sha256-Hd+IOGLbKpG1QYBhS7eR2ZyazTAvewI7C8WIkezLKBo=";
            })
        ];
    });
}
