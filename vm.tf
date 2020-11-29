resource "digitalocean_droplet" "elk" {
  image  = "docker-18-04"
  name   = "demo-elk"
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
wget https://raw.githubusercontent.com/ondrejsika/traefik-le/master/docker-compose.yml
docker-compose up -d
mkdir /elk
cd /elk
wget https://raw.githubusercontent.com/ondrejsika/elk-training/master/elk/docker/elk-traefik/docker-compose.yml
wget https://raw.githubusercontent.com/ondrejsika/elk-training/master/elk/docker/elk-traefik/docker-compose.ports.yml
docker-compose -f docker-compose.yml -f docker-compose.ports.yml up -d
EOF
}
