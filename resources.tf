
###  ---  Application  ---  ###
module "httpd" {
  source = "./modules/httpd"
  depends_on = [kubernetes_namespace.migration]

  name   = "httpd-server"
  namespace = "default"
  replicas  = 1
  image = "virtapp/apache:7f6c4bf4-3-6"
  service_port = 8080
  service_type = "ClusterIP"
}

module "kong" {
  source = "./modules/kong"
  depends_on = [module.httpd]
}

module "kong-ui" {
  source = "./modules/kong-ui"
  depends_on = [module.kong]
}

module "ingress" {
  source = "./modules/ingress"
  depends_on = [module.kong-ui]
}


