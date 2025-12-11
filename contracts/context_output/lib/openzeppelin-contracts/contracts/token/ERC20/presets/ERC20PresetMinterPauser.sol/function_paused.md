# Function: paused()

**Contract**: [lib/openzeppelin-contracts/contracts/token/ERC20/presets/ERC20PresetMinterPauser.sol/contract_ERC20PresetMinterPauser.md]

## Metadata

- **Contract**: ERC20PresetMinterPauser
- **Signature**: `paused()`
- **Visibility**: public
- **Source Range**: 1615:84:85
- **Inherited From**: Pausable

## Implementation

```solidity
///  @dev Returns true if the contract is paused, and false otherwise.
function paused() virtual public view returns (bool) {
    return _paused;
}
```

## State Variable Reads

- **_paused** (`bool`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Pausable.paused() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

 @dev Returns true if the contract is paused, and false otherwise.
