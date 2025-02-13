bundle: {
	apiVersion: "v1alpha1"
	name:       "radarr"
	instances: {
		"radarr": {
			module: url: "oci://ghcr.io/stefanprodan/modules/flux-helm-release"
			namespace: "default"
			values: {
				repository: url: "https://k8s-home-lab.github.io/helm-charts/"
				chart: {
					name: "radarr"
				}
				helmValues: {
					image: {
						repository: "linuxserver/radarr"
						tag: "5.18.4"
					}
					env: TZ: "America/Los_Angeles"
					metrics: enabled: false
					persistence: {
						config: enabled: true
					}
					tolerations: [{
						key:      "special"
						operator: "Equal"
						value:    "storage"
						effect:   "NoSchedule"
					}]
					affinity: nodeAffinity: requiredDuringSchedulingIgnoredDuringExecution: nodeSelectorTerms: [{
						matchExpressions: [{
							key:      "storage-node"
							operator: "In"
							values: ["true"]
						}]
					}]
				}
			}
		}
		"radarr-ingress": {
			module: url: "oci://ghcr.io/anthonybrice/modules/tailscale-ingress"
			namespace: "default"
			values: {
				serviceName: "radarr"
				servicePort: name: "http"
				host: "radarr"
			}
		}
	}
}
