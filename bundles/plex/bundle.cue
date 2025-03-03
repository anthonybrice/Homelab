bundle: {
	apiVersion: "v1alpha1"
	name:       "plex"
	instances: {
		"plex": {
			module: url: "oci://ghcr.io/stefanprodan/modules/flux-helm-release"
			namespace: "default"
			values: {
				repository: url: "https://k8s-home-lab.github.io/helm-charts/"
				chart: {
					name: "plex"
				}
				helmValues: {
					image: {
						repository: "linuxserver/plex"
						tag: "1.41.4"
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
		"plex-ingress": {
			module: url: "oci://ghcr.io/anthonybrice/modules/tailscale-ingress"
			namespace: "default"
			values: {
				serviceName: "plex"
				servicePort: name: "http"
				host: "plex"
			}
		}
	}
}
