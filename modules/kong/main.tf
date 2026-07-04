
resource "helm_release" "kong" {
  name             = "kong"
  namespace        = "kong"
  create_namespace = true

  repository = "https://charts.konghq.com"
  chart      = "kong"

  set = [
    {
      name  = "ingressController.installCRDs"
      value = "false"
    },
    {
      name  = "ingressController.gatewayAPI.enabled"
      value = "true"
    },
    {
      name  = "proxy.type"
      value = "LoadBalancer"
    },
    {
      name  = "proxy.externalTrafficPolicy"
      value = "Cluster" # ✅ Multi-AZ safe traffic handling
    },
    {
      name  = "proxy.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type"
      value = "nlb"
    },
    {
      name  = "proxy.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-scheme"
      value = "internet-facing"
    },
    {
      name  = "proxy.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-nlb-target-type"
      value = "ip"
    },
    { 
    name  = "proxy.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-attributes"
    value = "load_balancing.cross_zone.enabled=true"  # ✅ CRITICAL: cross-zone load balancing (true Multi-AZ behavior)
    }
  ]
}

