terraform {
    backend "s3" {
        bucket = "tf-state-rapha"
        key = "terraform.tfstate"
        dynamodb_table = "tf-state-lock-rapha"
        region = "eu-west-1"
    }
}