# baremetal-operator

This chart installs BareMetal Operator (BMO) https://github.com/metal3-io/baremetal-operator

## TL;DR

```console
$ helm repo add metal3 https://to.be.done/metal3
$ helm install my-release metal3/baremetal-operator
```

## Introduction

%%INTRODUCTION%% (check existing examples)

## Prerequisites

- Kubernetes 1.12+
- Helm 3.1.0
- PV provisioner support in the underlying infrastructure
- ReadWriteMany volumes for deployment scaling

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm install my-release bitnami/baremetal-operators
```

The command deploys baremetal-operator on the Kubernetes cluster in the default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters

### Global parameters

| Name                      | Description                                     | Value       |
| ------------------------- | ----------------------------------------------- | ----------- |
| `global.imageRegistry`    | Global Docker image registry                    | `nil`       |
| `global.imagePullSecrets` | Global Docker registry secret names as an array | `undefined` |
| `global.storageClass`     | Global StorageClass for Persistent Volume(s)    | `nil`       |


### BMO Config parameters

| Name     | Description                              | Value       |
| -------- | ---------------------------------------- | ----------- |
| `config` | Configuration parameters for BMO         | `undefined` |
| `auth`   | Configuration of Auth parameters for BMO | `undefined` |


### Common parameters

| Name                | Description                                        | Value           |
| ------------------- | -------------------------------------------------- | --------------- |
| `kubeVersion`       | Override Kubernetes version                        | `nil`           |
| `nameOverride`      | String to partially override common.names.fullname | `nil`           |
| `fullnameOverride`  | String to fully override common.names.fullname     | `nil`           |
| `commonLabels`      | Labels to add to all deployed objects              | `undefined`     |
| `commonAnnotations` | Annotations to add to all deployed objects         | `undefined`     |
| `clusterDomain`     | Kubernetes cluster domain name                     | `cluster.local` |
| `extraDeploy`       | Array of extra objects to deploy with the release  | `undefined`     |


### Baremetal Operator  Parameters

| Name                                                   | Description                                                                                                 | Value                          |
| ------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------- | ------------------------------ |
| `baremetalOperator.image.registry`                     | Baremetal Operator  image registry                                                                          | `quay.io`                      |
| `baremetalOperator.image.repository`                   | Baremetal Operator  image repository                                                                        | `metal3-io/baremetal-operator` |
| `baremetalOperator.image.tag`                          | Baremetal Operator  image tag (immutable tags are recommended)                                              | `capm3-v0.5.0`                 |
| `baremetalOperator.image.pullPolicy`                   | Baremetal Operator  image pull policy                                                                       | `Always`                       |
| `baremetalOperator.image.pullSecrets`                  | Baremetal Operator  image pull secrets                                                                      | `undefined`                    |
| `baremetalOperator.image.debug`                        | Enable Baremetal Operator  image debug mode                                                                 | `false`                        |
| `baremetalOperator.replicaCount`                       | Number of Baremetal Operator replicas to deploy                                                             | `1`                            |
| `baremetalOperator.livenessProbe.enabled`              | Enable livenessProbe on Baremetal Operator nodes                                                            | `true`                         |
| `baremetalOperator.livenessProbe.initialDelaySeconds`  | Initial delay seconds for livenessProbe                                                                     | `3`                            |
| `baremetalOperator.livenessProbe.periodSeconds`        | Period seconds for livenessProbe                                                                            | `3`                            |
| `baremetalOperator.readinessProbe.enabled`             | Enable readinessProbe on Baremetal Operator nodes                                                           | `false`                        |
| `baremetalOperator.customLivenessProbe`                | Custom livenessProbe that overrides the default one                                                         | `undefined`                    |
| `baremetalOperator.customReadinessProbe`               | Custom readinessProbe that overrides the default one                                                        | `undefined`                    |
| `baremetalOperator.resources.limits`                   | The resources limits for the Baremetal Operator containers                                                  | `undefined`                    |
| `baremetalOperator.resources.requests`                 | The requested resources for the Baremetal Operator containers                                               | `undefined`                    |
| `baremetalOperator.podSecurityContext.enabled`         | Enabled Baremetal Operator pods' Security Context                                                           | `false`                        |
| `baremetalOperator.podSecurityContext.fsGroup`         | Set Baremetal Operator pod's Security Context fsGroup                                                       | `1001`                         |
| `baremetalOperator.containerSecurityContext.enabled`   | Enabled Baremetal Operator containers' Security Context                                                     | `false`                        |
| `baremetalOperator.containerSecurityContext.runAsUser` | Set Baremetal Operator containers' Security Context runAsUser                                               | `1001`                         |
| `baremetalOperator.existingConfigmap`                  | The name of an existing ConfigMap with your custom configuration for %%MAIN_CONTAINER_NAME%%                | `nil`                          |
| `baremetalOperator.command`                            | Override default container command (useful when using custom images)                                        | `[]`                           |
| `baremetalOperator.args`                               | Override default container args (useful when using custom images)                                           | `[]`                           |
| `baremetalOperator.hostAliases`                        | Baremetal Operator pods host aliases                                                                        | `undefined`                    |
| `baremetalOperator.podLabels`                          | Extra labels for Baremetal Operator pods                                                                    | `undefined`                    |
| `baremetalOperator.podAnnotations`                     | Annotations for Baremetal Operator pods                                                                     | `undefined`                    |
| `baremetalOperator.podAffinityPreset`                  | Pod affinity preset. Ignored if `baremetalOperator.affinity` is set. Allowed values: `soft` or `hard`       | `""`                           |
| `baremetalOperator.podAntiAffinityPreset`              | Pod anti-affinity preset. Ignored if `baremetalOperator.affinity` is set. Allowed values: `soft` or `hard`  | `soft`                         |
| `baremetalOperator.nodeAffinityPreset.type`            | Node affinity preset type. Ignored if `baremetalOperator.affinity` is set. Allowed values: `soft` or `hard` | `""`                           |
| `baremetalOperator.nodeAffinityPreset.key`             | Node label key to match. Ignored if `baremetalOperator.affinity` is set                                     | `""`                           |
| `baremetalOperator.nodeAffinityPreset.values`          | Node label values to match. Ignored if `baremetalOperator.affinity` is set                                  | `undefined`                    |
| `baremetalOperator.affinity`                           | Affinity for Baremetal Operator pods assignment                                                             | `undefined`                    |
| `baremetalOperator.nodeSelector`                       | Node labels for Baremetal Operator pods assignment                                                          | `undefined`                    |
| `baremetalOperator.tolerations`                        | Tolerations for Baremetal Operator pods assignment                                                          | `undefined`                    |
| `baremetalOperator.updateStrategy.type`                | Baremetal Operator statefulset strategy type                                                                | `RollingUpdate`                |
| `baremetalOperator.priorityClassName`                  | Baremetal Operator pods' priorityClassName                                                                  | `""`                           |
| `baremetalOperator.lifecycleHooks`                     | for the Baremetal Operator container(s) to automate configuration before or after startup                   | `undefined`                    |
| `baremetalOperator.extraEnvVars`                       | Array with extra environment variables to add to Baremetal Operator nodes                                   | `undefined`                    |
| `baremetalOperator.extraEnvVarsCM`                     | Name of existing ConfigMap containing extra env vars for Baremetal Operator nodes                           | `nil`                          |
| `baremetalOperator.extraEnvVarsSecret`                 | Name of existing Secret containing extra env vars for Baremetal Operator nodes                              | `nil`                          |
| `baremetalOperator.extraVolumes`                       | Optionally specify extra list of additional volumes for the Baremetal Operator pod(s)                       | `undefined`                    |
| `baremetalOperator.extraVolumeMounts`                  | Optionally specify extra list of additional volumeMounts for the Baremetal Operator container(s)            | `undefined`                    |
| `baremetalOperator.sidecars`                           | Add additional sidecar containers to the Baremetal Operator pod(s)                                          | `undefined`                    |
| `baremetalOperator.initContainers`                     | Add additional init containers to the Baremetal Operator pod(s)                                             | `undefined`                    |


### Traffic Exposure Parameters

| Name                               | Description                                                  | Value       |
| ---------------------------------- | ------------------------------------------------------------ | ----------- |
| `service.type`                     | Baremetal Operator service type                              | `ClusterIP` |
| `service.nodePorts.http`           | Node port for HTTP                                           | `nil`       |
| `service.nodePorts.https`          | Node port for HTTPS                                          | `nil`       |
| `service.clusterIP`                | Baremetal Operator service Cluster IP                        | `nil`       |
| `service.loadBalancerIP`           | Baremetal Operator service Load Balancer IP                  | `nil`       |
| `service.loadBalancerSourceRanges` | Baremetal Operator service Load Balancer sources             | `undefined` |
| `service.externalTrafficPolicy`    | Baremetal Operator service external traffic policy           | `Cluster`   |
| `service.annotations`              | Additional custom annotations for Baremetal Operator service | `undefined` |


### Kube RBAC Proxy Container Parameters

| Name                                               | Description                                                       | Value                         |
| -------------------------------------------------- | ----------------------------------------------------------------- | ----------------------------- |
| `kubeRBACProxy.enabled`                            | Enable/disable KubeRBACProxy                                      | `true`                        |
| `kubeRBACProxy.image.registry`                     | Bitnami Shell image registry                                      | `gcr.io`                      |
| `kubeRBACProxy.image.repository`                   | Bitnami Shell image repository                                    | `kubebuilder/kube-rbac-proxy` |
| `kubeRBACProxy.image.tag`                          | Bitnami Shell image tag (immutable tags are recommended)          | `v0.8.0`                      |
| `kubeRBACProxy.image.pullPolicy`                   | Bitnami Shell image pull policy                                   | `Always`                      |
| `kubeRBACProxy.image.pullSecrets`                  | Bitnami Shell image pull secrets                                  | `undefined`                   |
| `kubeRBACProxy.args`                               | Override default container args (useful when using custom images) | `[]`                          |
| `kubeRBACProxy.resources.limits`                   | The resources limits for the init container                       | `undefined`                   |
| `kubeRBACProxy.resources.requests`                 | The requested resources for the init container                    | `undefined`                   |
| `kubeRBACProxy.containerSecurityContext.enabled`   | Enable/disable container's Security Context                       | `false`                       |
| `kubeRBACProxy.containerSecurityContext.runAsUser` | Set init container's Security Context runAsUser                   | `1001`                        |


### Other Parameters

| Name                    | Description                                          | Value  |
| ----------------------- | ---------------------------------------------------- | ------ |
| `rbac.create`           | Specifies whether RBAC resources should be created   | `true` |
| `serviceAccount.create` | Specifies whether a ServiceAccount should be created | `true` |
| `serviceAccount.name`   | The name of the ServiceAccount to use.               | `""`   |


```console
helm install my-release \
  --set config.DEPLOY_BOOTLOADER_URL=http://example.com/ipa.tar.gz!/esp.img \
    metal3/baremetal-operator
```


Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example,

```console
helm install my-release -f values.yaml metal3/baremetal-operator
```

> **Tip**: You can use the default [values.yaml](values.yaml)

## Configuration and installation details

### [Rolling VS Immutable tags](https://docs.bitnami.com/containers/how-to/understand-rolling-tags-containers/)

It is strongly recommended to use immutable tags in a production environment. This ensures your deployment does not change automatically if the same tag is updated with a different image.

