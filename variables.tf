
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}

variable "aws_shared_credentials_file" {
  description = "aws_shared_credentials_file"
  type        = string
}

/*
variable "public_key" {
  description = "ssh pub-key"
  default = "AAAAB3NzaC1yc2EAAAADAQABAAABAQC3Iphw/kkhN1PdsMS5m/TALnwYwgH58Ir2lGCpyiLPhO9Z58mwKakiBjb7fmKZk+AZtjkZ2vKYWyZAFeRIdmXnT1oSjJ8x3jw95dhN5VwJr6c4QgqhQqQUVL3Kv1+oM5CAYjI0mt+219vsR8+dN1lmr6m6YzaiFxTIpHoxFNJ1N/A0dTJPz+upL6/4MbPUSyD1+05ZcO4tR11snLUJI+jqMo0diXfqMRHAhcV/mNqaWoTcmOyDCvDrI7ij/5vOo8mc6BwqF8Ee+2KrD8+TpKEnbbMGnKw2seRjaCd4Qg/2DQhVH9T0KM4l4YbtlONk+h5YRfxXvQe2kM+2uaXbXhdJ"
}
*/
variable "instance_ami" {
  description = "instance_ami"
  default = "ami-06ec8443c2a35b0ba"
}

variable "instance_type" {
  description = "instance_typ"
  default = "t2.micro"
}

variable "vpc_cidr" {
    description = "CIDR for the whole VPC"
    default = "172.30.0.0/16"
}

variable "public_subnets_cidr" {
    type = list
    description = "CIDRs for the Public Subnets"
    #default = ["172.30.0.0/24", "172.30.1.0/24","172.30.2.0/24"]
    default = ["172.30.0.0/24"]
}

variable "private_subnets_cidr" {
  type = list
    description = "CIDRs for the Private Subnets"
    default =  ["172.30.100.0/24", "172.30.101.0/24","172.30.102.0/24"]
     
}

variable "aws_availability_zones" {
	type = list
  description = "aws_availability_zones"
	default = ["eu-central-1a", "eu-central-1b","eu-central-1c"]
}


//DB Vars

#############################

 variable "db_identifier" {
  description = "db_identifier"
	default ="demodb-oracle"
}

 variable "db_engine" {
	description = "db_engine"
	default ="oracle-se2"
}

 variable "db_engine_version" {
  description = "dbengine_version"
	default ="12.1.0.2.v8"
}

 variable "db_instance_class" {
  description = "db_instance_class"
	default ="db.t3.small"
}

 variable "db_license_model" {
  description = "db_license_model"
	default ="bring-your-own-license"
}

 variable "db_allocated_storage" {
  description = "db_allocated_storage"
	default ="20"
}

 variable "db_max_allocated_storage" {
  description = "db_max_allocated_storage"
	default ="100"
}


 variable "db_username" {
  description = "db_username"
	default ="admin"
}

 variable "db_password" {
  description = "db_password"
  type = string
	default ="Admin123"
}


 variable "db_storage_type" {
  description = "db_storage_type"
	default ="gp2"
}

 variable "db_multi_az" {
  description = "db_multi_az"
	default ="false"
}
