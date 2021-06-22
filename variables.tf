variable "gi" {
  default = "us-west-1"
}

variable "vpc_cider" {
  default = "10.0.0.0/26"
}

variable "pub_subnet_cidr" {
  default = "10.0.0.0/28"
}

variable "priv_subnet_cidr" {
  default = "10.0.0.16/28"
}

variable "ami" {
  default = "ami-0b2ca94b5b49e0132"
}

variable "instance_type" {
  default = "t2.micro"
}
variable "myIp" {
  default = "137.25.123.179/32"
//  default = "38.32.152.82/32"
}

variable "w-base-image" {
  description = "Windows 2019 base image"
  default = "ami-0c645579c7f157046"
}

variable "api-x-docnetcore" {
  description = "Linux with Powershell and dotnet core"
  default = "ami-01b5fc6dd9ddfd4f1"
}

variable "w-container-image" {
  description = "Windows 2019 server with container"
  default = "ami-09c6b20dfa7706427"
}

variable "ami-x-with-PS-core" {
  description = "Amazon Linux with Dot Net core and Powershell"
  default = "ami-01b5fc6dd9ddfd4f1"
}

variable "ami-win-container" {
  default = "ami-09c6b20dfa7706427"
}

variable "ami-ubuntu-18-4" {
  default = "ami-07b068f843ec78e72"
}