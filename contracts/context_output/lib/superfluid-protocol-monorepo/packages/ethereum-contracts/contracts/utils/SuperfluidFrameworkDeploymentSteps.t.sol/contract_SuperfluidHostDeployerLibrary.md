# Contract: SuperfluidHostDeployerLibrary

## Metadata

- **Name**: SuperfluidHostDeployerLibrary
- **Type**: Contract
- **Path**: lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeploymentSteps.t.sol

## Public/External Functions

### deploy(bool,bool,uint64,address,address)

- **Signature**: `deploy(bool,bool,uint64,address,address)`
- **Visibility**: external
- **Source Range**: 15039:413:181
- **Details**: [function_deploy_bool_bool_uint64_address_address.md](./function_deploy_bool_bool_uint64_address_address.md)

**Signature:**
```solidity
function deploy(bool _nonUpgradable, bool _appWhiteListingEnabled, uint64 callbackGasLimit, address simpleForwarderAddress, address erc2771ForwarderAddress) external returns (Superfluid);
```
