variable "availabilityZones" {
  type        = list(string)
  description = "Descriptions of availability zones"
}

locals {
  my_list = toset(var.availabilityZones)
}
