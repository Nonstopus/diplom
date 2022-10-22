# Заменить на ID своего облака
# https://console.cloud.yandex.ru/cloud?section=overview
variable "yandex_cloud_id" {
  default = "b1go25qu14ai0gmnuah1"
}

# Заменить на Folder своего облака
# https://console.cloud.yandex.ru/cloud?section=overview
variable "yandex_folder_id" {
  default = "b1gtok8tlhffaunrl10r"
}

# Заменить на ID сервисного аккаунта
# ID можно узнать с помощью команды yc iam service-account list
variable "service_account_id" {
  default = "aje4ghtju6akoj1eoudm"
}