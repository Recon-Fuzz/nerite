# Function: constructor(bool,bool,uint64,address,address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol/contract_Superfluid.md]

## Metadata

- **Contract**: Superfluid
- **Signature**: `constructor(bool,bool,uint64,address,address)`
- **Visibility**: public
- **Source Range**: 3770:502:163

## Implementation

```solidity
/// NOTE: Whenever modifying the storage layout here it is important to update the validateStorageLayout
///  function in its respective mock contract to ensure that it doesn't break anything or lead to unexpected
///  behaviors/layout when upgrading
constructor(bool nonUpgradable, bool appWhiteListingEnabled, uint64 callbackGasLimit, address simpleForwarderAddress, address erc2771ForwarderAddress) {
    NON_UPGRADABLE_DEPLOYMENT = nonUpgradable;
    APP_WHITE_LISTING_ENABLED = appWhiteListingEnabled;
    CALLBACK_GAS_LIMIT = callbackGasLimit;
    SIMPLE_FORWARDER = SimpleForwarder(simpleForwarderAddress);
    _ERC2771_FORWARDER = ERC2771Forwarder(erc2771ForwarderAddress);
}
```

## State Variable Writes

- **NON_UPGRADABLE_DEPLOYMENT** (`bool`)
- **APP_WHITE_LISTING_ENABLED** (`bool`)
- **CALLBACK_GAS_LIMIT** (`uint64`)
- **SIMPLE_FORWARDER** (`contract SimpleForwarder`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SimpleForwarder.sol/contract_SimpleForwarder.md]
- **_ERC2771_FORWARDER** (`contract ERC2771Forwarder`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/ERC2771Forwarder.sol/contract_ERC2771Forwarder.md]

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: Superfluid.constructor(bool,bool,uint64,address,address) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: Superfluid
```

## Documentation

### Function Documentation

NOTE: Whenever modifying the storage layout here it is important to update the validateStorageLayout
 function in its respective mock contract to ensure that it doesn't break anything or lead to unexpected
 behaviors/layout when upgrading
