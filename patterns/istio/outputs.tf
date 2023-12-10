output "configure_kubectl" {
  description = "Configure kubectl: make sure you're logged in with the correct AWS profile and run the following command to update your kubeconfig"
  value       = <<EOT
    # Even it should be done automatically
    aws eks update-kubeconfig --name ${module.eks.cluster_name} --alias ${module.eks.cluster_name} --user-alias ${module.eks.cluster_name}
    sed -i 's%${module.eks.cluster_arn}%${module.eks.cluster_name}%g' ~/.kube/config
  EOT
}

output "verify_observability_commands" {
  description = "Verify commands"
  value       = <<EOT
    # Visualize Istio Mesh console using Kiali
    k port-forward svc/kiali 20001:20001 -n istio-system

    # Get to the Prometheus UI
    k port-forward svc/prometheus 9090:9090 -n istio-system

    # Visualize metrics in using Grafana
    k port-forward svc/grafana 3000:3000 -n istio-system

    # Visualize application traces via Jaeger
    k port-forward svc/tracing 16686:80 -n istio-system
  EOT
}
