job "prometheus" {
  datacenters = ["dc1"]

  type = "service"

  group "prometheus" {
    count = 1

    network {
      port "prometheus" {
        static = 9090
      }
    }

    task "prometheus" {
      driver = "docker"

      config {
        image = "prom/prometheus:latest"
        network_mode = "host"

	args = [
        "--config.file=/etc/prometheus/prometheus.yml",
	"--storage.tsdb.retention.time=3d",
	]

        ports = ["prometheus"]

        volumes = [
          "local/prometheus.yml:/etc/prometheus/prometheus.yml"
        ]
      }

      template {
        data = file("./prometheus.yml")
        destination = "local/prometheus.yml"
      }
    }

      }
    }

