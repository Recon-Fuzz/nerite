# Function: onRegisterInitiative(uint256)

**Contract**: [lib/V2-gov/src/BribeInitiative.sol/contract_BribeInitiative.md]

## Metadata

- **Contract**: BribeInitiative
- **Signature**: `onRegisterInitiative(uint256)`
- **Visibility**: external
- **Source Range**: 6723:82:21

## Implementation

```solidity
/// @inheritdoc IInitiative
function onRegisterInitiative(uint256) virtual override external onlyGovernance() {}
```

## Related Implementations

### onlyGovernance()

- **Kind**: modifier
- **Source**: 1897:131:21
- **Link**: `lib/V2-gov/src/BribeInitiative.sol:BribeInitiative:onlyGovernance()`

```solidity
modifier onlyGovernance() {
    require(msg.sender == address(governance), "BribeInitiative: invalid-sender");
    _;
}
```

## State Variable Reads

- **governance** (`contract IGovernance`) [lib/V2-gov/src/interfaces/IGovernance.sol/interface_IGovernance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BribeInitiative.onRegisterInitiative(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] 🔒 MODIFIER: BribeInitiative.onlyGovernance() (NodeID: 1)
      💬 Args: [no args]
```

## Documentation

### Function Documentation

@inheritdoc IInitiative

### Interface Documentation

@notice Callback hook that is called by Governance after the initiative was successfully registered
 @param _atEpoch Epoch at which the initiative is registered
