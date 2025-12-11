# Interface: ILQTYStaking

## Metadata

- **Name**: ILQTYStaking
- **Type**: Interface
- **Path**: lib/V2-gov/src/interfaces/ILQTYStaking.sol

## Events

### LQTYTokenAddressSet

```solidity
event LQTYTokenAddressSet(address _lqtyTokenAddress);
```

### LUSDTokenAddressSet

```solidity
event LUSDTokenAddressSet(address _lusdTokenAddress);
```

### TroveManagerAddressSet

```solidity
event TroveManagerAddressSet(address _troveManager);
```

### BorrowerOperationsAddressSet

```solidity
event BorrowerOperationsAddressSet(address _borrowerOperationsAddress);
```

### ActivePoolAddressSet

```solidity
event ActivePoolAddressSet(address _activePoolAddress);
```

### StakeChanged

```solidity
event StakeChanged(address indexed staker, uint256 newStake);
```

### StakingGainsWithdrawn

```solidity
event StakingGainsWithdrawn(address indexed staker, uint256 LUSDGain, uint256 ETHGain);
```

### F_ETHUpdated

```solidity
event F_ETHUpdated(uint256 _F_ETH);
```

### F_LUSDUpdated

```solidity
event F_LUSDUpdated(uint256 _F_LUSD);
```

### TotalLQTYStakedUpdated

```solidity
event TotalLQTYStakedUpdated(uint256 _totalLQTYStaked);
```

### EtherSent

```solidity
event EtherSent(address _account, uint256 _amount);
```

### StakerSnapshotsUpdated

```solidity
event StakerSnapshotsUpdated(address _staker, uint256 _F_ETH, uint256 _F_LUSD);
```

## Public/External Functions

### setAddresses(address,address,address,address,address)

- **Signature**: `setAddresses(address,address,address,address,address)`
- **Visibility**: external
- **Source Range**: 886:225:29

**Signature:**
```solidity
function setAddresses(address _lqtyTokenAddress, address _lusdTokenAddress, address _troveManagerAddress, address _borrowerOperationsAddress, address _activePoolAddress) external;;
```

### stake(uint256)

- **Signature**: `stake(uint256)`
- **Visibility**: external
- **Source Range**: 1117:45:29

**Signature:**
```solidity
function stake(uint256 _LQTYamount) external;;
```

### unstake(uint256)

- **Signature**: `unstake(uint256)`
- **Visibility**: external
- **Source Range**: 1168:47:29

**Signature:**
```solidity
function unstake(uint256 _LQTYamount) external;;
```

### increaseF_ETH(uint256)

- **Signature**: `increaseF_ETH(uint256)`
- **Visibility**: external
- **Source Range**: 1221:49:29

**Signature:**
```solidity
function increaseF_ETH(uint256 _ETHFee) external;;
```

### increaseF_LUSD(uint256)

- **Signature**: `increaseF_LUSD(uint256)`
- **Visibility**: external
- **Source Range**: 1276:51:29

**Signature:**
```solidity
function increaseF_LUSD(uint256 _LQTYFee) external;;
```

### getPendingETHGain(address)

- **Signature**: `getPendingETHGain(address)`
- **Visibility**: external
- **Source Range**: 1333:74:29

**Signature:**
```solidity
function getPendingETHGain(address _user) external view returns (uint256);;
```

### getPendingLUSDGain(address)

- **Signature**: `getPendingLUSDGain(address)`
- **Visibility**: external
- **Source Range**: 1413:75:29

**Signature:**
```solidity
function getPendingLUSDGain(address _user) external view returns (uint256);;
```

### stakes(address)

- **Signature**: `stakes(address)`
- **Visibility**: external
- **Source Range**: 1494:63:29

**Signature:**
```solidity
function stakes(address _user) external view returns (uint256);;
```

### totalLQTYStaked()

- **Signature**: `totalLQTYStaked()`
- **Visibility**: external
- **Source Range**: 1563:59:29

**Signature:**
```solidity
function totalLQTYStaked() external view returns (uint256);;
```
