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
mkdir /elk
cd /elk
wget https://raw.githubusercontent.com/ondrejsika/elk-training/master/elk/docker/elk-local/docker-compose.yml
docker-compose up -d
EOF
}
