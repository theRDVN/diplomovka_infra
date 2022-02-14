provider "google" {

  # credentials = file("C:/Users/pieterr/Documents/projects/pieterr_diplomovka.json")
  credentials = file("C:/Users/pieterr/Documents/projects/pieterr_dp.json")

  # project = "diplomovka-334620"
  project = "diplomovka-334621"
  region  = "europe-west1"
  zone    = "europe-west1-b"
}