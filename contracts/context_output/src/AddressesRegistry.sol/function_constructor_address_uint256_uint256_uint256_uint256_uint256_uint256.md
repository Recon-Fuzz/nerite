# Function: constructor(address,uint256,uint256,uint256,uint256,uint256,uint256)

**Contract**: [src/AddressesRegistry.sol/contract_AddressesRegistry.md]

## Metadata

- **Contract**: AddressesRegistry
- **Signature**: `constructor(address,uint256,uint256,uint256,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 3298:1031:203

## Implementation

```solidity
constructor(address _owner, uint256 _ccr, uint256 _mcr, uint256 _scr, uint256 _debtLimit, uint256 _liquidationPenaltySP, uint256 _liquidationPenaltyRedistribution) Ownable(_owner) {
    if ((_ccr <= 1e18) || (_ccr >= 2e18)) revert InvalidCCR();
    if ((_mcr <= 1e18) || (_mcr >= 2e18)) revert InvalidMCR();
    if ((_scr <= 1e18) || (_scr >= 2e18)) revert InvalidSCR();
    if (_debtLimit <= 0) revert InvalidDebtLimit();
    if (_liquidationPenaltySP < MIN_LIQUIDATION_PENALTY_SP) revert SPPenaltyTooLow();
    if (_liquidationPenaltySP > _liquidationPenaltyRedistribution) revert SPPenaltyGtRedist();
    if (_liquidationPenaltyRedistribution > MAX_LIQUIDATION_PENALTY_REDISTRIBUTION) revert RedistPenaltyTooHigh();
    CCR = _ccr;
    SCR = _scr;
    MCR = _mcr;
    debtLimit = _debtLimit;
    LIQUIDATION_PENALTY_SP = _liquidationPenaltySP;
    LIQUIDATION_PENALTY_REDISTRIBUTION = _liquidationPenaltyRedistribution;
}
```

## Related Implementations

### (address)

- **Kind**: internal
- **Source**: 806:133:216
- **Link**: `src/Dependencies/Ownable.sol:Ownable:constructor(address)`

```solidity
///  @dev Initializes the contract setting `initialOwner` as the initial owner.
constructor(address initialOwner) {
    _owner = initialOwner;
    emit OwnershipTransferred(address(0), initialOwner);
}
```

## State Variable Writes

- **CCR** (`uint256`)
- **SCR** (`uint256`)
- **MCR** (`uint256`)
- **debtLimit** (`uint256`)
- **LIQUIDATION_PENALTY_SP** (`uint256`)
- **LIQUIDATION_PENALTY_REDISTRIBUTION** (`uint256`)
- **_owner** (`address`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: AddressesRegistry.constructor(address,uint256,uint256,uint256,uint256,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: AddressesRegistry
  └─ [1] 🏗️ CONSTRUCTOR: Ownable.constructor(address) (NodeID: 1)
      💬 Args: [_owner]
      🏗️  Contract: Ownable
```
