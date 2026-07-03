variable "namespace" {
  type    = string
  default = "default"
}

variable "session_secret" {
  type      = string
  sensitive = true
}
