# Function: swapToBold(uint256,uint256)

**Contract**: [src/Zappers/Modules/Exchanges/CurveExchange.sol/contract_CurveExchange.md]

## Metadata

- **Contract**: CurveExchange
- **Signature**: `swapToBold(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 1640:779:297

## Implementation

```solidity
function swapToBold(uint256 _collAmount, uint256 _minBoldAmount) external returns (uint256) {
    ICurvePool curvePoolCached = curvePool;
    uint256 initialCollBalance = collToken.balanceOf(address(this));
    collToken.safeTransferFrom(msg.sender, address(this), _collAmount);
    collToken.approve(address(curvePoolCached), _collAmount);
    uint256 output = curvePoolCached.exchange(COLL_TOKEN_INDEX, BOLD_TOKEN_INDEX, _collAmount, _minBoldAmount);
    boldToken.transfer(msg.sender, output);
    uint256 currentCollBalance = collToken.balanceOf(address(this));
    if (currentCollBalance > initialCollBalance) {
        collToken.safeTransfer(msg.sender, currentCollBalance - initialCollBalance);
    }
    return output;
}
```

## External Calls

- **IERC20::balanceOf(address)**
- **IERC20::safeTransferFrom(contract IERC20,address,address,uint256)**
- **IERC20::approve(address,uint256)**
- **ICurvePool::exchange(uint256,uint256,uint256,uint256)**
- **IBoldToken::transfer(address,uint256)**
- **IERC20::safeTransfer(contract IERC20,address,uint256)**

## Native Transfers

- **boldToken** (state variable) [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]

## State Variable Reads

- **curvePool** (`contract ICurvePool`) [src/Zappers/Modules/Exchanges/Curve/ICurvePool.sol/interface_ICurvePool.md]
- **collToken** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **COLL_TOKEN_INDEX** (`uint256`)
- **BOLD_TOKEN_INDEX** (`uint256`)
- **boldToken** (`contract IBoldToken`) [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: CurveExchange.swapToBold(uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
