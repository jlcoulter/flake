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

      server = "10.1.1.150";
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

  services.rsync.jobs.backupNAS.destination = "/home/jc/nasBK";
  services.rsync.jobs.backupNAS.sources = [
    "/home/jc/jellyfin"
    "/home/jc/nas"
  ];
  services.rsync.jobs.backupNAS.timerConfig.OnCalendar = "hourly";
}
