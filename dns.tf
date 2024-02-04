resource "ns1_zone" "berrytube" {
  zone = "berrytube.tv"
  ttl  = 600 # 10 minutes
}

resource "ns1_record" "txt" {
  zone = ns1_zone.berrytube.zone

  domain = ns1_zone.berrytube.zone
  type   = "TXT"
  answers {
    answer = "Go fuck yourself!"
  }
  answers {
    answer = "google-site-verification=C4vWwhSPhiZKOBvA7hx4OJLDXbM3YupLNxwYsmoK3LI"
  }
  answers {
    answer = "v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCsqPZQW0O8/7qkIV0T0ICYeLCAAz43YwdF6U0aTEwtKKh8Y2VFXp7jc+WbicmF7wZC/nnVdE8U/RBfIPZIwBuM+el7G96okldjvhZrBNPPYROVxse/br2fj2YZm1rIwzIBmfRYAHJH7l9chlUksHTiJUmIRMYDS/ToQiuzM56GuQIDAQAB"
  }
  answers {
    answer = "v=spf1 include:_spf.google.com ~all"
  }
}

resource "ns1_record" "github_challenge" {
  zone = ns1_zone.berrytube.zone

  domain = "_github-challenge-btdev.${ns1_zone.berrytube.zone}"
  type   = "TXT"
  answers {
    answer = "f84a8b5a4e"
  }
}

resource "ns1_record" "caa" {
  zone = ns1_zone.berrytube.zone

  domain = ns1_zone.berrytube.zone
  type   = "CAA"
  answers {
    answer = "0 iodef mailto:btcaa@atte.fi"
  }
  answers {
    answer = "0 issue letsencrypt.org"
  }
  answers {
    answer = "0 issuewild letsencrypt.org"
  }
}

resource "ns1_record" "mx" {
  zone = ns1_zone.berrytube.zone

  domain = ns1_zone.berrytube.zone
  type   = "MX"
  answers {
    answer = "1 aspmx.l.google.com."
  }
  answers {
    answer = "5 alt1.aspmx.l.google.com."
  }
  answers {
    answer = "5 alt2.aspmx.l.google.com."
  }
  answers {
    answer = "10 aspmx2.googlemail.com."
  }
  answers {
    answer = "10 aspmx3.googlemail.com."
  }
}

resource "ns1_record" "ipv4" {
  zone = ns1_zone.berrytube.zone

  domain = ns1_zone.berrytube.zone
  type   = "A"
  answers {
    answer = var.ipv4
  }
}

resource "ns1_record" "ipv6" {
  zone = ns1_zone.berrytube.zone

  domain = "ipv6.${ns1_zone.berrytube.zone}"
  type   = "AAAA"
  answers {
    answer = var.ipv6
  }
}

resource "ns1_record" "ipv4_aliases" {
  for_each = toset(["direct", "btc", "btc-socket", "cdn", "socket", "www"])

  zone = ns1_zone.berrytube.zone

  domain = "${each.value}.${ns1_zone.berrytube.zone}"
  type   = "CNAME"
  answers {
    answer = "${ns1_record.ipv4.domain}."
  }
}

resource "ns1_record" "external" {
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

  zone = ns1_zone.berrytube.zone

  domain = "${each.key}.${ns1_zone.berrytube.zone}"
  type   = "CNAME"
  answers {
    answer = "${each.value}."
  }
}

resource "ns1_record" "ts" {
  zone = ns1_zone.berrytube.zone

  domain = "_ts3._udp.${ns1_zone.berrytube.zone}"
  type   = "SRV"
  answers {
    answer = "0 5 9987 echo.literallyshit.net."
  }
}
