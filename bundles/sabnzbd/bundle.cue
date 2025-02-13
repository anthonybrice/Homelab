bundle: {
	apiVersion: "v1alpha1"
	name:       "sabnzbd"
	instances: {
		"sabnzbd": {
			module: url: "oci://ghcr.io/stefanprodan/modules/flux-helm-release"
			namespace: "default"
			values: {
				repository: url: "https://k8s-at-home.com/charts/"
				chart: {
					name: "sabnzbd"
				}
				helmValues: {
					image: {
						repository: "linuxserver/sabnzbd"
						tag: "4.4.1"
					}
					env: {
						TZ: "America/Los_Angeles"
					}
					persistence: {
						config: enabled: true
						media: {
							enabled: true
							accessMode: "ReadWriteOnce"
							size: "10Gi"
							mountPath: "/media"
						}
						downloads: {
							enabled: true
							accessMode: "ReadWriteOnce"
							size: "10Gi"
							mountPath: "/downloads"
						}
					}
					tolerations: [{
						key: "special"
						operator: "Equal"
						value: "storage"
						effect: "NoSchedule"
					}]
					affinity: nodeAffinity: requiredDuringSchedulingIgnoredDuringExecution: nodeSelectorTerms: [{
						matchExpressions: [{
							key: "storage-node"
							operator: "In"
							values: ["true"]
						}]
					}]
					securityContext: {
						runAsUser: 911
						runAsGroup: 911
						fsGroup: 911
					}
				}
			}
		}
		"sabnzbd-ingress": {
			module: url: "oci://ghcr.io/anthonybrice/modules/tailscale-ingress"
			namespace: "default"
			values: {
				serviceName: "sabnzbd"
				servicePort: name: "http"
				host: "sabnzbd"
			}
		}
	}
}
