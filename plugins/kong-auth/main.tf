
resource "kubernetes_manifest" "key_auth_plugin" {
  manifest = {
    apiVersion = "configuration.konghq.com/v1"
    kind       = "KongPlugin"

    metadata = {
      name      = "key-auth"
      namespace = "default"
    }

    plugin = "key-auth"

    config = {
      key_names        = ["apikey"]
      hide_credentials  = true
    }
  }
}

resource "kubernetes_manifest" "kong_consumer" {
  manifest = {
    apiVersion = "configuration.konghq.com/v1"
    kind       = "KongConsumer"

    metadata = {
      name      = "app-user"
      namespace = "default"
    }

    username = "app-user"
  }
}

resource "kubernetes_manifest" "consumer_key" {
  manifest = {
    apiVersion = "configuration.konghq.com/v1"
    kind       = "Secret"

    metadata = {
      name      = "app-user-key"
      namespace = "default"

      annotations = {
        "kubernetes.io/service-account.name" = "app-user"
      }
    }

    type = "Opaque"

    stringData = {
      kongCredType = "key-auth"
      key          = "my-secret-api-key-123"
    }
  }
}
