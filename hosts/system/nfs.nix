{
  boot.supportedFilesystems = [ "nfs" ];
  services.rpcbind.enable = true; # needed for NFS

  systemd.mounts =
    let
      commonMountOptions = {
        type = "nfs";
        mountConfig = {
          Options = "noatime";
        };
      };

      server = "192.168.0.160";
      jellyfin = "/volume1/jellyfin";
      nas = "/volume1/nas";

    in

    [
      (
        commonMountOptions
        // {
          what = "${server}:${jellyfin}";
          where = "/home/jc/jellyfin";
        }
      )

      (
        commonMountOptions
        // {
          what = "${server}:${nas}";
          where = "/home/jc/nas";
        }
      )
    ];

  systemd.automounts =
    let
      commonAutoMountOptions = {
        wantedBy = [ "multi-user.target" ];
        automountConfig = {
          TimeoutIdleSec = "600";
        };
      };

    in

    [
      (commonAutoMountOptions // { where = "/home/jc/jellyfin"; })
      (commonAutoMountOptions // { where = "/home/jc/nas"; })
    ];

  systemd.timers."rsync-nas" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "5m";
      OnUnitActiveSec = "30m";
      Unit = "rsync-nas.service";
    };
  };

  systemd.services."rsync-nas" = {
    script = ''
      sudo rsync -a /home/jc/jellyfin /home/jc/nasBK
      sudo rsync -a /home/jc/nas /home/jc/nasBK
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
  };

}
