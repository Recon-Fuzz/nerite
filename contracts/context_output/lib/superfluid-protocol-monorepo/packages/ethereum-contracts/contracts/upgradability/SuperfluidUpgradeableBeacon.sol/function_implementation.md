# Function: implementation()

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/upgradability/SuperfluidUpgradeableBeacon.sol/contract_SuperfluidUpgradeableBeacon.md]

## Metadata

- **Contract**: SuperfluidUpgradeableBeacon
- **Signature**: `implementation()`
- **Visibility**: public
- **Source Range**: 1098:112:83
- **Inherited From**: UpgradeableBeacon

## Implementation

```solidity
///  @dev Returns the current implementation address.
function implementation() virtual override public view returns (address) {
    return _implementation;
}
```

## State Variable Reads

- **_implementation** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UpgradeableBeacon.implementation() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

 @dev Returns the current implementation address.

### Interface Documentation

 @dev Must return an address that can be used as a delegate call target.
 {BeaconProxy} will check that this address is a contract.
