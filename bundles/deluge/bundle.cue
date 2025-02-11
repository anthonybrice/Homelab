bundle: {
	apiVersion: "v1alpha1"
	name:       "deluge"
	instances: {
		"deluge": {
			module: url: "oci://ghcr.io/stefanprodan/modules/flux-helm-release"
			namespace: "deluge"
			values: {
				repository: url: "https://k8s-at-home.com/charts/"
				chart: {
					name: "deluge"
				}
				helmValues: {
					"env.TZ": "America/Los_Angeles"
				}
			}
		}
		"ingress": {
			module: url: "oci://ghcr.io/anthonybrice/modules/tailscale-ingress"
			namespace: "deluge"
			values: {
				serviceName: "deluge"
				servicePort: name: "http"
				host: "deluge"
			}
		}
	}
}
