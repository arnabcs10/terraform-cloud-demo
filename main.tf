terraform {
  cloud {
    organization = "orgtf"

    workspaces {
      name = "gcp-workspace"
    }
  }
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.44.0"
    }
  }
}

provider "google" {
  # Configuration options
  # credentials = file(var.credentials)
  project = var.project
  region = var.region
  zone = var.zone
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

resource "google_compute_instance" "vm_instance" {
  name         = var.instance_name
  machine_type = var.instance_type
  zone         = var.zone

  
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }


  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }



}

# resource "google_storage_bucket_object" "picture" {
#   name   = "starry_night"
#   source = "starry_night.jpg"
#   bucket = var.bucket_name
# }

