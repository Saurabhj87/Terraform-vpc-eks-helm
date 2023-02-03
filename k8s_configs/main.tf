resource "helm_release" "namespace" {
  name  = "namespace"
  chart = "./helm_charts/namespace"
  create_namespace = true

  values = [jsonencode({})]

  set {
    name  = "ns_name"
    value = var.ns_name
  }
} 
/* resource "helm_release" "kong" {
  name  = "kong"
  chart = "./helm_charts/kong"
  create_namespace = true
  
  values = [jsonencode({})]

  set {
    name  = "ns_name"
    value = var.ns_name
  }
} */

# Kong Config##
 resource "helm_release" "kong_base" {
  name  = "kong-base"
  repository = "https://charts.konghq.com"
  chart = "kong"
  create_namespace = true
  
  values = [jsonencode({})]

  depends_on = [
    helm_release.kong_ns
  ]
}