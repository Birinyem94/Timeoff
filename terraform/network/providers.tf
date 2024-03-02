terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.36.0"
    }
  }
}

provider "aws" {
  region                  = "us-east-1"  # Set your desired region
  access_key              = "AKIA6GBMFGXCER3HIUK7"  # Set your AWS access key
  secret_key              = "3TwAAH7PNzKA0//te269EkEWBW1TJKoH8KCff+y0"  # Set your AWS secret key
  profile                 = "default"  # Optional AWS profile to use from the shared credentials file
}
