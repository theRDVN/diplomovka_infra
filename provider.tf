provider "google" {

  credentials = file("C:/Users/pieterr/Documents/projects/pieterr_diplomovka.json")

  project = "diplomovka-334620"
  region  = "europe-west1"
  zone    = "europe-west1-b"
}