# Function: changeSuperTokenAdmin(contract ISuperToken,address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol/contract_Superfluid.md]

## Metadata

- **Contract**: Superfluid
- **Signature**: `changeSuperTokenAdmin(contract ISuperToken,address)`
- **Visibility**: external
- **Source Range**: 12334:136:163

## Implementation

```solidity
function changeSuperTokenAdmin(ISuperToken token, address newAdmin) external onlyGovernance() {
    token.changeAdmin(newAdmin);
}
```

## Related Implementations

### onlyGovernance()

- **Kind**: modifier
- **Source**: 44183:116:163
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol:Superfluid:onlyGovernance()`

```solidity
modifier onlyGovernance() {
    if (msg.sender != address(_gov)) revert HOST_ONLY_GOVERNANCE();
    _;
}
```

## External Calls

- **ISuperToken::changeAdmin(address)**

## State Variable Reads

- **_gov** (`contract ISuperfluidGovernance`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluidGovernance.sol/interface_ISuperfluidGovernance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Superfluid.changeSuperTokenAdmin(contract ISuperToken,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] 🔒 MODIFIER: Superfluid.onlyGovernance() (NodeID: 1)
      💬 Args: [no args]
```

## Documentation

### Interface Documentation

 @notice Change the SuperToken admin address
 @dev The admin is the only account allowed to update the token logic
 For backward compatibility, the "host" is the default "admin" if unset (address(0)).
