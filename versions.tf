terraform {
  required_version = ">= 0.13"

  cloud {
    organization = "BerryTube"

    workspaces {
      name = "infra"
    }
  }

  required_providers {
    ns1 = {
      source = "ns1-terraform/ns1"
    }
  }
}
