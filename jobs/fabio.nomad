job "fabio-job" {
  region = "US"
  datacenters = ["CA3"]
  type = "system"
  update {
    stagger = "5s"
    max_parallel = 1
  }

  group "fabio-group" {
     ephemeral_disk {
      size    = "500"
    }
    task "fabio-task" {
      driver = "exec"
      config {
        command = "fabio-1.5.0-go1.8.3-linux_amd64"
      }

      artifact {
        source = "https://github.com/fabiolb/fabio/releases/download/v1.5.0/fabio-1.5.0-go1.8.3-linux_amd64"
     }
     logs {
	max_files = 2
	max_file_size = 5
      }
      resources {
        cpu = 500
        memory = 64
        network {
          mbits = 1

          port "http" {
            static = 9999
          }
          port "ui" {
            static = 9998
          }
        }
      }
    }
  }
}

