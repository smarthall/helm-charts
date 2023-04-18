# frigate

![Version: 1.0.4](https://img.shields.io/badge/Version-1.0.4-informational?style=flat-square) ![AppVersion: 0.12.0](https://img.shields.io/badge/AppVersion-0.12.0-informational?style=flat-square)

NVR With Realtime Object Detection for IP Cameras. Forked from https://github.com/blakeblackshear/blakeshome-charts

**Homepage:** <https://github.com/smarthall/helm-charts/tree/main/charts/frigate>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| smarthall | <helm@danielhall.me> |  |

## Source Code

* <https://github.com/blakeblackshear/frigate>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Set Pod affinity rules |
| config | string | `"mqtt:\n  host: test.mosquitto.org\n  topic_prefix: frigate\ndetectors:\n  cpu1:\n    type: cpu\ncameras: {}\n"` | frigate configuration - see [Docs](https://docs.frigate.video/configuration/index) for more info |
| coral.enabled | bool | `false` | enables the use of a Coral device |
| coral.hostPath | string | `"/dev/bus/usb"` | path on the host to which to mount the Coral device |
| env | object | `{}` | additional ENV variables to set. Prefix with FRIGATE_ to target Frigate configuration values |
| envFromSecrets | list | `[]` | set environment variables from Secret(s) |
| extraVolumeMounts | list | `[]` | declare additional volume mounts |
| extraVolumes | list | `[]` | declare extra volumes to use for Frigate |
| fullnameOverride | string | `""` | Overrides the Full Name of resources |
| gpu.nvidia.enabled | bool | `false` | Enables NVIDIA GPU compatibility. Must also use the "amd64nvidia" tagged image |
| gpu.nvidia.runtimeClassName | string | `nil` | Overrides the default runtimeClassName |
| image.pullPolicy | string | `"IfNotPresent"` | Docker image pull policy |
| image.repository | string | `"ghcr.io/blakeblackshear/frigate"` | Docker registry/repository to pull the image from |
| image.tag | string | `"0.12.0"` | Overrides the default tag (appVersion) used in Chart.yaml ([Docker Hub](https://hub.docker.com/r/blakeblackshear/frigate/tags?page=1)) |
| imagePullSecrets | list | `[]` | Docker image pull policy |
| ingress.annotations | object | `{}` | annotations to configure your Ingress. See your Ingress Controller's Docs for more info. |
| ingress.enabled | bool | `false` | Enables the use of an Ingress Controller to front the Service and can provide HTTPS |
| ingress.hosts | list | `[{"host":"chart.example.local","paths":["/"]}]` | list of hosts and their paths that ingress controller should repsond to. |
| ingress.tls | list | `[]` | list of TLS configurations |
| nameOverride | string | `""` | Overrides the name of resources |
| nodeSelector | object | `{}` | Node Selector configuration |
| persistence.data.accessMode | string | `"ReadWriteOnce"` | [access mode](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes) to use for the PVC |
| persistence.data.enabled | bool | `false` | Enables persistence for the data directory |
| persistence.data.size | string | `"10Gi"` | size/capacity of the PVC |
| persistence.data.skipuninstall | bool | `false` | Do not delete the pvc upon helm uninstall |
| podAnnotations | object | `{}` | Set additonal pod Annotations |
| probes.liveness.enabled | bool | `true` |  |
| probes.liveness.failureThreshold | int | `5` |  |
| probes.liveness.initialDelaySeconds | int | `30` |  |
| probes.liveness.timeoutSeconds | int | `10` |  |
| probes.readiness.enabled | bool | `true` |  |
| probes.readiness.failureThreshold | int | `5` |  |
| probes.readiness.initialDelaySeconds | int | `30` |  |
| probes.readiness.timeoutSeconds | int | `10` |  |
| probes.startup.enabled | bool | `false` |  |
| probes.startup.failureThreshold | int | `30` |  |
| probes.startup.periodSeconds | int | `10` |  |
| resources | object | `{}` | Set resource limits/requests for the Pod(s) |
| securityContext | object | `{}` | Set Security Context |
| service.annotations | object | `{}` |  |
| service.http.enabled | bool | `true` | If you want to disable HTTP for some reason, do it here |
| service.http.port | int | `5000` | Port to host the HTTP services on |
| service.labels | object | `{}` |  |
| service.loadBalancerIP | string | `nil` | Set specific IP address for LoadBalancer. `service.type` must be set to `LoadBalancer` |
| service.rtmp.enabled | bool | `false` | Expose RTMP in the service |
| service.rtmp.port | int | `1935` | Port to host the RTMP on |
| service.rtsp.enabled | bool | `false` | Expose RTSP in the service |
| service.rtsp.port | int | `8554` | Port to host the RTSP on |
| service.type | string | `"ClusterIP"` | Type of Service to use |
| service.webrtc.enabled | bool | `false` | Expose WebRTC in the service |
| service.webrtc.port | int | `8555` | Port to host the WebRTC on |
| shmSize | string | `"1Gi"` | amount of shared memory to use for caching |
| strategyType | string | `"Recreate"` | upgrade strategy type (e.g. Recreate or RollingUpdate) |
| tolerations | list | `[]` | Node toleration configuration |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
