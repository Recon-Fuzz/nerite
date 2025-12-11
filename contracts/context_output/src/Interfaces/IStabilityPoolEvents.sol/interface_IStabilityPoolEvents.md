# Interface: IStabilityPoolEvents

## Metadata

- **Name**: IStabilityPoolEvents
- **Type**: Interface
- **Path**: src/Interfaces/IStabilityPoolEvents.sol

## Events

### StabilityPoolCollBalanceUpdated

```solidity
event StabilityPoolCollBalanceUpdated(uint256 _newBalance);
```

### StabilityPoolBoldBalanceUpdated

```solidity
event StabilityPoolBoldBalanceUpdated(uint256 _newBalance);
```

### P_Updated

```solidity
event P_Updated(uint256 _P);
```

### S_Updated

```solidity
event S_Updated(uint256 _S, uint128 _epoch, uint128 _scale);
```

### B_Updated

```solidity
event B_Updated(uint256 _B, uint128 _epoch, uint128 _scale);
```

### EpochUpdated

```solidity
event EpochUpdated(uint128 _currentEpoch);
```

### ScaleUpdated

```solidity
event ScaleUpdated(uint128 _currentScale);
```

### DepositUpdated

```solidity
event DepositUpdated(address indexed _depositor, uint256 _newDeposit, uint256 _stashedColl, uint256 _snapshotP, uint256 _snapshotS, uint256 _snapshotB, uint256 _snapshotScale, uint256 _snapshotEpoch);
```

### DepositOperation

```solidity
event DepositOperation(address indexed _depositor, Operation _operation, uint256 _depositLossSinceLastOperation, int256 _depositChange, uint256 _yieldGainSinceLastOperation, uint256 _yieldGainClaimed, uint256 _ethGainSinceLastOperation, uint256 _ethGainClaimed);
```

## Enums

### Operation

```solidity
enum Operation {
    provideToSP,
    withdrawFromSP,
    claimAllCollGains
}
```
