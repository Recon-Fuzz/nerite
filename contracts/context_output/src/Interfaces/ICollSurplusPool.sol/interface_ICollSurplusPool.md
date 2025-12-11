# Interface: ICollSurplusPool

## Metadata

- **Name**: ICollSurplusPool
- **Type**: Interface
- **Path**: src/Interfaces/ICollSurplusPool.sol

## Public/External Functions

### getCollBalance()

- **Signature**: `getCollBalance()`
- **Visibility**: external
- **Source Range**: 91:58:225

**Signature:**
```solidity
function getCollBalance() external view returns (uint256);;
```

### getCollateral(address)

- **Signature**: `getCollateral(address)`
- **Visibility**: external
- **Source Range**: 155:73:225

**Signature:**
```solidity
function getCollateral(address _account) external view returns (uint256);;
```

### accountSurplus(address,uint256)

- **Signature**: `accountSurplus(address,uint256)`
- **Visibility**: external
- **Source Range**: 234:68:225

**Signature:**
```solidity
function accountSurplus(address _account, uint256 _amount) external;;
```

### claimColl(address)

- **Signature**: `claimColl(address)`
- **Visibility**: external
- **Source Range**: 308:46:225

**Signature:**
```solidity
function claimColl(address _account) external;;
```
