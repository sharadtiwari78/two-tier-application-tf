terraform {
  backend "s3" {
    bucket = "two-tier-application-tfstate-sharad-7860"
    key    = "state/10weeksofcloudops-myapp.tfstate"
    region = "us-east-1"
    dynamodb_table = "state-lock"
  }
}