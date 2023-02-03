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

