# Interface: IDefaultPool

## Metadata

- **Name**: IDefaultPool
- **Type**: Interface
- **Path**: src/Interfaces/IDefaultPool.sol

## Public/External Functions

### troveManagerAddress()

- **Signature**: `troveManagerAddress()`
- **Visibility**: external
- **Source Range**: 87:63:77

**Signature:**
```solidity
function troveManagerAddress() external view returns (address);;
```

### activePoolAddress()

- **Signature**: `activePoolAddress()`
- **Visibility**: external
- **Source Range**: 155:61:77

**Signature:**
```solidity
function activePoolAddress() external view returns (address);;
```

### getCollBalance()

- **Signature**: `getCollBalance()`
- **Visibility**: external
- **Source Range**: 246:58:77

**Signature:**
```solidity
function getCollBalance() external view returns (uint256);;
```

### getBoldDebt()

- **Signature**: `getBoldDebt()`
- **Visibility**: external
- **Source Range**: 309:55:77

**Signature:**
```solidity
function getBoldDebt() external view returns (uint256);;
```

### sendCollToActivePool(uint256)

- **Signature**: `sendCollToActivePool(uint256)`
- **Visibility**: external
- **Source Range**: 369:56:77

**Signature:**
```solidity
function sendCollToActivePool(uint256 _amount) external;;
```

### receiveColl(uint256)

- **Signature**: `receiveColl(uint256)`
- **Visibility**: external
- **Source Range**: 430:47:77

**Signature:**
```solidity
function receiveColl(uint256 _amount) external;;
```

### increaseBoldDebt(uint256)

- **Signature**: `increaseBoldDebt(uint256)`
- **Visibility**: external
- **Source Range**: 483:52:77

**Signature:**
```solidity
function increaseBoldDebt(uint256 _amount) external;;
```

### decreaseBoldDebt(uint256)

- **Signature**: `decreaseBoldDebt(uint256)`
- **Visibility**: external
- **Source Range**: 540:52:77

**Signature:**
```solidity
function decreaseBoldDebt(uint256 _amount) external;;
```
