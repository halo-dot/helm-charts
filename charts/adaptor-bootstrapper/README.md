# Helm Values Documentation

| Parameter | Description | Default |
|-----------|-------------|---------|
| `adaptor.namespace` | Set this to the namespace of the halo adaptor | `halo` |
| `adaptor.url` | Set this to the URL of the adaptor's service | `http://adaptor` |
| `adaptor.username` | Set this to the current admin username | `admin` |
| `adaptor.currentPassword` | Set this to the current admin password, you do not necessarily need to update this  value, if the password is changed the bootstrapper will use the newPassword to login, sensitive | `password` |
| `adaptor.newPassword` | Set this to a new admin password if you want to change the admin password, required and sensitive | `null` |
| `bootstrap.name` | Name of the boostrap job | `bootstrap` |
| `bootstrap.image.repository` | Image repository for the bootstrap image, required | `null` |
| `bootstrap.image.tag` | Tag for the bootstrap image, this overrides the version setting | `latest` |
| `bootstrap.acquirer.name` | Name of the "Acquirer" (Acquirer is the Halo term for an App) | `Acquirer` |
| `bootstrap.acquirer.alias` | Alias of the "Acquirer" (Acquirer is the Halo term for an App) | `Acquirer` |
| `bootstrap.jwt.issuerName` | Name for the iss field of the JWT you will issue to the SDK to authenticate your  users to the Adaptor | `jwtIssuer` |
| `bootstrap.jwt.key` | Public key used to validate the JWTs, required | `null` |
| `bootstrap.terminalCurrencyCode` | Terminal currency code to set the terminal to | `0710` |
| `bootstrap.encryptTags` | Tags which must be encrypted by the terminal | `57,5A` |
| `bootstrap.backoffLimit` | How many times the bootstrap job must try to run before failing | `1` |
| `bootstrap.configOverride` | Terminal config overrides, these must be set to override the default terminal config  [see example 1](#bootstrapconfigoverride-example-1).   To remove a config override, add `"remove": true` to the config override object [see example 2](#bootstrapconfigoverride-example-2). | `[]` |
| `bootstrap.caPublicKeyOverride` | CA public keys overrides, these must be set to override the default CA public keys  format for CA public keys overrides  [see example 1](#bootstrapcapublickeyoverride-example-1). | `[]` |
| `bootstrap.paymentProvider.name` | Name of the paymentprovider, can be left as default | `PaymentProvider` |
| `bootstrap.paymentProvider.url` | URL of the paymentprovider service | `http://paymentprovider` |
| `imageCredentials.enabled` | Enables using private registries with authentication | `false` |
| `imageCredentials.registry` | Sets the URL for the private registry to login to | `quay.io` |
| `imageCredentials.username` | Sets the username for logging into the private registry | `someone` |
| `imageCredentials.password` | Sets the password for logging into the private registry, sensitive | `sillyness` |
| `imageCredentials.email` | Sets the email address for logging into the private registry | `someone@host.com` |

## Code Examples
### `bootstrap.configOverride` Example 1
```yaml title="Format for configOverride"
 - aid: A0000000031010
   kernelID: 3
   transactionTypeConfigs:
     - transactionType: "00"
       tlvDatabase:
         - tag: "9F33"
           value: "200808"
```

### `bootstrap.configOverride` Example 2
```yaml title="Format for configOverride with remove"
 # Example to remove an AID:
 - aid: A0000000031010
   remove: true

 # Example to remove a transaction type config:
 - aid: A0000000031010
   kernelID: 3
   transactionTypeConfigs:
     - transactionType: "00"
       remove: true

 # Example to remove a TLV tag:
 - aid: A0000000031010
   kernelID: 3
   transactionTypeConfigs:
   - transactionType: "00"
     tlvDatabase:
       - tag: "9F33"
         remove: true
```

### `bootstrap.caPublicKeyOverride` Example 1
```yaml title="Format for caPublicKeyOverride"
 - hexRID: A000000025
   hexRIDIndex: 01
   remove: true

 - hexRID: <hexRID>
   hexRIDIndex: <hexRIDIndex>
   keyLengthInBits: <keyLengthInBits>
   hexExponent: <hexExponent>
   hexModulus: <hexModulus>
   hexHashSha1: <hexHashSha1>

 - hexRID: A000000025
   hexRIDIndex: 02
   keyLengthInBits: 896
   hexExponent: 03
   hexModulus: AF4B8D230FDFCB1538E975795A1DB40C396A5359FAA31AE095CB522A5C82E7FFFB252860EC2833EC3D4A665F133DD934EE1148D81E2B7E03F92995DDF7EB7C90A75AB98E69C92EC91A533B21E1C4918B43AFED5780DE13A32BBD37EBC384FA3DD1A453E327C56024DACAEA74AA052C4D
   hexHashSha1: 33F5B0344943048237EC89B275A95569718AEE20
```

