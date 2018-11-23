variable "project_name" {}
variable "user" {}
variable "password" {}


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

data "null_data_source" "auth_netw_postgres_allowed_2" {
  count = 1

  inputs = {
    name  = "onprem-${count.index + 1}"
    value = "${element(list("0.0.0.0/0"), count.index)}"
  }
}

resource "google_sql_database_instance" "master" {
  name = "master-instance"
  database_version = "POSTGRES_9_6"
  region = "us-central1"

  settings {
    tier = "db-f1-micro"

  ip_configuration {
      authorized_networks = [
        "${data.null_data_source.auth_netw_postgres_allowed_2.*.outputs}",
      ]
    }

  }
}

resource "google_sql_database" "users" {
  name      = "jira-dev"
  instance  = "${google_sql_database_instance.master.name}"
}

resource "google_sql_user" "users" {
  name     = "${var.user}"
  instance = "${google_sql_database_instance.master.name}"
  password = "${var.password}"
}
