{
  users = [
    # cat ~/.ssh/id_ed25519.pub on IsblAsahi
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIZdRoS3HXiUh77MLq2OczaysE79CK0NZGfHyH+3tBlv"

    # cat ~/.ssh/id_ed25519.pub on IsblDesktop
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFrYVxQiKKIzGqLIO+6w6qA1d+E9vR2bFLW0EuT4e6zA"
  ];

  system = {
    # cat /persistent/etc/ssh/ssh_host_ed25519_key.pub on IsblDesktop
    desktop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH2f8ys3ho3xYCqDZY/thrF+6HSoNscmOYG4AfZMRs8p root@IsblDesktop";
    # cat /persistent/etc/ssh/ssh_host_ed25519_key.pub on IsblAsahi
    asahi = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOB4THzrUqU+715hzsH4N8cL6V1+B85+FF3djNJwTWTO";
  };
}
