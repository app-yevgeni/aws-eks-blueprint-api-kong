
resource "helm_release" "kong" {
  name             = "kong"
  namespace        = "kong"
  create_namespace = true

  repository = "https://charts.konghq.com"
  chart      = "kong"

  set = [
    # ---------------------------
    # Ingress / Gateway API
    # ---------------------------
    {
      name  = "ingressController.installCRDs"
      value = "false"
    },
    {
      name  = "ingressController.gatewayAPI.enabled"
      value = "true"
    },

    # ---------------------------
    # Replicas
    # ---------------------------
    {
      name  = "replicaCount"
      value = "2"
    },

    # ---------------------------
    # Service exposure (NLB)
    # ---------------------------
    {
      name  = "proxy.type"
      value = "LoadBalancer"
    },
    {
      name  = "proxy.externalTrafficPolicy"
      value = "Cluster"
    },

    # ---------------------------
    # AWS NLB configuration
    # ---------------------------
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
      value = "load_balancing.cross_zone.enabled=true"
    },

    # ---------------------------
    # Health checks
    # ---------------------------
    {
      name  = "proxy.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-healthcheck-protocol"
      value = "HTTP"
    },
    {
      name  = "proxy.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-healthcheck-path"
      value = "/status"
    },

    # ---------------------------
    # Stability under rollout / scale
    # ---------------------------
    {
      name  = "proxy.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-target-group-attributes"
      value = "deregistration_delay.timeout_seconds=30"
    },

    # ---------------------------
    # Multi-AZ pod distribution
    # ---------------------------
    {
      name  = "proxy.affinity.podAntiAffinity"
      value = "soft"
    },
    {
      name  = "proxy.topologySpreadConstraints[0].maxSkew"
      value = "1"
    },
    {
      name  = "proxy.topologySpreadConstraints[0].topologyKey"
      value = "topology.kubernetes.io/zone"
    },
    {
      name  = "proxy.topologySpreadConstraints[0].whenUnsatisfiable"
      value = "ScheduleAnyway"
    }
  ]
}
