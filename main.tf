resource "cloudflare_account" "berrytube" {
  name = "BerryTube"

  enforce_twofactor = true
}

resource "cloudflare_zone" "berrytube" {
  account_id = cloudflare_account.berrytube.id
  zone       = "berrytube.tv"
}

resource "cloudflare_zone_settings_override" "berrytube" {
  zone_id = cloudflare_zone.berrytube.id

  settings {
    security_level = "essentially_off"

    ssl             = "strict"
    min_tls_version = "1.2"

    # = respect existing headers
    browser_cache_ttl = 0
  }
}

resource "cloudflare_page_rule" "sha1" {
  zone_id = cloudflare_zone.berrytube.id

  target = "cdn.berrytube.tv/sha1/*"

  actions {
    cache_level = "cache_everything"

    disable_apps  = true
    disable_zaraz = true
  }
}
