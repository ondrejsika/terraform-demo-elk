resource "digitalocean_droplet" "elk" {
  image  = "docker-20-04"
  name   = "demo-elk-docker"
  region = "fra1"
  size   = "s-2vcpu-4gb"
  ssh_keys = [
    data.digitalocean_ssh_key.ondrejsika.id
  ]
  user_data = <<EOF
#!/bin/bash
apt-get update
apt-get install -y wget
mkdir /traefik
cd /traefik
wget https://raw.githubusercontent.com/ondrejsika/ondrejsika-docker-traefik/master/compose.https-le-web.yml -O compose.yml
docker compose up -d
mkdir /elk
cd /elk
wget https://raw.githubusercontent.com/ondrejsika/elk-training/master/elk/docker/elk-traefik/compose.yml
wget https://raw.githubusercontent.com/ondrejsika/elk-training/master/elk/docker/elk-traefik/compose.ports.yml
docker compose -f compose.yml -f compose.ports.yml up -d
EOF
}
