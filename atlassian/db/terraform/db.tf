variable "project_name" {}

provider "google" {
  credentials = "${file("~/.gcp/account.json")}"
  project     = "${var.project_name}"
}

terraform {
  backend "gcs" {
    prefix  = "terraform/db-dev"
    credentials = "~/.gcp/account.json"
  }
}

resource "google_sql_database_instance" "master" {
  name = "master-instance"
  database_version = "POSTGRES_9_6"
  region = "us-central1"

  settings {
    tier = "db-f1-micro"
  }
}

