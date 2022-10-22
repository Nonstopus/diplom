output "access_key" {
  value = yandex_iam_service_account_static_access_key.sa-static-key.access_key
}

output "secret_key" {
  value = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  sensitive = true
}

resource "local_file" "access_key" {
    content  = yandex_iam_service_account_static_access_key.sa-static-key.access_key
    filename = "access_key"
}

resource "local_file" "secret_key" {
    content  = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
    filename = "secret_key"
}
