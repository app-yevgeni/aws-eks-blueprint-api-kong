
resource "kubernetes_manifest" "kong_session_plugin" {
  manifest = {
    apiVersion = "configuration.konghq.com/v1"
    kind       = "KongPlugin"

    metadata = {
      name      = "session-config"
      namespace = var.namespace
    }

    plugin = "session"

    config = {
      secret            = var.session_secret
      storage           = "cookie"
      cookie_name       = "kong_session"
      cookie_secure     = true
      cookie_http_only  = true
      cookie_same_site  = "Lax"

      rolling_timeout   = 3600
      idling_timeout    = 900
      absolute_timeout  = 86400
    }
  }
}
