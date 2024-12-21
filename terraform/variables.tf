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

## Domains setup

variable "domain_suffix" {
  type        = string
  description = "The domain suffix used by all subdomains"
  default     = "t2b.is"
}

variable "cloudflare_zone_id" {
  type        = string
  description = "The zone identifier"
  default     = "5dec4341390f2d15a370b74bb2ef7caa"
}

variable "api_domain_prefix" {
  type    = string
  default = "www"
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
  image_name      = "${var.repository_id}/${var.image}:${var.image_tag}"
  www_domain_name = "www.${var.domain_suffix}"
  api_domain_name = "${var.api_domain_prefix}.${var.domain_suffix}"
}
