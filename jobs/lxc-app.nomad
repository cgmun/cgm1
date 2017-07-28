job "lxc-app-job" {
  region = "US"
  datacenters = ["CA3"]
  type = "system"
  update {
    stagger = "5s"
    max_parallel = 1
  }

  group "lxc-group" {
     ephemeral_disk {
      size    = "500"
    }
    task "busybox" {
      driver = "lxc"
      config {
        log_level = "trace"
        verbosity = "verbose"
        template = "/usr/share/lxc/templates/lxc-busybox"
      }
    }
  }
}


