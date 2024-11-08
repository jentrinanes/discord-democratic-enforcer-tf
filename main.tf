# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.7.0"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Create a Storage
resource "azurerm_storage_account" "sademocraticenforcer" {
  name                     = "sademocraticenforcer"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Create an App Service Plan
resource "azurerm_service_plan" "ASP-rgdiscorddemocraticenforcer-b9e5" {
  name                = "ASP-rgdiscorddemocraticenforcer-b9e5"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "Y1"
}

# Create a Function App
resource "azurerm_linux_function_app" "fademocraticenforcer" {
  name                       = "fademocraticenforcer"
  resource_group_name        = var.resource_group_name
  location                   = var.location
  storage_account_name       = azurerm_storage_account.sademocraticenforcer.name
  storage_account_access_key = azurerm_storage_account.sademocraticenforcer.primary_access_key
  service_plan_id            = azurerm_service_plan.ASP-rgdiscorddemocraticenforcer-b9e5.id
  site_config {
    worker_count             = 1
    app_scale_limit          = 200
    elastic_instance_minimum = 0
  }
}