# Заменить на ID своего облака
# https://console.cloud.yandex.ru/cloud?section=overview
variable "yandex_cloud_id" {
  type = string
  description = "https://console.cloud.yandex.ru/cloud?section=overview"
}

# Заменить на Folder своего облака
# https://console.cloud.yandex.ru/cloud?section=overview
variable "yandex_folder_id" {
  type = string
  description = "https://console.cloud.yandex.ru/cloud?section=overview"
}

# Заменить на ID своего образа
# ID можно узнать с помощью команды yc compute image list
variable "centos-7-base" {
  type = string
  description = "yc compute image list"
}
# Заменить на ID сервисного аккаунта
# ID можно узнать с помощью команды yc iam service-account list
variable "service_account_id" {
  type = string
  description = "yc iam service-account list"
}

variable "CIDR_blocks" {
  type    = list(string)
  description = "subnets list"
}

variable "zones" {
  type    = list(string)
  description = "yc zones"
}

#variable "dns_name" {
#  type = list(string)
#  description = "domains"
#}
#
variable "sub_domain" {
  type    = list(string)
  description = "Subdomain"
}
#
#variable "hostname" {
#  type = list(string)
#  description = "Hostnames"
#}

variable "static_ip" {
  description = "reserved yc static ip"
}

variable "image_id" {
  default = "fd81u2vhv3mc49l1ccbb"
}

variable "domain" {
  description = "domain name"
}

variable "preemptible" {
  type = bool
  default = true
  description = "прерываемая VM"
}

variable "core_fraction" {
  type = number
  default = 20
  description = "% гарантированного обеспечения CPU"
}