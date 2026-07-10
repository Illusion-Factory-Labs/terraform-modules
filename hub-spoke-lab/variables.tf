variable "subscription_id" {
  type        = string
  description = "Subscription ID where the resources will be created."
}

variable "environment" {
  type        = string
  description = "Environment for the resources to be created."
}

variable "location" {
  type        = string
  description = "Location where the resources will be created."
}

variable "tags" {
  type        = map(string)
  description = "Tags to be applied to the resources."
}