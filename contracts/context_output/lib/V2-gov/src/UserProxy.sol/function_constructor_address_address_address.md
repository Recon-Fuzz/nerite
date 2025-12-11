# Function: constructor(address,address,address)

**Contract**: [lib/V2-gov/src/UserProxy.sol/contract_UserProxy.md]

## Metadata

- **Contract**: UserProxy
- **Signature**: `constructor(address,address,address)`
- **Visibility**: public
- **Source Range**: 703:207:24

## Implementation

```solidity
constructor(address _lqty, address _lusd, address _stakingV1) {
    lqty = IERC20(_lqty);
    lusd = IERC20(_lusd);
    stakingV1 = ILQTYStaking(_stakingV1);
    stakingV2 = msg.sender;
}
```

## State Variable Writes

- **lqty** (`contract IERC20`) [lib/V2-gov/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **lusd** (`contract IERC20`) [lib/V2-gov/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **stakingV1** (`contract ILQTYStaking`) [lib/V2-gov/src/interfaces/ILQTYStaking.sol/interface_ILQTYStaking.md]
- **stakingV2** (`address`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: UserProxy.constructor(address,address,address) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: UserProxy
```
