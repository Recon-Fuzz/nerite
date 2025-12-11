# Interface: IUserProxy

## Metadata

- **Name**: IUserProxy
- **Type**: Interface
- **Path**: lib/V2-gov/src/interfaces/IUserProxy.sol

## Public/External Functions

### lqty()

- **Signature**: `lqty()`
- **Visibility**: external
- **Source Range**: 356:52:32

**Signature:**
```solidity
/// @notice Address of the LQTY token
///  @return lqty Address of the LQTY token
function lqty() external view returns (IERC20 lqty);;
```

### lusd()

- **Signature**: `lusd()`
- **Visibility**: external
- **Source Range**: 502:52:32

**Signature:**
```solidity
/// @notice Address of the LUSD token
///  @return lusd Address of the LUSD token
function lusd() external view returns (IERC20 lusd);;
```

### stakingV1()

- **Signature**: `stakingV1()`
- **Visibility**: external
- **Source Range**: 681:68:32

**Signature:**
```solidity
/// @notice Address of the V1 LQTY staking contract
///  @return stakingV1 Address of the V1 LQTY staking contract
function stakingV1() external view returns (ILQTYStaking stakingV1);;
```

### stakingV2()

- **Signature**: `stakingV2()`
- **Visibility**: external
- **Source Range**: 876:63:32

**Signature:**
```solidity
/// @notice Address of the V2 LQTY staking contract
///  @return stakingV2 Address of the V2 LQTY staking contract
function stakingV2() external view returns (address stakingV2);;
```

### stake(uint256,address,bool,address)

- **Signature**: `stake(uint256,address,bool,address)`
- **Visibility**: external
- **Source Range**: 1758:204:32

**Signature:**
```solidity
/// @notice Stakes a given amount of LQTY tokens in the V1 staking contract
///  @dev The LQTY tokens must be approved for transfer by the user
///  @param _amount Amount of LQTY tokens to stake
///  @param _lqtyFrom Address from which to transfer the LQTY tokens
///  @param _doSendRewards If true, send rewards claimed from LQTY staking
///  @param _recipient Address to which the tokens should be sent
///  @return lusdReceived Amount of LUSD tokens received as a side-effect of staking new LQTY
///  @return lusdSent Amount of LUSD tokens sent to `_recipient` (may include previously received LUSD)
///  @return ethReceived Amount of ETH received as a side-effect of staking new LQTY
///  @return ethSent Amount of ETH sent to `_recipient` (may include previously received ETH)
function stake(uint256 _amount, address _lqtyFrom, bool _doSendRewards, address _recipient) external returns (uint256 lusdReceived, uint256 lusdSent, uint256 ethReceived, uint256 ethSent);;
```

### stakeViaPermit(uint256,address,struct PermitParams,bool,address)

- **Signature**: `stakeViaPermit(uint256,address,struct PermitParams,bool,address)`
- **Visibility**: external
- **Source Range**: 2785:280:32

**Signature:**
```solidity
/// @notice Stakes a given amount of LQTY tokens in the V1 staking contract using a permit
///  @param _amount Amount of LQTY tokens to stake
///  @param _lqtyFrom Address from which to transfer the LQTY tokens
///  @param _permitParams Parameters for the permit data
///  @param _doSendRewards If true, send rewards claimed from LQTY staking
///  @param _recipient Address to which the tokens should be sent
///  @return lusdReceived Amount of LUSD tokens received as a side-effect of staking new LQTY
///  @return lusdSent Amount of LUSD tokens sent to `_recipient` (may include previously received LUSD)
///  @return ethReceived Amount of ETH received as a side-effect of staking new LQTY
///  @return ethSent Amount of ETH sent to `_recipient` (may include previously received ETH)
function stakeViaPermit(uint256 _amount, address _lqtyFrom, PermitParams calldata _permitParams, bool _doSendRewards, address _recipient) external returns (uint256 lusdReceived, uint256 lusdSent, uint256 ethReceived, uint256 ethSent);;
```

### unstake(uint256,bool,address)

- **Signature**: `unstake(uint256,bool,address)`
- **Visibility**: external
- **Source Range**: 3991:309:32

**Signature:**
```solidity
/// @notice Unstakes a given amount of LQTY tokens from the V1 staking contract and claims the accrued rewards
///  @param _amount Amount of LQTY tokens to unstake
///  @param _doSendRewards If true, send rewards claimed from LQTY staking
///  @param _recipient Address to which the tokens should be sent
///  @return lqtyReceived Amount of LQTY tokens actually unstaked (may be lower than `_amount`)
///  @return lqtySent Amount of LQTY tokens sent to `_recipient` (may include LQTY sent to the proxy from sources other than V1 staking)
///  @return lusdReceived Amount of LUSD tokens received as a side-effect of staking new LQTY
///  @return lusdSent Amount of LUSD tokens claimed (may include previously received LUSD)
///  @return ethReceived Amount of ETH received as a side-effect of staking new LQTY
///  @return ethSent Amount of ETH claimed (may include previously received ETH)
function unstake(uint256 _amount, bool _doSendRewards, address _recipient) external returns (uint256 lqtyReceived, uint256 lqtySent, uint256 lusdReceived, uint256 lusdSent, uint256 ethReceived, uint256 ethSent);;
```

### staked()

- **Signature**: `staked()`
- **Visibility**: external
- **Source Range**: 4450:50:32

**Signature:**
```solidity
/// @notice Returns the current amount LQTY staked by a user in the V1 staking contract
///  @return staked Amount of LQTY tokens staked
function staked() external view returns (uint256);;
```
