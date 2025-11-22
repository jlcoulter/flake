{
  config,
  pkgs,
  ...
}: {
  virtualisation.virtualbox.host.enable = true;
  boot.kernelParams = ["kvm.enable_virt_at_load=0"];
  users.extraGroups.vboxusers.members = ["jc"];
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  environment.systemPackages = with pkgs; [
    docker-client
  ];
}
