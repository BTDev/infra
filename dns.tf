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
  proxied = false

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
    voice     = "echo.literallyshit.net"
    wiki      = "btwiki.blackjack.literallyshit.net"
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
    target   = "echo.literallyshit.net"
  }
}

resource "cloudflare_record" "mx" {
  for_each = {
    "aspmx.l.google.com"      = 1
    "alt1.aspmx.l.google.com" = 5
    "alt2.aspmx.l.google.com" = 5
    "aspmx2.googlemail.com"   = 10
    "aspmx3.googlemail.com"   = 10
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
    "v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCsqPZQW0O8/7qkIV0T0ICYeLCAAz43YwdF6U0aTEwtKKh8Y2VFXp7jc+WbicmF7wZC/nnVdE8U/RBfIPZIwBuM+el7G96okldjvhZrBNPPYROVxse/br2fj2YZm1rIwzIBmfRYAHJH7l9chlUksHTiJUmIRMYDS/ToQiuzM56GuQIDAQAB",
    "v=spf1 include:_spf.google.com ~all"
  ])

  zone_id = cloudflare_zone.berrytube.id

  name    = "berrytube.tv"
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
