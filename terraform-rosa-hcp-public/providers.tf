provider "aws" {
  region = var.region
}

provider "rhcs" {
  token = var.token
}