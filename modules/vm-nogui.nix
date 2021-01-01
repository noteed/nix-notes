# This is the vm-nogui.nix file from nixos-generators.
# It might be a good idea to merge its vm.nix file here too.

{ pkgs, ... }:
let
  # https://unix.stackexchange.com/questions/16578/resizable-serial-console-window
  resize = pkgs.writeScriptBin "resize" ''
    old=$(stty -g)
    stty raw -echo min 0 time 5
    printf '\033[18t' > /dev/tty
    IFS=';t' read -r _ rows cols _ < /dev/tty
    stty "$old"
    stty cols "$cols" rows "$rows"
  '';
in {
  virtualisation.graphics = false;
  virtualisation.qemu.options = [ "-serial mon:stdio" ];

  environment.systemPackages = [ resize ];
  environment.loginShellInit = "${resize}/bin/resize";
}
