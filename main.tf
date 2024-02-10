resource "cloudflare_account" "berrytube" {
  name = "BerryTube"

  enforce_twofactor = true
}

resource "cloudflare_zone" "berrytube" {
  account_id = cloudflare_account.berrytube.id
  zone       = "berrytube.tv"
}
