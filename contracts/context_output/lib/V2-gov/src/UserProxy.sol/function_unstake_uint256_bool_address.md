# Function: unstake(uint256,bool,address)

**Contract**: [lib/V2-gov/src/UserProxy.sol/contract_UserProxy.md]

## Metadata

- **Contract**: UserProxy
- **Signature**: `unstake(uint256,bool,address)`
- **Visibility**: external
- **Source Range**: 2672:1057:24

## Implementation

```solidity
/// @inheritdoc IUserProxy
function unstake(uint256 _amount, bool _doSendRewards, address _recipient) external onlyStakingV2() returns (uint256 lqtyReceived, uint256 lqtySent, uint256 lusdReceived, uint256 lusdSent, uint256 ethReceived, uint256 ethSent) {
    uint256 initialLQTYAmount = lqty.balanceOf(address(this));
    uint256 initialLUSDAmount = lusd.balanceOf(address(this));
    uint256 initialETHAmount = address(this).balance;
    stakingV1.unstake(_amount);
    lqtySent = lqty.balanceOf(address(this));
    uint256 lusdAmount = lusd.balanceOf(address(this));
    uint256 ethAmount = address(this).balance;
    lqtyReceived = lqtySent - initialLQTYAmount;
    lusdReceived = lusdAmount - initialLUSDAmount;
    ethReceived = ethAmount - initialETHAmount;
    if (lqtySent > 0) lqty.transfer(_recipient, lqtySent);
    if (_doSendRewards) (lusdSent, ethSent) = _sendRewards(_recipient, lusdAmount, ethAmount);
}
```

## Related Implementations

### _sendRewards(address,uint256,uint256)

- **Kind**: internal
- **Source**: 3735:447:24
- **Link**: `lib/V2-gov/src/UserProxy.sol:UserProxy:_sendRewards(address,uint256,uint256)`

```solidity
function _sendRewards(address _recipient, uint256 _lusdAmount, uint256 _ethAmount) internal returns (uint256 lusdSent, uint256 ethSent) {
    if (_lusdAmount > 0) lusd.transfer(_recipient, _lusdAmount);
    if (_ethAmount > 0) {
        (bool success, ) = payable(_recipient).call{value: _ethAmount}("");
        require(success, "UserProxy: eth-fail");
    }
    return (_lusdAmount, _ethAmount);
}
```

### onlyStakingV2()

- **Kind**: modifier
- **Source**: 916:120:24
- **Link**: `lib/V2-gov/src/UserProxy.sol:UserProxy:onlyStakingV2()`

```solidity
modifier onlyStakingV2() {
    require(msg.sender == stakingV2, "UserProxy: caller-not-stakingV2");
    _;
}
```

## External Calls

- **IERC20::balanceOf(address)**
- **ILQTYStaking::unstake(uint256)**
- **IERC20::transfer(address,uint256)**
- **unknown::unknown**

## Native Transfers

- **lqty** (state variable) [lib/V2-gov/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

## State Variable Reads

- **lqty** (`contract IERC20`) [lib/V2-gov/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **lusd** (`contract IERC20`) [lib/V2-gov/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **stakingV1** (`contract ILQTYStaking`) [lib/V2-gov/src/interfaces/ILQTYStaking.sol/interface_ILQTYStaking.md]
- **stakingV2** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UserProxy.unstake(uint256,bool,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: UserProxy._sendRewards(address,uint256,uint256) (NodeID: 1)
  │   💬 Args: [_recipient, lusdAmount, ethAmount]
  │   👁️  Def: internal
  └─ [1] 🔒 MODIFIER: UserProxy.onlyStakingV2() (NodeID: 2)
      💬 Args: [no args]
```

## Documentation

### Function Documentation

@inheritdoc IUserProxy

### Interface Documentation

@notice Unstakes a given amount of LQTY tokens from the V1 staking contract and claims the accrued rewards
 @param _amount Amount of LQTY tokens to unstake
 @param _doSendRewards If true, send rewards claimed from LQTY staking
 @param _recipient Address to which the tokens should be sent
 @return lqtyReceived Amount of LQTY tokens actually unstaked (may be lower than `_amount`)
 @return lqtySent Amount of LQTY tokens sent to `_recipient` (may include LQTY sent to the proxy from sources other than V1 staking)
 @return lusdReceived Amount of LUSD tokens received as a side-effect of staking new LQTY
 @return lusdSent Amount of LUSD tokens claimed (may include previously received LUSD)
 @return ethReceived Amount of ETH received as a side-effect of staking new LQTY
 @return ethSent Amount of ETH claimed (may include previously received ETH)
