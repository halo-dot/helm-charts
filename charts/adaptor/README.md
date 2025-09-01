# Helm Values Documentation

| Parameter | Description | Default |
|-----------|-------------|---------|
| `version` | Container image tag for adaptor and payment provider, required | `latest` |
| `aws.accessKeyId` | Access key ID for your AWS IAM user, required | `null` |
| `aws.secretAccessKey` | Secret access key for your AWS IAM user, required and sensitive | `null` |
| `aws.region` | AWS region, required | `us-west-2` |
| `database.host` | PostgreSQL database hostname, required | `null` |
| `database.port` | PostgreSQL database port | `5432` |
| `database.user` | PostgreSQL database user, required | `null` |
| `database.password` | PostgreSQL database password, required and sensitive | `null` |
| `database.databaseName` | PostgreSQL database name, required | `null` |
| `redis` | Connection information for Redis | `{host: null, password: null, port: 6379, user: redis}` |
| `redis.host` | Redis hostname, if Redis is deployed in cluster using  the Redis helm chart this should be set to redis-master.default.svc.cluster.local, required | `null` |
| `redis.port` | Redis port | `6379` |
| `redis.user` | Redis user | `redis` |
| `redis.password` | Redis password, required and sensitive | `null` |
| `attestation.host` | Remote attestation hostname, for non prod you can use  the QA endpoint set here, for production you will  be provided with a URL specifically for you, required | `https://kernelserver.qa.haloplus.io` |
| `keys.dbIntegrity` | Secrets manager secret name for DB integrity secret | `haloDbIntegrity` |
| `keys.dbEncryptionKey` | Secrets manager secret name for DB encryption secret | `haloDbEncryption` |
| `keys.transactionSigning` | Secrets manager secret name for transaction signing secret | `haloTransactionSigning` |
| `keys.cmk` | KMS CMK used to encrypt the Secrets manager secrets | `haloCmk` |
| `adaptor.namespace` | K8s namespace to deploy the adaptor into | `halo` |
| `adaptor.name` | Name of the adaptor deployment and service | `adaptor` |
| `adaptor.replicaCount` | Replica count of the adaptor, you should probably set this to your at least your node count | `1` |
| `adaptor.readinessProbe` | Readiness probe settings for adaptor, the adaptor readiness probe checks that the service is up,  as well as checking that the A&M server is up and reachable | `{enabled: true, periodSeconds: 30}` |
| `adaptor.readinessProbe.enabled` | Enable the readiness probe, you might want to disable this if you are testing without  access to the A&M server | `true` |
| `adaptor.readinessProbe.periodSeconds` | How often to run the readiness probe | `30` |
| `adaptor.image.repository` | Image repository for the adaptor image, required | `null` |
| `adaptor.image.tag` | Tag for the adaptor image, this overrides the version setting | `null` |
| `adaptor.service.targetPort` | Port the adaptor listens on | `9000` |
| `adaptor.service.listeningPort` | Port that the adaptor service exposes, if HTTPS is enabled, this should be set to 443 | `80` |
| `adaptor.logLevel` | Logging level for the adaptor. Choices are LogDebug, LogInfo, LogWarn and LogError  LogDebug provides full logging, including requests, responses and all card details  LogInfo provides some logging, useful for investigating the state of the system without leaking card data  Should be set to LogInfo in production and LogDebug in nonprod | `LogInfo` |
| `adaptor.jsonLogs` | JSON formatted logs, should be set to true when using logging tooling such as Grafana Loki or ELK.  Can be useful to turn off when testing locally | `true` |
| `adaptor.resources` | Resource limits and requests, these values can be tuned based on your volumes, it is recommended to set  memory limits and requests to the same value | `{limits: {cpu: 500m, memory: 1G}, requests: {cpu: 100m, memory: 1G}}` |
| `adaptor.tls.enabled` | Whether to enable TLS on the adaptor | `false` |
| `adaptor.tls.cert` | The TLS server certificate | `-----BEGIN CERTIFICATE-----...` |
| `adaptor.tls.key` | The TLS server key, sensitive | `-----BEGIN PRIVATE KEY-----...` |
| `adaptor.tls.ca` | The TLS server CA | `-----BEGIN CERTIFICATE-----...` |
| `adaptor.tls.passphrase` | Optional passphrase for encrypting the TLS key, sensitive | `null` |
| `adaptor.jwtSigningSecret` | HS256 Secret used for issuing tokens for admin users, if not set a random value will be generated | `null` |
| `adaptor.hsmServiceUrl` | If HSM service is not enabled, this is the hostname name of the implementation of the HSM service to use, format is `http(s)://<hostname>:<port>` | `null` |
| `scheduledJobs.voids` | Job for voiding failed transaction | `{cron: '*/30 * * * *', enabled: true, maxRetries: 10, runAtStartup: false}` |
| `scheduledJobs.voids.enabled` | Sets whether voiding failed transactions should run | `true` |
| `scheduledJobs.voids.cron` | How often the void job should run | `*/30 * * * *` |
| `scheduledJobs.voids.maxRetries` | How often many times a failed transaction should try be voided before giving up | `10` |
| `scheduledJobs.voids.runAtStartup` | Whether the void job should run when the adaptor starts up | `false` |
| `paymentProvider.name` | Name of the paymentprovider deployment and service | `paymentprovider` |
| `paymentProvider.replicaCount` | Replica count of the payment provider, should probably be set to at least node count | `1` |
| `paymentProvider.readinessProbe.enabled` | Enables the readiness probe for the payment provider | `true` |
| `paymentProvider.readinessProbe.periodSeconds` | The frequency of readiness probes | `30` |
| `paymentProvider.service.targetPort` | The port the paymentprovider listens on, this will be provided along with the config for the paymentprovider | `null` |
| `paymentProvider.service.listeningPort` | kThe port the paymentprovider service exposes | `80` |
| `paymentProvider.image.repository` | Image repository for the paymentprovider image | `null` |
| `paymentProvider.image.tag` | Tag for the paymentprovider image, this overrides the version setting | `null` |
| `paymentProvider.resources` | Resource limits and requests, these values can be tuned based on your volumes, it is recommended to set  memory limits and requests to the same value | `{limits: {cpu: 500m, memory: 256Mi}, requests: {cpu: 100m, memory: 256Mi}}` |
| `paymentProvider.config` | Config for the paymentprovider, this is specific per payment provider and will be provided, required  Format will be `HALO_<PAYMENT_PROVIDER_NAME>_<CONFIG_KEY>: <CONFIG_VALUE>` | `null` |
| `hsmService.enabled` | Whether to enable the HSM service, this is required for PIN and card data encryption | `true` |
| `hsmService.name` | Name of the HSM service deployment and service | `hsmservice` |
| `hsmService.image.repository` | Image repository for the HSM service image, required | `null` |
| `hsmService.image.tag` | Tag for the HSM service image, this overrides the version setting | `null` |
| `hsmService.service.targetPort` | The port the HSM service listens on, this will be provided along with the config for the HSM service | `3000` |
| `hsmService.service.listeningPort` | The port the HSM service exposes, if TLS is enabled this should be set to 443 | `80` |
| `hsmService.readinessProbe.enabled` | Enables the readiness probe for the HSM service | `true` |
| `hsmService.readinessProbe.periodSeconds` | The frequency of readiness probes | `30` |
| `hsmService.resources` | Resource limits and requests, these values can be tuned based on your volumes, it is recommended to set  memory limits and requests to the same value | `{limits: {cpu: 500m, memory: 256Mi}, requests: {cpu: 100m, memory: 256Mi}}` |
| `hsmService.hsm.enableMTls` | Whether to enable mutual TLS with the HSM, this is required for secure communication with the HSM | `true` |
| `hsmService.hsm.ip` | The IP address of the HSM, required | `null` |
| `hsmService.hsm.port` | The port the HSM listens on, required | `null` |
| `hsmService.hsm.lmkId` | The LMK ID for the HSM | `null` |
| `hsmService.hsm.name` | The name of the HSM | `HSM` |
| `hsmService.hsm.ca` | The CA certificate for TLS with HSM | `-----BEGIN CERTIFICATE-----...` |
| `hsmService.hsm.cert` | The client certificate for the HSM | `-----BEGIN CERTIFICATE-----...` |
| `hsmService.hsm.key` | The client key for the HSM | `-----BEGIN PRIVATE KEY-----...` |
| `hsmService.tls.enabled` | Whether to enable TLS on the HSM service, this is required for secure communication with the HSM service if a service mesh is not used | `true` |
| `hsmService.tls.ca` | CA certificate for TLS for the HSM service | `-----BEGIN CERTIFICATE-----...` |
| `hsmService.tls.cert` | Server certificate for TLS for the HSM service | `-----BEGIN CERTIFICATE-----...` |
| `hsmService.tls.key` | Server key for TLS for the HSM service, sensitive | `-----BEGIN PRIVATE KEY-----...` |
| `hsmService.maskPciSensitiveData` | Setting to disable masking PCI sensitive data in logs, this should be set to true in production. Useful for debugging in nonprod | `true` |
| `hsmService.destinationPinKeyType` | Setting to choose the key type for destination PIN keys, options are BDK or ZMK | `BDK` |
| `hsmService.destinationPinKey` | Value of the destination PIN key generated on the HSM. | `null` |
| `hsmService.destinationDataKeyType` | Setting to choose the key type for destination data keys, options are BDK or ZMK | `BDK` |
| `hsmService.destinationDataKey` | Value of the destination card data encryption key generated on the HSM, sensitive | `null` |
| `hsmService.rkiKey` | Value of the HSM BDK key used to derive PIN keys injected into the SDK, sensitive  This key must be an AES 128 BDK. | `null` |
| `hsmService.apiKey` | The API key for the HSM service, this is used to authenticate requests to the HSM service.  If this is not set, a random value will be generated, sensitive | `null` |
| `imageCredentials.enabled` | Enables using private registries with authentication | `false` |
| `imageCredentials.registry` | Sets the URL for the private registry to login to | `quay.io` |
| `imageCredentials.username` | Sets the username for logging into the private registry | `someone` |
| `imageCredentials.password` | Sets the password for logging into the private registry, sensitive | `sillyness` |
| `imageCredentials.email` | Sets the email address for logging into the private registry | `someone@host.com` |
| `openTelemetry.metricsEndpoint` | Opentelemetry metrics endpoint | `http://otel-collector:4317/v1/metrics` |
| `openTelemetry.tracesEndpoint` | Opentelemetry traces endpoint | `http://otel-collector:4317/v1/traces` |
