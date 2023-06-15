variable "instance_size" {
   type = string
   description = "Azure instance size"
   default = "Standard_F2"
}

variable "location" {
   type = string
   description = "Region"
   default = "France Central"
}

variable "environment" {
   type = string
   description = "Environment"
   default = "Staging"
}
