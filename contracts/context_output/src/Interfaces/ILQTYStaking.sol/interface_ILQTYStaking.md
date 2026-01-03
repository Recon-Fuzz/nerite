# Interface: ILQTYStaking

## Metadata

- **Name**: ILQTYStaking
- **Type**: Interface
- **Path**: src/Interfaces/ILQTYStaking.sol

## Public/External Functions

### setAddresses(address,address,address,address,address)

- **Signature**: `setAddresses(address,address,address,address,address)`
- **Visibility**: external
- **Source Range**: 87:225:80

**Signature:**
```solidity
function setAddresses(address _lqtyTokenAddress, address _boldTokenAddress, address _troveManagerAddress, address _borrowerOperationsAddress, address _activePoolAddress) external;;
```

### stake(uint256)

- **Signature**: `stake(uint256)`
- **Visibility**: external
- **Source Range**: 318:45:80

**Signature:**
```solidity
function stake(uint256 _LQTYamount) external;;
```

### unstake(uint256)

- **Signature**: `unstake(uint256)`
- **Visibility**: external
- **Source Range**: 369:47:80

**Signature:**
```solidity
function unstake(uint256 _LQTYamount) external;;
```

### increaseF_ETH(uint256)

- **Signature**: `increaseF_ETH(uint256)`
- **Visibility**: external
- **Source Range**: 422:49:80

**Signature:**
```solidity
function increaseF_ETH(uint256 _ETHFee) external;;
```

### increaseF_bold(uint256)

- **Signature**: `increaseF_bold(uint256)`
- **Visibility**: external
- **Source Range**: 477:51:80

**Signature:**
```solidity
function increaseF_bold(uint256 _LQTYFee) external;;
```

### getPendingETHGain(address)

- **Signature**: `getPendingETHGain(address)`
- **Visibility**: external
- **Source Range**: 534:74:80

**Signature:**
```solidity
function getPendingETHGain(address _user) external view returns (uint256);;
```

### getPendingBoldGain(address)

- **Signature**: `getPendingBoldGain(address)`
- **Visibility**: external
- **Source Range**: 614:75:80

**Signature:**
```solidity
function getPendingBoldGain(address _user) external view returns (uint256);;
```
