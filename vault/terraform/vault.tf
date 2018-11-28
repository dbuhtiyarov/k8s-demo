variable "project_name" {}

provider "google" {
  credentials = "${file("~/.gcp/account.json")}"
  project     = "${var.project_name}"
}

terraform {
  backend "gcs" {
    prefix  = "terraform/vault-dev"
    credentials = "~/.gcp/account.json"
  }
}

# Create a new instance

resource "google_compute_instance" "ubuntu-xenial" {
  name = "vault-dev"
  machine_type = "n1-standard-1"
  zone = "us-central1-a"
  boot_disk {
    initialize_params {
      image = "ubuntu-1604-lts"
    }
  }
  network_interface {
    network = "default"
    access_config {}
  }
  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
metadata_startup_script = "${file("provision.sh")}"
}
resource "google_compute_firewall" "vault" {
  name = "vault"
  network = "default"

  allow {
    protocol = "tcp"
    ports = ["80"]
  }
}
