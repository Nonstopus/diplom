terraform {
    backend "s3" {
    endpoint = "storage.yandexcloud.net"
    bucket = "diplomus-object-storage"
    key = "terraform/terraform.tfstate"
    region = "ru-cental1"
    skip_credentials_validation = true
    skip_region_validation = true
    }
}
// Дополнительно создан файл backend.conf содержащий значения переменных "access_key" и "secret_key" сгенерированных на этапе создания объектного хранилища.
