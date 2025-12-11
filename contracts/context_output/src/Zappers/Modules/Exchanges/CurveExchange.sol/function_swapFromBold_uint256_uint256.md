# Function: swapFromBold(uint256,uint256)

**Contract**: [src/Zappers/Modules/Exchanges/CurveExchange.sol/contract_CurveExchange.md]

## Metadata

- **Contract**: CurveExchange
- **Signature**: `swapFromBold(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 899:735:297

## Implementation

```solidity
function swapFromBold(uint256 _boldAmount, uint256 _minCollAmount) external {
    ICurvePool curvePoolCached = curvePool;
    uint256 initialBoldBalance = boldToken.balanceOf(address(this));
    boldToken.transferFrom(msg.sender, address(this), _boldAmount);
    boldToken.approve(address(curvePoolCached), _boldAmount);
    uint256 output = curvePoolCached.exchange(BOLD_TOKEN_INDEX, COLL_TOKEN_INDEX, _boldAmount, _minCollAmount);
    collToken.safeTransfer(msg.sender, output);
    uint256 currentBoldBalance = boldToken.balanceOf(address(this));
    if (currentBoldBalance > initialBoldBalance) {
        boldToken.transfer(msg.sender, currentBoldBalance - initialBoldBalance);
    }
}
```

## External Calls

- **IBoldToken::balanceOf(address)**
- **IBoldToken::transferFrom(address,address,uint256)**
- **IBoldToken::approve(address,uint256)**
- **ICurvePool::exchange(uint256,uint256,uint256,uint256)**
- **IERC20::safeTransfer(contract IERC20,address,uint256)**
- **IBoldToken::transfer(address,uint256)**

## Native Transfers

- **boldToken** (state variable) [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]

## State Variable Reads

- **curvePool** (`contract ICurvePool`) [src/Zappers/Modules/Exchanges/Curve/ICurvePool.sol/interface_ICurvePool.md]
- **boldToken** (`contract IBoldToken`) [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]
- **BOLD_TOKEN_INDEX** (`uint256`)
- **COLL_TOKEN_INDEX** (`uint256`)
- **collToken** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: CurveExchange.swapFromBold(uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
