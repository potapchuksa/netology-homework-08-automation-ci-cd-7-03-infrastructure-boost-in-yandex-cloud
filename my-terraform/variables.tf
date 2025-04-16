variable "cloud_id" {
  type    = string
  default = "b1g7d7e1ciot45inandj"
}

variable "folder_id" {
  type    = string
  default = "b1glb6lkca6mratvm84p"
}

variable "vm" {
  type = map(number)
  default = {
    cores         = 2
    memory        = 1
    core_fraction = 20
  }
}
