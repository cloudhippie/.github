terraform {
  backend "s3" {
    bucket                      = "cloudhippie-terraform"
    key                         = "github/github"
    region                      = "auto"
    endpoint                    = "https://3c268ef9f938c1bea56d66644437edcc.r2.cloudflarestorage.com"
    force_path_style            = true
    skip_credentials_validation = true
    skip_region_validation      = true
    skip_metadata_api_check     = true
  }

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.39.0"
    }
  }

  required_version = ">= 1.0"
}

provider "github" {
  owner = "cloudhippie"
}
