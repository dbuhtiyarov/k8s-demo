variable "project_name" {}

provider "google" {
  credentials = "${file("~/.gcp/account.json")}"
  project     = "${var.project_name}"
}

terraform {
  backend "gcs" {
    prefix  = "terraform/k8s-dev"
    credentials = "~/.gcp/account.json"
  }
}

resource "google_container_node_pool" "np" {
  name       = "node-pool"
  zone       = "us-central1-a"
  cluster    = "${google_container_cluster.dev.name}"
  node_count = 1
  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    machine_type = "n1-standard-2"

  }

}
resource "google_container_cluster" "dev" {
  name               = "k8s-dev"
  zone               = "us-central1-a"
  initial_node_count = 1

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    machine_type = "n1-standard-2"

    labels {
      foo = "bar"
    }

    tags = ["foo", "bar"]
  }
}

# The following outputs allow authentication and connectivity to the GKE Cluster.
output "client_certificate" {
  value = "${google_container_cluster.dev.master_auth.0.client_certificate}"
}

output "client_key" {
  value = "${google_container_cluster.dev.master_auth.0.client_key}"
}

output "cluster_ca_certificate" {
  value = "${google_container_cluster.dev.master_auth.0.cluster_ca_certificate}"
}
