# Function: initialize()

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/FullUpgradableSuperTokenProxy.sol/contract_FullUpgradableSuperTokenProxy.md]

## Metadata

- **Contract**: FullUpgradableSuperTokenProxy
- **Signature**: `initialize()`
- **Visibility**: external
- **Source Range**: 606:368:160

## Implementation

```solidity
function initialize() external {
    address factory;
    assembly {
        factory := sload(_FACTORY_SLOT)
    }
    if (address(factory) != address(0)) revert FUSTP_ALREADY_INITIALIZED();
    factory = msg.sender;
    assembly {
        sstore(_FACTORY_SLOT, factory)
    }
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: FullUpgradableSuperTokenProxy.initialize() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
