bundle: {
	apiVersion: "v1alpha1"
	name:       "sonarr"
	instances: {
		"sonarr": {
			module: url: "oci://ghcr.io/stefanprodan/modules/flux-helm-release"
			namespace: "default"
			values: {
				repository: url: "https://k8s-home-lab.github.io/helm-charts/"
				chart: {
					name: "sonarr"
				}
				helmValues: {
					image: {
						repository: "linuxserver/sonarr"
						tag: "4.0.13"
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
		"sonarr-ingress": {
			module: url: "oci://ghcr.io/anthonybrice/modules/tailscale-ingress"
			namespace: "default"
			values: {
				serviceName: "sonarr"
				servicePort: name: "http"
				host: "sonarr"
			}
		}
	}
}
