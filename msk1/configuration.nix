# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only
  boot.kernel.sysctl = {
    "net.ipv4.conf.all.forwarding" = true;
  };
  networking.hostName = "bedrift13-maskin1"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "Europe/Oslo";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.eno1.useDHCP = false;
  networking.defaultGateway = "10.200.13.1";
  networking.nameservers = [ "10.250.0.5" ];
  networking.nat.enable = true;
  networking.nat.forwardPorts = [
  {
    destination = "10.0.0.2:22";
    proto = "tcp";
    sourcePort = 20022;
  }
  {
    destination = "10.0.0.3:22";
    proto = "tcp";
    sourcePort = 30022;
  }
  {
    destination = "10.0.0.4:22";
    proto = "tcp";
    sourcePort = 40022;
  }
  {
    destination = "10.0.0.254:22";
    proto = "tcp";
    sourcePort = 50022;
  }];
  networking.nat.externalInterface = "vlan2";
  networking.nat.internalInterfaces = [ "vlan130" ];
  networking.vlans = {
    vlan2 = { id=2; interface="eno1"; };
    vlan130 = { id=130; interface="eno1"; };
  };
  networking.interfaces.vlan2.ipv4.addresses = [{
    address = "10.200.13.2";
    prefixLength = 28;
  }];
  networking.interfaces.vlan130.ipv4.addresses = [{
    address = "10.0.0.1";
    prefixLength = 24;
  }];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "no";
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;


  

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mw = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };
  users.users.jp = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
  users.users.eba = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
  users.users.th = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    curl
    elinks
    git
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?

}

