bundle: {
	apiVersion: "v1alpha1"
	name:       "sabnzbd"
	instances: {
		"sabnzbd": {
			module: url: "oci://ghcr.io/stefanprodan/modules/flux-helm-release"
			namespace: "sabnzbd"
			values: {
				repository: url: "https://k8s-at-home.com/charts/"
				chart: {
					name: "sabnzbd"
				}
				helmValues: {
					"env.TZ": "America/Los_Angeles"
					persistence: {
						config: enabled: true
					}
				}
			}
		}
		"ingress": {
			module: url: "oci://ghcr.io/anthonybrice/modules/tailscale-ingress"
			namespace: "sabnzbd"
			values: {
				serviceName: "sabnzbd"
				servicePort: name: "http"
				host: "sabnzbd"
			}
		}
	}
}
