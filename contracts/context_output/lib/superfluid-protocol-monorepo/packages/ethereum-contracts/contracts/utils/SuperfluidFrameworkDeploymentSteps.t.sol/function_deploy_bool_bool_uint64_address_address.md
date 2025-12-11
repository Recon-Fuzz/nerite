# Function: deploy(bool,bool,uint64,address,address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeploymentSteps.t.sol/contract_SuperfluidHostDeployerLibrary.md]

## Metadata

- **Contract**: SuperfluidHostDeployerLibrary
- **Signature**: `deploy(bool,bool,uint64,address,address)`
- **Visibility**: external
- **Source Range**: 15039:413:181

## Implementation

```solidity
function deploy(bool _nonUpgradable, bool _appWhiteListingEnabled, uint64 callbackGasLimit, address simpleForwarderAddress, address erc2771ForwarderAddress) external returns (Superfluid) {
    return new Superfluid(_nonUpgradable, _appWhiteListingEnabled, callbackGasLimit, simpleForwarderAddress, erc2771ForwarderAddress);
}
```

## Call Tree

```
No call tree available
```
