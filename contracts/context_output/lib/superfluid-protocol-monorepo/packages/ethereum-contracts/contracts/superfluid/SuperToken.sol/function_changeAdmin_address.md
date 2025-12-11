# Function: changeAdmin(address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol/contract_SuperToken.md]

## Metadata

- **Contract**: SuperToken
- **Signature**: `changeAdmin(address)`
- **Visibility**: external
- **Source Range**: 6300:191:161

## Implementation

```solidity
function changeAdmin(address newAdmin) override external onlyAdmin() {
    address oldAdmin = _getAdmin();
    _setAdmin(newAdmin);
    emit AdminChanged(oldAdmin, newAdmin);
}
```

## Related Implementations

### _getAdmin()

- **Kind**: internal
- **Source**: 6599:170:161
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol:SuperToken:_getAdmin()`

```solidity
function _getAdmin() internal view returns (address admin) {
    assembly {
        admin := sload(_ADMIN_SLOT)
    }
}
```

### _setAdmin(address)

- **Kind**: internal
- **Source**: 6775:159:161
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol:SuperToken:_setAdmin(address)`

```solidity
function _setAdmin(address newAdmin) internal {
    assembly {
        sstore(_ADMIN_SLOT, newAdmin)
    }
}
```

### onlyAdmin()

- **Kind**: modifier
- **Source**: 30330:239:161
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol:SuperToken:onlyAdmin()`

```solidity
///  @dev The host contract is implicitly the admin if admin is address(0) else it is the explicitly set admin
///  override address
modifier onlyAdmin() {
    address adminSlotAdmin = _getAdmin();
    address admin = (adminSlotAdmin == address(0)) ? address(_host) : adminSlotAdmin;
    if (msg.sender != admin) revert SUPER_TOKEN_ONLY_ADMIN();
    _;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperToken.changeAdmin(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: SuperToken._getAdmin() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SuperToken._setAdmin(address) (NodeID: 2)
  │   💬 Args: [newAdmin]
  │   👁️  Def: internal
  └─ [1] 🔒 MODIFIER: SuperToken.onlyAdmin() (NodeID: 3)
      💬 Args: [no args]
    └─ [2] ⚙️ FUNCTION: SuperToken._getAdmin() (NodeID: 4)
        💬 Args: [no args]
        👁️  Def: internal
```

## Documentation

### Interface Documentation

 @notice Changes the admin for the SuperToken
 @dev Only the current admin can call this function
 if admin is address(0), it is implicitly the host address
 @param newAdmin New admin address
