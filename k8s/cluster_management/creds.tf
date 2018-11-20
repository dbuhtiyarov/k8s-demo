provider "google" {
  credentials = "${file("account.json")}"
  project     = "vernal-design-213911"
  region      = "us-central1"
}

terraform {
  backend "gcs" {
    bucket  = "dima-test"
    prefix  = "terraform/k8s-dev"
    credentials = "account.json"
  }
}
