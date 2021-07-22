provider "aws" {
  profile = "default"
  region  = "${var.aws_region}"
  shared_credentials_file =  "${var.aws_shared_credentials_file}"  
}