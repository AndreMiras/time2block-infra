## Service account variables

variable "credentials" {
  type    = string
  default = "terraform-service-key.json"
}

variable "client_email" {
  type    = string
  default = "terraform-service-account@time2block.iam.gserviceaccount.com"
}

## Account variables

variable "project" {
  type    = string
  default = "time2block"
}

variable "region" {
  type    = string
  default = "us-east1"
}

variable "zone" {
  type    = string
  default = "us-east1-a"
}

variable "service_name" {
  description = "The service name is prepended to resource names."
  type        = string
  default     = "t2b"
}
