resource "cloudflare_record" "elk" {
  zone_id = local.sikademo_com_zone_id

  name    = "elk-docker"
  value   = digitalocean_droplet.elk.ipv4_address
  type    = "A"
  proxied = false
}

resource "cloudflare_record" "es" {
  zone_id = local.sikademo_com_zone_id

  name    = "es.${cloudflare_record.elk.name}"
  value   = cloudflare_record.elk.hostname
  type    = "CNAME"
  proxied = false
}

resource "cloudflare_record" "kib" {
  zone_id = local.sikademo_com_zone_id

  name    = "kb.${cloudflare_record.elk.name}"
  value   = cloudflare_record.elk.hostname
  type    = "CNAME"
  proxied = false
}
