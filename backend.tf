terraform {
  backend "s3" {
    bucket       = "project03-tfstate-359013545320"
    key          = "dev/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }
}
