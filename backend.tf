terraform {
 backend "gcs" {
   bucket  = "strike-assessment"
   prefix  = "terraform/state"
 }
}
