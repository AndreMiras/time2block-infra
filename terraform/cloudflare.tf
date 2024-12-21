provider "cloudflare" {
  api_token = data.google_secret_manager_secret_version.cloudflare_api_token.secret_data
}

resource "cloudflare_record" "api_domain" {
  name    = var.api_domain_prefix
  zone_id = var.cloudflare_zone_id
  content = "ghs.googlehosted.com"
  type    = "CNAME"
  # Cloud Run custom domain mapping doesn't play well in proxy mode
  proxied = false
}

resource "cloudflare_record" "root_domain" {
  name    = "@"
  zone_id = var.cloudflare_zone_id
  content = local.www_domain_name
  type    = "CNAME"
  proxied = true
}

resource "cloudflare_page_rule" "root_to_www_redirect" {
  zone_id = var.cloudflare_zone_id
  target  = "${var.domain_suffix}/*"
  actions {
    forwarding_url {
      url         = "http://${local.www_domain_name}/$1"
      status_code = 301
    }
  }
  priority = 1
}

# disable security and browser integrity checks for the ACME challenge as GCP needs it for custom domain mapping
resource "cloudflare_page_rule" "acme_challenge_bypass" {
  zone_id  = var.cloudflare_zone_id
  target   = "*.${var.domain_suffix}/.well-known/acme-challenge/*"
  priority = 2
  actions {
    browser_check  = "off"
    cache_level    = "bypass"
    ssl            = "full"
    security_level = "essentially_off"
  }
}
