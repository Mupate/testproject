


/*
terraform {

    required_version = ">= 0.14"
    required_providers {
        azurerm = {
          source   = "hashicorp/azurerm"
          version  = "2.10.0"
          

        }

    }
}

*/

provider "azurerm" {
   features {}
}

variable "resourceGroupName" {
  description = "This is the name for resource group"
  default = "myrg"
}

variable "location" {
    description = "Resource group location"
    default = "westus"
}

resource "azurerm_resource_group" "myrg" {
  name = var.resourceGroupName
  location = var.location

}

variable "application_name" {
  description = "The name of application"
  default = "mytestapp"
}
variable "environment_name" {
  description = "The name of environment"
  default = "prod"
}
variable "country_code" {
  description = "The country code (FR-US-...)"
  default = "india"
}

locals {
    resourcename = "${var.application_name}-${var.environment_name}-${var.country_code}"
}

resource "azurerm_resource_group" "rg" {
  name = "rg-${local.resourcename}"
  location = "West Europe"
}
resource "azurerm_public_ip" "pip" {
  name = "ip-${local.resourcename}"
  location = "West Europe"
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method = "Dynamic"
  domain_name_label = "mydomain"
}

