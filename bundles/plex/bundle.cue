bundle: {
	apiVersion: "v1alpha1"
	name:       "plex"
	instances: {
		"plex": {
			module: url: "oci://ghcr.io/stefanprodan/modules/flux-helm-release"
			namespace: "plex"
			values: {
				repository: url: "https://k8s-home-lab.github.io/helm-charts/"
				chart: {
					name: "plex"
				}
				helmValues: {
					"env.TZ": "America/Los_Angeles"
					metrics: enabled: false
				}
			}
		}
		"ingress": {
			module: url: "oci://ghcr.io/anthonybrice/modules/tailscale-ingress"
			namespace: "plex"
			values: {
				serviceName: "plex"
				servicePort: name: "http"
				host: "plex"
			}
		}
	}
}
