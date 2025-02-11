bundle: {
	apiVersion: "v1alpha1"
	name:       "prowlarr"
	instances: {
		"prowlarr": {
			module: url: "oci://ghcr.io/stefanprodan/modules/flux-helm-release"
			namespace: "prowlarr"
			values: {
				repository: url: "https://k8s-home-lab.github.io/helm-charts/"
				chart: {
					name: "prowlarr"
				}
				helmValues: {
					"env.TZ": "America/Los_Angeles"
				}
			}
		}
		"ingress": {
			module: url: "oci://ghcr.io/anthonybrice/modules/tailscale-ingress"
			namespace: "prowlarr"
			values: {
				serviceName: "prowlarr"
				servicePort: name: "http"
				host: "prowlarr"
			}
		}
	}
}
