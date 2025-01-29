variable "prefix" {
  description = "Prefix for naming resources"
  type        = string
}

# Location for the resources
variable "location" {
  description = "Azure region for the resources"
  type        = string
  default     = "East US"
}

# Kubernetes version to be used for the AKS cluster
variable "kubernetes_version" {
  description = "Kubernetes version for the AKS cluster"
  type        = string
  default     = "1.26.3"
}

# Node count for the default node pool
variable "node_count" {
  description = "Initial number of nodes in the default node pool"
  type        = number
  default     = 1
}

# VM size for the nodes in the AKS cluster
variable "vm_size" {
  description = "Size of the virtual machines for the AKS nodes"
  type        = string
  default     = "Standard_DS2_v2"
}

# OS disk size for the nodes in the AKS cluster
variable "os_disk_size_gb" {
  description = "OS disk size in GB for the AKS nodes"
  type        = number
  default     = 30
}

# Minimum number of nodes for auto-scaling
variable "min_count" {
  description = "Minimum number of nodes for auto-scaling"
  type        = number
  default     = 1
}

# Maximum number of nodes for auto-scaling
variable "max_count" {
  description = "Maximum number of nodes for auto-scaling"
  type        = number
  default     = 3
}
