job "fabio-example" {
  region = "US"
  datacenters = ["CA3"]
  type = "system"
  update {
    stagger = "5s"
    max_parallel = 1
  }

  group "fabio-example" {
     ephemeral_disk {
      size    = "500"
    }
    task "fabio-task" {
      driver = "exec"
      config {
        command = "fabio-example"
        args    = ["-prefix /app"]
      }

      artifact {
        source = "http://10.102.39.16:8000/fabio-example.tar.gz"
#file:///app/projects/cgm-cluster/jobs/fabio-example"
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
            static = 8000
          }
          port "ui" {
            static = 8023
          }
        }
      }
    }
  }
}

