# -------------------------------------------------------------------------------------------------------------
# VARIABLE DEFINITION
# -------------------------------------------------------------------------------------------------------------

variable "project_id" {
  description = "The project ID to host the cluster in"
  default     = "strike-assessment"
}

variable "cluster_name" {
  description = "The name for the GKE cluster"
  default     = "strike-assessment"
}
variable "env_name" {
  description = "The environment for the GKE cluster"
  default     = "dev"
}
variable "region" {
  description = "The region to host the cluster in"
  default     = "us-west1"
}
variable "network" {
  description = "The VPC network created to host the cluster in"
  default     = "gke-strike-dev-network"
}
variable "subnetwork" {
  description = "The subnetwork created to host the cluster in"
  default     = "gke-strke-dev-subnet"
}
variable "ip_range_pods_name" {
  description = "The secondary ip range to use for pods"
  default     = "gke-strike-dev-ip-range-pods"
}
variable "ip_range_services_name" {
  description = "The secondary ip range to use for services"
  default     = "gke-strike-dev-ip-range-services"
}