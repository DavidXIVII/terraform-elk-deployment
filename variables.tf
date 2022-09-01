variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}

variable "key" {
  description = "AWS key name"
  type        = string
  default     = "david"
}

variable "instance" {
  description = "AWS Instance Type"
  type        = string
  default     = "m5a.large"
}

variable "instance_name" {
  description = "AWS Instance Name"
  type        = string
  default     = "ELK-Server"
}

variable "private_key" {
  description = "Private Key Path"
  type        = string
  default     = "~/Downloads/david.pem"
}
