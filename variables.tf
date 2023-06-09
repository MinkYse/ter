variable "token" {
  description = "Yandex Cloud security OAuth token"
  default     = "nope" #generate yours by this https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token
}

variable "folder_id" {
  description = "Yandex Cloud Folder ID where resources will be created"
  default     = "b1g1g4l9akhu68n2163n"
}

variable "cloud_id" {
  description = "Yandex Cloud ID where resources will be created"
  default     = "b1ghtbh1p64hufs4ldep"
}

variable "public_key_path" {
  description = "Path to ssh public key, which would be used to access workers"
  default     = "~/.ssh/id_rsa.pub"
}

variable "private_key_path" {
  description = "Path to ssh private key, which would be used to access workers"
  default     = "~/.ssh/id_rsa"
}

variable "xrdp_password" {
  type = string
}

variable "user" {
  type = string
  default = "yc-user"
}

