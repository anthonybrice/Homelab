bundle: {
	apiVersion: "v1alpha1"
	name:       "radarr"
	instances: {
		"radarr": {
			module: url: "oci://ghcr.io/stefanprodan/modules/flux-helm-release"
			namespace: "radarr"
			values: {
				repository: url: "https://k8s-home-lab.github.io/helm-charts/"
				chart: {
					name: "radarr"
				}
				helmValues: {
					"env.TZ": "America/Los_Angeles"
					metrics: enabled: false
				}
			}
		}
		"ingress": {
			module: url: "oci://ghcr.io/anthonybrice/modules/tailscale-ingress"
			namespace: "radarr"
			values: {
				serviceName: "radarr"
				servicePort: name: "http"
				host: "radarr"
			}
		}
	}
}
