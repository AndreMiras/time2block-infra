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

## Service environment variables

variable "env_enable_logger" {
  description = "If the request logging should be enabled."
  type        = bool
  default     = true
}

## Misc

variable "image_tag" {
  type    = string
  default = "latest"
}

variable "image" {
  type    = string
  default = "time2block"
}

variable "repository_id" {
  type    = string
  default = "andremiras"
}

locals {
  image_name = "${var.repository_id}/${var.image}:${var.image_tag}"
}
