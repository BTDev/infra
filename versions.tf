terraform {
  required_version = ">= 0.13"

  cloud {
    organization = "BerryTube"

    workspaces {
      name = "infra"
    }
  }

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.24"
    }
  }
}
