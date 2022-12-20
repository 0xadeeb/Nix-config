{ config, lib, pkgs, ... }:

{
  home.shellAliases = {
    ls = "exa";
    la = "exa -a";
    ll = "exa -l";
    lla = "exa -al";
    lt = "exa -aT --color=always --group-directories-first";
    grep = "grep --color=auto";
    df = "df -h";
    du = "du -h";
    cp = "cp -i";
    mv = "mv -i";
    rm = "echo \"Is this the command you are looking for?\"; false";
    tp = "trash-put";
    ln = "ln -i";
    eb = "earbuds";
    ps = "procs";
    cdr = "cd $(git rev-parse --show-toplevel)\"";
    emacs = "emacs -nw -Q";
  };
}
