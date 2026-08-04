{
  flake.modules.nixos.power = { ... }:
{
  powerManagement.enable = true;
  services.power-profiles-daemon.enable = false;
  services.auto-cpufreq.enable = true;
  services.upower = {
    enable = true;
    usePercentageForPolicy = true;
    percentageLow = 20;
    percentageCritical = 10;
    percentageAction = 10;
    criticalPowerAction = "HybridSleep";
  };
};
}
