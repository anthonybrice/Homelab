bundle: {
    apiVersion: "v1alpha1"
    name:       "radarr"
    instances: {
        "flux": {
            module: url: "oci://ghcr.io/stefanprodan/modules/flux-helm-release"
            namespace: "radarr"
            values: {
                repository: url: "https://k8s-home-lab.github.io/helm-charts/"
                chart: {
                  name: "k8s-home-lab/radarr"
                }
                helmValues: {
                  "env.TZ": "America/Los_Angeles"
                  metrics: enabled: false
                }
            }
        }
    }
}
