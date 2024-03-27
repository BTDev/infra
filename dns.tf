resource "cloudflare_record" "ipv4" {
  zone_id = cloudflare_zone.berrytube.id

  name    = "ipv4"
  proxied = false


  type  = "A"
  value = var.ipv4
}
resource "cloudflare_record" "ipv6" {
  zone_id = cloudflare_zone.berrytube.id

  name    = "ipv6"
  proxied = false

  type  = "AAAA"
  value = var.ipv6
}

resource "cloudflare_record" "caa_issuewild" {
  zone_id = cloudflare_zone.berrytube.id

  name    = "berrytube.tv"
  proxied = false

  type = "CAA"
  data {
    flags = 0
    tag   = "issuewild"
    value = "letsencrypt.org"
  }
}
resource "cloudflare_record" "caa_issue" {
  zone_id = cloudflare_zone.berrytube.id

  name    = "berrytube.tv"
  proxied = false

  type = "CAA"
  data {
    flags = 0
    tag   = "issue"
    value = "letsencrypt.org"
  }
}
resource "cloudflare_record" "caa_iodef" {
  zone_id = cloudflare_zone.berrytube.id

  name    = "berrytube.tv"
  proxied = false

  type = "CAA"
  data {
    flags = 0
    tag   = "iodef"
    value = "mailto:btcaa@atte.fi"
  }
}

resource "cloudflare_record" "root" {
  zone_id = cloudflare_zone.berrytube.id

  name    = "berrytube.tv"
  proxied = false

  type  = "CNAME"
  value = "ipv4.berrytube.tv"
}

resource "cloudflare_record" "ipv4_aliases" {
  for_each = toset(["direct", "btc", "btc-socket", "cdn", "socket", "www"])

  zone_id = cloudflare_zone.berrytube.id

  name    = each.value
  proxied = contains([], each.value)

  type  = "CNAME"
  value = "berrytube.tv"
}


resource "cloudflare_record" "external" {
  for_each = {
    # Q0
    cah       = "btcah.blackjack.literallyshit.net"
    map       = "btmap.blackjack.literallyshit.net"
    mc        = "mc.digitalfall.net"
    minecraft = "mc.digitalfall.net"
    quotes    = "btquotes.blackjack.literallyshit.net"
    vault     = "btvault.blackjack.literallyshit.net"
    voice     = "q-z.xyz"
    wiki      = "btwiki.blackjack.literallyshit.net"
    # Q0 (email)
    mail         = "box.digitalfall.net"
    autoconfig   = "box.digitalfall.net"
    autodiscover = "box.digitalfall.net"
    # Mal
    keyblade = "berrytube.tv"
    radio    = "q-z.xyz"
    # Toast
    toast = "www.toastserv.com"
  }

  zone_id = cloudflare_zone.berrytube.id

  name    = each.key
  proxied = false

  type  = "CNAME"
  value = each.value
}

resource "cloudflare_record" "teamspeak" {
  zone_id = cloudflare_zone.berrytube.id

  name    = "_ts3._udp"
  proxied = false

  type = "SRV"
  data {
    service  = "_ts3"
    proto    = "_udp"
    name     = "berrytube.tv"
    priority = 0
    weight   = 5
    port     = 9987
    target   = "q-z.xyz"
  }
}

resource "cloudflare_record" "mx" {
  for_each = {
    "box.digitalfall.net" = 10
  }

  zone_id = cloudflare_zone.berrytube.id

  name    = "berrytube.tv"
  proxied = false

  type     = "MX"
  priority = each.value
  value    = each.key
}

resource "cloudflare_record" "txt" {
  for_each = toset([
    "Go fuck yourself!",
    "google-site-verification=C4vWwhSPhiZKOBvA7hx4OJLDXbM3YupLNxwYsmoK3LI",
    "v=spf1 mx -all"
    
  ])

  zone_id = cloudflare_zone.berrytube.id

  name    = "berrytube.tv"
  proxied = false

  type  = "TXT"
  value = each.value
}

resource "cloudflare_record" "txt_subdomain" {
  for_each = {
    "_dmarc" = "v=DMARC1; p=quarantine;"
    "mail._domainkey" = "v=DKIM1; h=sha256; k=rsa; s=email; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA0fJVXFiz0LSlvRhfLMTA4M7ut0deBG6HAw8aB4rh2PkYDEBO0ILeIpR5ByQ5AsQHtQwHOIIFlKoMgVfw5h1mvRkbmQQpsoTgdRUGblqjq/Fgw8LvdpIFBUQb7NqB7co9Ot1NN8IqcJeHviiENdgJY5zU1EXA7iZVOfFulCQPTpI/XCJ1AbzCl1xw+pAqjPiBsq5Mkx+XKcidVuhhzdcKQxAi7p18IJG5p7W7BUR2nZhS9Ro3pqjLVHdA9l5TJSFHyTDzzfuOLVg2iKA78P8q0SNFr7VII0OVzp+WqnG3fy5YQKb2T+1rerCkTuJycOgXoXqDTimJxlsFVi9Y7uec9wIDAQAB"
  }

  zone_id = cloudflare_zone.berrytube.id

  name    = "${each.key}.berrytube.tv"
  proxied = false

  type  = "TXT"
  value = each.value
}

resource "cloudflare_record" "github_challenge" {
  zone_id = cloudflare_zone.berrytube.id

  name    = "_github-challenge-btdev"
  proxied = false

  type  = "TXT"
  value = "f84a8b5a4e"
}
