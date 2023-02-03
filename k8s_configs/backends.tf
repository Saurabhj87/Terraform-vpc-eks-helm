terraform {
  backend "s3" {
    bucket = "dev-backend-my-vpc"
    key    = "k8s-tfstate/tf.tfstate"
    region = "ap-south-1"
  }
}

##Remote backend to read k8s

data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    bucket = "dev-backend-my-vpc"
    key    = "tfstate/tf.tfstate"
    region = "ap-south-1"
  }
}