# Function: deploy(address,address,contract ISuperfluidToken,struct PoolConfig,struct PoolERC20Metadata)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/SuperfluidPoolDeployerLibrary.sol/contract_SuperfluidPoolDeployerLibrary.md]

## Metadata

- **Contract**: SuperfluidPoolDeployerLibrary
- **Signature**: `deploy(address,address,contract ISuperfluidToken,struct PoolConfig,struct PoolERC20Metadata)`
- **Visibility**: external
- **Source Range**: 449:799:128

## Implementation

```solidity
function deploy(address beacon, address admin, ISuperfluidToken token, PoolConfig memory config, PoolERC20Metadata memory poolERC20Metadata) external returns (SuperfluidPool pool) {
    bytes memory initializeCallData = abi.encodeWithSelector(SuperfluidPool.initialize.selector, admin, token, config.transferabilityForUnitsOwner, config.distributionFromAnyAddress, poolERC20Metadata.name, poolERC20Metadata.symbol, poolERC20Metadata.decimals);
    BeaconProxy superfluidPoolBeaconProxy = new BeaconProxy(beacon, initializeCallData);
    pool = SuperfluidPool(address(superfluidPoolBeaconProxy));
}
```

## Call Tree

```
No call tree available
```
