resource "google_compute_address" "ops-static-ip" {
  name     = "ops-static-ip"
  region = "europe-west1"
  project = "diplomovka-334620"
}

resource "google_compute_address" "appserver-static-ip" {
  name     = "appserver-static-ip"
  region = "europe-west1"
  project = "diplomovka-334620"
}